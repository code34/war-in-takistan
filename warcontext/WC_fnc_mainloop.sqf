	// -----------------------------------------------
	// Author: team =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// warcontext - WIT 
	// -----------------------------------------------
	if (!isServer) exitWith{};

	#include "common.hpp"

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
	_active setTriggerArea[1000, 1000, 0, false];
	_active setTriggerActivation["WEST", "PRESENT", TRUE];
	_active setTriggerStatements["this", "", ""];

	_sanity = createTrigger["EmptyDetector", [8000,8000,0]];
	_sanity setTriggerArea[20000, 20000, 0, false];
	_sanity setTriggerActivation["EAST", "PRESENT", TRUE];
	_sanity setTriggerStatements["this", "", ""];

	_sanity2 = createTrigger["EmptyDetector", [8000,8000,0]];
	_sanity2 setTriggerArea[20000, 20000, 0, false];
	_sanity2 setTriggerActivation["GUER", "PRESENT", TRUE];
	_sanity2 setTriggerStatements["this", "", ""];

	_sanity3 = createTrigger["EmptyDetector", [8000,8000,0]];
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
						if!(isDedicated) then { wcmessageW spawn WC_fnc_infotext; } else { ["wcmessageW", "client"] call WC_fnc_publicvariable;};
						if(isnil "wcchoosemissionmenu") then {
							wcchoosemissionmenu = player addAction ["<t color='#dddd00'>"+localize "STR_WC_MENUCHOOSEMISSION"+"</t>", "warcontext\WC_fnc_openmission.sqf",[],6,false];
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
		{
			if((position _x) distance (position _location) < 1500) then {
				wctownlocations = wctownlocations - [_x];
			};
		}foreach wctownlocations;

		// Check if we are in town or not
		_buildings = nearestObjects [position _location, ["house"] , wcdistance];
		if (count _buildings < 20) then { 
			_intown = false;
			wcgarbage = [_location] call WC_fnc_computeavillage;
		} else {
			_intown = true;
		};

		wcweather = [_rain, _fog, _overcast];
		600 setRain (wcweather select 0);
		600 setfog (wcweather select 1);
		600 setOvercast (wcweather select 2);

		wcdate = _time;
		if(isdedicated) then {
			setdate wcdate;
			["wcdate", "client"] call WC_fnc_publicvariable;
			["wcday", "client"] call WC_fnc_publicvariable;
			["wcweather", "client"] call WC_fnc_publicvariable;
		} else {
			wcgarbage = [] spawn WC_fnc_fasttime;
		};

		_active setpos _position;

		diag_log format ["WARCONTEXT: COMPUTING LOCATION %1", text _location];

		_marker = ['rescuezone', wcdistance, _position, 'ColorRED', 'ELLIPSE', 'FDIAGONAL', '', 0, '', false] call WC_fnc_createmarker;

		if(wcwithmarkerongoal > 0) then {
			_marker2 = ['operationtext', 0.5, _position, 'ColorRED', 'ICON', 'FDIAGONAL', 'flag', 0, (localize (format["STR_WCSHORT_MISSION%1", _missionnumber])), false] call WC_fnc_createmarker;
		};

		wcselectedzone = _position;
		["wcselectedzone", "client"] call WC_fnc_publicvariable;

		if (random 1 > 0.80) then {
			wcgarbage = [_marker] spawn WC_fnc_mortar;
		};

		if(random 1 > 0.95) then {
			_position = [[8000,8000],[0,0],"onmount"] call WC_fnc_createposition;
			_position = [_position select 0, _position select 1, 500];
			if(random 1 > 0.5) then {
				_plane = ["AV8B2", "A10_US_EP1"] call BIS_fnc_selectRandom;
				_arrayofvehicle =[_position, 0, _plane , west] call BIS_fnc_spawnVehicle;
				diag_log "WARCONTEXT: CREATE A FRIENDLY PLANE";
			} else {
				_plane = ["Su39","Su25_TK_EP1"] call BIS_fnc_selectRandom;
				_arrayofvehicle =[_position, 0, _plane , east] call BIS_fnc_spawnVehicle;
				diag_log "WARCONTEXT: CREATE AN ENEMY PLANE";
			};
		};

		wcradio = createVehicle ["TK_WarfareBUAVterminal_EP1", ["rescuezone", "onground", "onflat"] call WC_fnc_createpositioninmarker, [], 0, "NONE"];
		_markerradio = ['radiotower', 0.5, position wcradio, 'ColorRED', 'ICON', 'FDIAGONAL', 'mil_triangle', 0, 'Radio site', false] call WC_fnc_createmarker;

		wcradio setVectorUp [0,0,1];
		wcradio addeventhandler ['HandleDamage', {
			if (_this select 2 > wcdammagethreshold) then {
				wcradio removeAllEventHandlers "HandleDamage";
				wcradioalive = false;
				["wcradioalive", "client"] call WC_fnc_publicvariable;
				wcradio setdamage 1;
				wcmessageW = ["Radio tower", localize "STR_WC_MESSAGEHASBEENDESTROYED"];
				if!(isDedicated) then { wcmessageW spawn WC_fnc_infotext; } else { ["wcmessageW", "client"] call WC_fnc_publicvariable;};
				diag_log "WARCONTEXT: RADIO TOWER HAS BEEN DESTROYED";
			};
		}];

		if(_intown) then {
			_temp = (["rescuezone", "onground", "onflat"] call WC_fnc_createpositioninmarker) findEmptyPosition [2, 20];
			_generator = "PowerGenerator_EP1" createvehicle _temp;
			_generator setVehicleInit "this addAction ['<t color=''#ff4500''>Sabotage</t>', 'warcontext\WC_fnc_dosabotage.sqf',[true],-1,false];";
			_generator setdir ((getdir wcradio) + 180);
			processInitCommands;
		};
		
		if(random 1 < wcenemyglobalelectrical) then {
			wcradioalive = true;
			["wcradioalive", "client"] call WC_fnc_publicvariable;
		} else {
			wcmessageW = ["Radio tower", "Electrical outage"];
			if!(isDedicated) then { wcmessageW spawn WC_fnc_infotext; } else { ["wcmessageW", "client"] call WC_fnc_publicvariable;};
			wcradio setdamage 1;
		};
		
		// CREATE ENEMIES ON TARGET
		for "_x" from 1 to _numberofgroup step 1 do {
			_handle = [_marker, wcfactions call BIS_fnc_selectRandom, false] spawn WC_fnc_creategroup;
			sleep 2;
		};

		for "_x" from 1 to _numberofvehicle step 1 do {
			_handle = [_marker, (wcvehicleslistE call BIS_fnc_selectRandom), true] spawn WC_fnc_creategroup;
			sleep 2;
		};

		if(isnil text _location) then {
			_city = nearestLocation [position _location, "NameCity"];
			wcmessageW = [format["Mission %1", wcmissioncount], format[localize "STR_WC_MESSAGENEAR", text _city], localize "STR_WC_MESSAGETAKISTANLOCALISED"];
		} else {
			wcmessageW = [format["Mission %1", wcmissioncount], format[localize "STR_WC_MESSAGEGOTO", text _location], localize "STR_WC_MESSAGETAKISTANLOCALISED"];
		};
		if!(isDedicated) then { wcmessageW spawn WC_fnc_infotext; } else { ["wcmessageW","client"] call WC_fnc_publicvariable;};

		//wait for all initialisation
		sleep 10;

		// CREATE SIDE MISSION
		wcgarbage = [_missionnumber, _name] spawn WC_fnc_createsidemission;
		wcgarbage = [_location] spawn WC_fnc_ambiantlife;
		if(wcwithreinforcment == 1) then { 
			wcgarbage = [_location, _marker] spawn WC_fnc_support;
		};
		wcgarbage = [_location] spawn WC_fnc_createbunker;
		wcgarbage = [_position] spawn WC_fnc_createstatic;
		wcgarbage = [_position] spawn WC_fnc_createiedintown;

		// create civils car
		_civillocation = nearestLocations [_position, ["NameCityCapital", "NameCity","NameVillage", "Name"], 8000];
		sleep 2;
		{		
			wcgarbage = [_x] spawn WC_fnc_createcivilcar;
			wcgarbage = [position _x] spawn WC_fnc_createiedintown;
		}foreach _civillocation;

		if(wcwithteleporthq == 1) then {
			wcgarbage = [_position] spawn WC_fnc_createteleporthq;
		};

		// Wait until the end of Mission
		waituntil {wcmissionsuccess};
		wcmissionsuccess = false;

		if(wcwithteleportflagatend == 1) then {
			_positionflag = (position _location) findemptyposition [10, 300];
			wcflag = "FlagCarrierUSA_EP1" createVehicle _positionflag;
			wcflag setvehicleinit "this allowdammage false; wcrtb = this addAction ['<t color=''#dddd00''>Teleport to base</t>', 'warcontext\WC_fnc_returntobase.sqf',[],-1,false];";
			processInitCommands;
			_marker = [format['teleportflag%1',wcteleportindex], 0.5, _position, 'ColorGreen', 'ICON', 'FDIAGONAL', 'City', 0, '', false] call WC_fnc_createmarker;
			wcteleportindex = wcteleportindex + 1;
		};

		_numberofplayers = 100;
		_count = 0;
		while { _numberofplayers >= (ceil((playersNumber west) * 0.2)) } do {
			_list = list _active;
			{
				if !(isplayer _x) then { 
					_list = _list - [_x];
				};
			}foreach _list;
			_numberofplayers = count _list;
			sleep 10;
			if(_numberofplayers >= (ceil((playersNumber west) * 0.2))) then { 
				_count = _count + 1;
				if(_count > 10) then {
					_count = 0;
					wcmessageW = [format[localize "STR_WC_MESSAGEMISSIONCOMMANDEMENT", wclevel], localize "STR_WC_MESSAGELEAVEZONE"];
					if!(isDedicated) then { wcmessageW spawn WC_fnc_infotext; } else { ["wcmessageW", "client"] call WC_fnc_publicvariable;};
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

		deletemarker "rescuezone";
		deletemarker "operationtext";
		deletemarker "sidezone";
		deletemarker "bombzone";
		deletemarker "iedzone";
		deletemarker "radiotower";

		wcmessageW = [format[localize "STR_WC_MESSAGEMISSIONFINISHED", wclevel], localize "STR_WC_MESSAGNEXTSTEP"];
		if!(isDedicated) then { wcmessageW spawn WC_fnc_infotext; } else { ["wcmessageW", "client"] call WC_fnc_publicvariable;};

		sleep 0.5;

		// PRINT STATS BEFORE SANITING MAP
		wcmessageW = ["Casualty", format["%1 East soldiers killed", wcnumberofkilledofmissionE]];
		if!(isDedicated) then { wcmessageW spawn WC_fnc_infotext; } else { ["wcmessageW", "client"] call WC_fnc_publicvariable;};

		sleep 0.5;

		wcmessageW = ["Casualty", format["%1 West soldiers killed", wcnumberofkilledofmissionW]];
		if!(isDedicated) then { wcmessageW spawn WC_fnc_infotext; } else { ["wcmessageW", "client"] call WC_fnc_publicvariable;};

		sleep 0.5;

		wcmessageW = ["Casualty", format["%1 Civils killed", wcnumberofkilledofmissionC]];
		if!(isDedicated) then { wcmessageW spawn WC_fnc_infotext; } else { ["wcmessageW", "client"] call WC_fnc_publicvariable;};

		sleep 0.5;

		wcmessageW = ["Casualty", format["%1 Vehicles destroyed", wcnumberofkilledofmissionV]];
		if!(isDedicated) then { wcmessageW spawn WC_fnc_infotext; } else { ["wcmessageW", "client"] call WC_fnc_publicvariable;};

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
					if(ceil (wcfame * 100) > 0) then {
						_fame = "Ugly";
					};
				};
			};
		};
		wcmessageW = ["Military intervention", format["%1 fame", _fame]];
		if!(isDedicated) then { wcmessageW spawn WC_fnc_infotext; } else { ["wcmessageW", "client"] call WC_fnc_publicvariable;};

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
		}foreach _list;

		{
			if((west countSide (crew _x)) == 0) then {
				if(format["%1", _x getvariable "wcprotected"] == "<null>") then {
					_x removeAllEventHandlers "killed";
					_x setdamage 1;
					deletevehicle _x;
				};
			};
		}foreach wcblinde;

		{
			if((west countSide (crew _x)) == 0) then {
				if(format["%1", _x getvariable "wcprotected"] == "<null>") then {
					_x removeAllEventHandlers "killed";
					_x setdamage 1;
					deletevehicle _x;
				};
			};
		}foreach wcunits;

		for "_x" from 1 to wcambiantindex step 1 do {
			call compile format["deletemarkerlocal ambiant%1;", _x];
		};

		for "_x" from 0 to _index step 1 do {
			call compile format ["deletevehicle trgambush%1;",_x]; 
		};

		{
			deleteMarkerLocal _x;
		}foreach wcambiantmarker;

		{
			deletevehicle _x;
		}foreach wcammobox;

		{
			if((west countSide (crew _x)) == 0) then {
				if(format["%1", _x getvariable "wcprotected"] == "<null>") then {
					_x removeAllEventHandlers "killed";
					_x setdamage 1;
					deletevehicle _x;
				};
			};
		}foreach wcobjecttodelete;

		{
			if(count(units _x) == 0) then {
				deletegroup _x;
			};
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