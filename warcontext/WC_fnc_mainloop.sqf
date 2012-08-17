	// -----------------------------------------------
	// Author: team  code34 nicolas_boiteux@yahoo.fr
	// warcontext - WIT 
	// -----------------------------------------------
	if (!isServer) exitWith{};

	private [
		"_count",
		"_location", 
		"_distance", 
		"_lastposition", 
		"_marker", 
		"_markername",
		"_position",
		"_vehicle",
		"_sanity",
		"_sanity2",
		"_sanity3",
		"_temp",
		"_index",
		"_intown",
		"_ambushcounter",
		"_position",
		"_ieds",
		"_active",
		"_numberofplayers",
		"_locationsneartarget",
		"_civillocation",
		"_vehicle",
		"_numberofgroup",
		"_numberofvehicle",
		"_fame"
		];

	if(isdedicated) then {
		diag_log format["WARCONTEXT: DEDICATED SERVER V%1", wcversion];
	} else {
		diag_log format["WARCONTEXT: PC V%1", wcversion];
	};

	_active = createTrigger["EmptyDetector", [0,0,0]];
	_active setTriggerArea[wcleaveareasizeatendofmission, wcleaveareasizeatendofmission, 0, false];
	_active setTriggerActivation["WEST", "PRESENT", TRUE];
	_active setTriggerStatements["this", "", ""];

	_sanity = createTrigger["EmptyDetector", wcmapcenter];
	_sanity setTriggerArea[20000, 20000, 0, false];
	_sanity setTriggerActivation["EAST", "PRESENT", TRUE];
	_sanity setTriggerStatements["this", "", ""];

	_sanity2 = createTrigger["EmptyDetector", wcmapcenter];
	_sanity2 setTriggerArea[20000, 20000, 0, false];
	_sanity2 setTriggerActivation["GUER", "PRESENT", TRUE];
	_sanity2 setTriggerStatements["this", "", ""];

	_sanity3 = createTrigger["EmptyDetector", wcmapcenter];
	_sanity3 setTriggerArea[20000, 20000, 0, false];
	_sanity3 setTriggerActivation["CIV", "PRESENT", TRUE];
	_sanity3 setTriggerStatements["this", "", ""];

	while { (wclevel < wclevelmax) and (wcteamscore < wcscorelimitmax)} do {

		// compute missions list
		wcgarbage = [] spawn WC_fnc_createlistofmissions;

		wccurrentmission = nil;
		wcmissionsuccess = false;
		wcnumberofkilledofmissionW = 0;
		wcnumberofkilledofmissionE = 0;
		wcnumberofkilledofmissionC = 0;
		wcnumberofkilledofmissionV = 0;
		wcteambonus = 0;

		_index = 0;
		_ambushcounter = 0;

		_count = 60;
		while {isnil "wccurrentmission"} do {
			_count = _count + 1;
			if(_count > 60) then {
				wcchoosemission = true;
				["wcchoosemission", "client"] call WC_fnc_publicvariable;
				["wclistofmissions", "client"] call WC_fnc_publicvariable;
				if!(isDedicated) then {
					if(wcchoosemission) then {
						wcmessageW = [localize "STR_WC_MESSAGEMISSIONCOMMANDEMENT", localize "STR_WC_MENUCHOOSEMISSION"];
						if!(isDedicated) then { wcmessageW spawn EXT_fnc_infotext; } else { ["wcmessageW", "client"] call WC_fnc_publicvariable;};
						if(isnil "wcchoosemissionmenu") then {
							wcchoosemissionmenu = player addAction ["<t color='#dddd00'>"+localize "STR_WC_MENUCHOOSEMISSION"+"</t>", "warcontext\dialogs\WC_fnc_createmenuchoosemission.sqf",[],6,false];
						};
					} else {
						player removeaction wcchoosemissionmenu;
						wcchoosemissionmenu = nil;
					};
				};
				_count = 0;
			};
			sleep 1;
		};

		//reset missions list
		wclistofmissions = [];

		// turn off player menu
		wcchoosemission = false;
		["wcchoosemission", "client"] call WC_fnc_publicvariable;
		
		// retrieve mission informations
		_missionnumber 		= wccurrentmission select 0;
		_name 			= wccurrentmission select 1;
		_objective 		= wccurrentmission select 2;
		_city 			= wccurrentmission select 3;
		_numberofgroup 		= wccurrentmission select 4;
		_numberofvehicle 	= wccurrentmission select 5;
		_position 		= wccurrentmission select 6;
		_location 		= createLocation ["Strategic", _position, 50, 50];
		wcmissionlocations 	= wcmissionlocations + [_location];
		_time 			= wccurrentmission select 7;
		_rain 			= wccurrentmission select 8;
		_fog 			= wccurrentmission select 9;
		_overcast 		= wccurrentmission select 10;
		wcmissiondone = wcmissiondone + [_missionnumber];

		if((_time select 3) < (date select 3)) then { wcday = wcday + 1; wcfame = wcfame - 0.15;};
		if((_time select 3) == (date select 3)) then { if((_time select 4) < (date select 4)) then { wcday = wcday + 1; wcfame = wcfame - 0.15; };};

		// Delete zones for next mission near this zone
		wclastmissionposition = _position;

		// Check if we are in town or not
		_buildings = nearestObjects [position _location, ["house"] , wcdistance];
		if (count _buildings < wcminimunbuildings) then { 
			wcgarbage = [_location] call WC_fnc_computeavillage;
			wcgarbage = [_location] spawn WC_fnc_popcivilian;
		};

		wcweather = [_rain, _fog, _overcast];
		100 setRain (wcweather select 0);
		100 setfog (wcweather select 1);
		100 setOvercast (wcweather select 2);

		if(wcskiptime > 0) then {
			wcdate = _time;
			if(isdedicated) then {
				setdate wcdate;
			};
			["wcdate", "client"] call WC_fnc_publicvariable;
			["wcday", "client"] call WC_fnc_publicvariable;
		};
		["wcweather", "client"] call WC_fnc_publicvariable;

		_active setpos _position;

		diag_log format ["WARCONTEXT: COMPUTING LOCATION %1", text _location];

		_marker = ['rescuezone', wcdistance, _position, 'ColorRED', 'ELLIPSE', 'FDIAGONAL', '', 0, '', false] call WC_fnc_createmarker;

		if(wcairopposingforce > 0) then {
			_airmarker = ['airzone', 2000, _position, 'ColorGREEN', 'ELLIPSE', 'FDIAGONAL', '', 0, '', false] call WC_fnc_createmarkerlocal;
		};

		if(wcwithmarkerongoal > 0) then {
			_marker2 = ['operationtext', 0.5, _position, 'ColorRED', 'ICON', 'FDIAGONAL', 'flag', 0, (localize (format["STR_WCSHORT_MISSION%1", _missionnumber])), false] call WC_fnc_createmarker;
		};

		wcselectedzone = _position;
		["wcselectedzone", "client"] call WC_fnc_publicvariable;

		// build bombing mortar
		if (random 1 < wcmortarprobability) then {
			wcgarbage = [_marker] spawn WC_fnc_mortar;
		};

		// build an antiair
		if(wcwithantiairsite > 0) then {
			for "_x" from 0 to ceil (random (wcaalevel - 1)) step 1 do {
				wcgarbage = [] spawn WC_fnc_antiair;
				sleep 0.05;
			};
		};
	
		// CREATE ENEMIES ON TARGET
		for "_x" from 1 to _numberofgroup step 1 do {
			_handle = [_marker, wcfactions call BIS_fnc_selectRandom, false] spawn WC_fnc_creategroup;
			sleep 2;
		};

		// CREATE ENEMIES VEHICLES ON TARGET
		for "_x" from 1 to _numberofvehicle step 1 do {
			_handle = [_marker, (wcvehicleslistE call BIS_fnc_selectRandom), true] spawn WC_fnc_creategroup;
			sleep 2;
		};

		// CREATE x CONVOY ON MAP
		for "_x" from 1 to wcconvoylevel step 1 do {
			_handle = [] spawn WC_fnc_createconvoy;
			sleep 2;
		};

		// SEND MISSION TEXT TO PLAYER
		if(isnil text _location) then {
			_city = nearestLocation [position _location, "NameCity"];
			wcmessageW = [format["Mission %1", wcmissioncount], format[localize "STR_WC_MESSAGENEAR", text _city], localize "STR_WC_MESSAGETAKISTANLOCALISED"];
		} else {
			wcmessageW = [format["Mission %1", wcmissioncount], format[localize "STR_WC_MESSAGEGOTO", text _location], localize "STR_WC_MESSAGETAKISTANLOCALISED"];
		};
		if!(isDedicated) then { wcmessageW spawn EXT_fnc_infotext; } else { ["wcmessageW","client"] call WC_fnc_publicvariable;};

		//wait for all initialisation
		sleep 10;

		// CREATE SIDE MISSION
		wcgarbage = [_missionnumber, _name] spawn WC_fnc_createsidemission;

		// CREATE ENEMIES ON OTHER ZONE NEAR SIDE MISSION
		wcgarbage = [_location] spawn WC_fnc_ambiantlife;
		if(wcreinforcmentlevel > 0) then { 
			wcgarbage = [_location, _marker] spawn WC_fnc_support;
		};

		if(wcwithcomposition == 1) then {
			wcgarbage = [_location] spawn WC_fnc_createcomposition;
		};

		if(wcwithstaticweapons == 1) then {
			wcgarbage = [_position] spawn WC_fnc_createstatic;
		};

		// Create ied in towns
		if(wcwithied > 0) then {
			if(random 1 > 0.9) then {
				wcgarbage = [_position] spawn WC_fnc_createiedintown;
			};
		};

		// create civils car
		_civillocation = nearestLocations [_position, ["NameCityCapital", "NameCity","NameVillage", "Name"], 8000];
		sleep 2;
		{	
			if(wcwithcivilcar > 0) then {
				wcgarbage = [_x] spawn WC_fnc_createcivilcar;
			};
			if(wcwithied > 0) then {
				if(random 1 > 0.9) then {
					wcgarbage = [position _x] spawn WC_fnc_createiedintown;
				};
			};
			if(wcwithminefield > 0) then {
				if(random 1 > 0.9) then {
					wcgarbage = [position _x] spawn WC_fnc_createminefield;
				};
			};
			sleep 1;
		}foreach _civillocation;

		if(wcwithmhq == 1) then {
			wcgarbage = [_position] spawn WC_fnc_createmhq;
		};

		// Wait until the end of Mission - use while instead of waituntil - performance leak
		while { !wcmissionsuccess } do { sleep 1; };
		wcmissionsuccess = false;

		"operationtext" setMarkerText "Mission is finished. Leave the zone";

		if(wcwithteleportflagatend == 1) then {
			_positionflag = (position _location) findemptyposition [10, 300];
			if(count _positionflag == 0) then {
				diag_log "WARCONTEXT: NO FOUND EMPTY POSITION FOR TELEPORT FLAG";
			};
			wcflag = "FlagCarrierUSA_EP1" createVehicle _positionflag;
			wcflag setvehicleinit "this allowdammage false; wcrtb = this addAction ['<t color=''#dddd00''>Teleport to base</t>', 'warcontext\actions\WC_fnc_doreturntobase.sqf',[],-1,false];";
			processInitCommands;
			_marker = [format['teleportflag%1',wcteleportindex], 0.5, _position, 'ColorGreen', 'ICON', 'FDIAGONAL', 'City', 0, '', false] call WC_fnc_createmarker;
			wcteleportindex = wcteleportindex + 1;
		};

		_numberofplayers = 100;
		_count = 0;
		while { _numberofplayers >= (ceil((playersNumber west) * wcleaversatendofmission)) } do {
			_list = list _active;
			{
				if !(isplayer _x) then { 
					_list = _list - [_x];
				};
				sleep 0.05;
			}foreach _list;
			_numberofplayers = count _list;
			sleep 10;
			if(_numberofplayers >= (ceil((playersNumber west) * wcleaversatendofmission))) then { 
				_count = _count + 1;
				if(_count > 10) then {
					_count = 0;
					wcmessageW = [format[localize "STR_WC_MESSAGEMISSIONCOMMANDEMENT", wclevel], localize "STR_WC_MESSAGELEAVEZONE"];
					if!(isDedicated) then { wcmessageW spawn EXT_fnc_infotext; } else { ["wcmessageW", "client"] call WC_fnc_publicvariable;};
				};
			};
		};

		// The mission is finished - All players are out of zone

		wcradio removeAllEventHandlers "HandleDamage";
		wcheavyfactory removeAllEventHandlers "HandleDamage";
		wcbarrack removeAllEventHandlers "HandleDamage";

		sleep 30;

		wcheavyfactory setdamage 1;
		wcbarrack setdamage 1;
		wcradio setdamage 1;
		deletevehicle wcradio;
		deletevehicle wcgenerator;

		deletemarker "rescuezone";
		deletemarker "operationtext";
		deletemarker "sidezone";
		deletemarker "bombzone";
		deletemarker "iedzone";
		deletemarker "radiotower";
		deletemarker "generator";
		deletemarkerlocal "airzone";

		wcmessageW = [format[localize "STR_WC_MESSAGEMISSIONFINISHED", wcmissioncount], localize "STR_WC_MESSAGNEXTSTEP"];
		if!(isDedicated) then { wcmessageW spawn EXT_fnc_infotext; } else { ["wcmessageW", "client"] call WC_fnc_publicvariable;};

		sleep 0.5;

		// PRINT STATS BEFORE SANITING MAP
		wcmessageW = ["Casualty", format["%1 East soldiers killed", wcnumberofkilledofmissionE]];
		if!(isDedicated) then { wcmessageW spawn EXT_fnc_infotext; } else { ["wcmessageW", "client"] call WC_fnc_publicvariable;};

		sleep 0.5;

		wcmessageW = ["Casualty", format["%1 West soldiers killed", wcnumberofkilledofmissionW]];
		if!(isDedicated) then { wcmessageW spawn EXT_fnc_infotext; } else { ["wcmessageW", "client"] call WC_fnc_publicvariable;};

		sleep 0.5;

		wcmessageW = ["Casualty", format["%1 Civils killed", wcnumberofkilledofmissionC]];
		if!(isDedicated) then { wcmessageW spawn EXT_fnc_infotext; } else { ["wcmessageW", "client"] call WC_fnc_publicvariable;};

		sleep 0.5;

		wcmessageW = ["Casualty", format["%1 Vehicles destroyed", wcnumberofkilledofmissionV]];
		if!(isDedicated) then { wcmessageW spawn EXT_fnc_infotext; } else { ["wcmessageW", "client"] call WC_fnc_publicvariable;};

		sleep 0.5;

		if(ceil (wcfame * 100) > 75) then {
			_fame = "Very Good";
		} else {
			if(ceil (wcfame * 100) > 50) then {
			_fame = "Good";
			} else {
				if(ceil (wcfame * 100) > 25) then {
					_fame = "Bad";
				} else {
					_fame = "Ugly";
				};
			};
		};
		wcmessageW = ["Military intervention", format["%1 fame", _fame]];
		if!(isDedicated) then { wcmessageW spawn EXT_fnc_infotext; } else { ["wcmessageW", "client"] call WC_fnc_publicvariable;};

		sleep 0.5;

		// if arcade == 1
		if(wckindofgame == 1) then {
			wcteamplayscoretoadd = ceil((wcnumberofkilledofmissionE - wcnumberofkilledofmissionW + wclevel + wcteambonus + (wcnumberofkilledofmissionV * 3)) / (playersNumber west));
		} else {
			wcteamplayscoretoadd = ceil((wcnumberofkilledofmissionE - wcnumberofkilledofmissionW - wcnumberofkilledofmissionC + wclevel + wcteambonus + (wcnumberofkilledofmissionV * 3)) / (playersNumber west));
		};

		if(wcteamplayscoretoadd < 0) then { wcteamplayscoretoadd = 0;};

		// Send points to share
		if(wcleveltoadd > 0) then {
			if(wckindofgame == 1) then {
				wcteamscore = wcteamscore + 5;
			} else {
				wcteamscore = wcteamscore + 3;
			};
			if(local player) then {	wcteamplayscore = wcteamplayscoretoadd;	} else { ["wcteamplayscoretoadd", "client"] call WC_fnc_publicvariable; };
		};

		// SANITING MAP
		diag_log "WARCONTEXT: MISSION FINISHED - SANITING MAP";

		{
			_vehicle = _x;
			if(count (crew _vehicle) == 0) then {
				_vehicle setdamage 1; 
				deletevehicle _vehicle;
			};
			sleep 0.1;
		} foreach wcvehicles;

		_list = list _sanity;
		sleep 2;
		{
			if!(isplayer _x) then {
				if(format["%1", _x getvariable "wcprotected"] == "<null>") then {
					_x removeAllEventHandlers "killed";
					_x setdamage 1;
					deletevehicle _x;
					sleep 0.05;
				};
			};
			sleep 0.05;
		}foreach _list;

		_list = list _sanity2;
		sleep 2;
		{
			if!(isplayer _x) then {
				if(_x isKindOf "Man") then {
					if(format["%1", _x getvariable "wcprotected"] == "<null>") then {
						_x removeAllEventHandlers "killed";
						_x setdamage 1;
						deletevehicle _x;
						sleep 0.05;
					};
				};
			};
			sleep 0.05;
		}foreach _list;

		_list = list _sanity3;
		sleep 2;
		{
			if!(isplayer _x) then {
				if(_x isKindOf "Man") then {
					if(format["%1", _x getvariable "wcprotected"] == "<null>") then {
						_x removeAllEventHandlers "killed";
						_x setdamage 1;
						deletevehicle _x;
						sleep 0.05;
					};
				};
			};
			sleep 0.05;
		}foreach _list;

		{
			if((west countSide (crew _x)) == 0) then {
				if(format["%1", _x getvariable "wcprotected"] == "<null>") then {
					_x removeAllEventHandlers "killed";
					_x setdamage 1;
					deletevehicle _x;
				};
			};
			sleep 0.05;
		}foreach wcblinde;

		{
			if((west countSide (crew _x)) == 0) then {
				if(format["%1", _x getvariable "wcprotected"] == "<null>") then {
					_x removeAllEventHandlers "killed";
					_x setdamage 1;
					deletevehicle _x;
				};
			};
			sleep 0.05;
		}foreach wcunits;

		for "_x" from 1 to wcambiantindex step 1 do {
			call compile format["deletemarkerlocal ambiant%1;", _x];
			sleep 0.05;
		};

		for "_x" from 0 to _index step 1 do {
			call compile format ["deletevehicle trgambush%1;",_x]; 
			sleep 0.05;
		};

		{
			deleteMarkerLocal _x;
			sleep 0.05;
		}foreach wcambiantmarker;

		{
			deletevehicle _x;
			sleep 0.05;
		}foreach wcammobox;

		{
			if((west countSide (crew _x)) == 0) then {
				if(format["%1", _x getvariable "wcprotected"] == "<null>") then {
					_x removeAllEventHandlers "killed";
					_x setdamage 1;
					deletevehicle _x;
				};
			};
			sleep 0.05;
		}foreach wcobjecttodelete;

		{
			if(count(units _x) == 0) then {
				deletegroup _x;
			};
			sleep 0.05;
		}foreach allgroups;
	
		wcambiantindex = 0;

		wclevel = wclevel + wcleveltoadd;
		wcmissioncount = wcmissioncount + 1;
		wcleveltoadd = 0;
		wcskill = wcskill + 0.02;
		["wcskill", "client"] call WC_fnc_publicvariable;
		["wclevel", "client"] call WC_fnc_publicvariable;
		["wcmissioncount", "client"] call WC_fnc_publicvariable;
		["wcenemykilled", "client"] call WC_fnc_publicvariable;
		wcdistance = wcdistance + wcdistancegrowth;
		wcblinde = [];
		wcunits = [];
		wcvehicles = [];
		wcobjecttodelete = [];
		wcalert = 0;
		["wcalert", "client"] call WC_fnc_publicvariable;
		diag_log "WARCONTEXT: SANITING: MISSION IS FINISHED";
		sleep 60 + (random 120);
	};