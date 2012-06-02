	// -----------------------------------------------
	// Author: team  code34 nicolas_boiteux@yahoo.fr
	// warcontext - create support enemy base , and enemy troops
	// -----------------------------------------------
	if (!isServer) exitWith{};

	private[
		"_base", 
		"_enemy",
		"_location", 
		"_locationsneartarget",
		"_markerdest", 
		"_markersource", 
		"_positiondest",
		"_position",
		"_support",
		"_counter",
		"_factory",
		"_barrack",
		"_newlocation",
		"_numberofvehicle",
		"_numberofgroup"
		];

	_location 	= _this select 0;
	_markerdest 	= _this select 1;
	_positiondest	= getmarkerpos "rescuezone";
	_counter = 0;
	
	// CREATE SUPPORT
	_locationsneartarget = nearestLocations [position _location, ["NameCityCapital", "NameCity","NameVillage", "Name"], 3000];
	_locationsneartarget = _locationsneartarget - [_location];

	sleep 2;
	
	_newlocation = _locationsneartarget  call BIS_fnc_selectRandom;
	while { _location distance _newlocation < 1300 } do {
		_newlocation = _locationsneartarget  call BIS_fnc_selectRandom;
		sleep 0.5;
	};
	_location = _newlocation;

	_markersource = ["markersupport", 200, position _location, 'ColorBLACK', 'ELLIPSE', 'FDIAGONAL', 'EMPTY', 0, '', false] call WC_fnc_createmarkerlocal;

	// BUILD BARRACK SUPPORT
	_position = [_markersource, "onground", "onflat"] call WC_fnc_createpositioninmarker;
	wcbarrack = "Land_Barrack2_EP1" createVehicle _position;
	wcbarrack setdir (random 360);
	"respawn_east" setMarkerPos [_position select 0, _position select 1];

	// BUILD HEAVY FACTORY SUPPORT
	_position = [_markersource, "onground", "onflat"] call WC_fnc_createpositioninmarker;
	wcheavyfactory = "TK_WarfareBHeavyFactory_Base_EP1" createVehicle _position;
	wcheavyfactory setdir (random 360);
	diag_log "WARCONTEXT: BUILD 1 BARRACK & 1 HEAVY FACTORY FOR SUPPORT";

	_markerfactory = ["markerfactory", 0.5, position wcheavyfactory, 'ColorBLACK', 'ICON', 'FDIAGONAL', 'Camp', 0, 'Heavyfactory', false] call WC_fnc_createmarkerlocal;
	wcambiantmarker = wcambiantmarker + [_markerfactory];
	_markerbarrack = ["markerbarrack", 0.5, position wcbarrack, 'ColorBLACK', 'ICON', 'FDIAGONAL', 'Camp', 0, 'Barrack', false] call WC_fnc_createmarkerlocal;
	wcambiantmarker = wcambiantmarker + [_markerbarrack];

	_markerdest = ["markersupportdest", (wcdistance * 2), _positiondest, 'ColorBLACK', 'ELLIPSE', 'FDIAGONAL', 'EMPTY', 0, '', false] call WC_fnc_createmarkerlocal;

	if((diag_fps > wcminfpsonserver) and ((east countside allunits) + (resistance countside allunits) < ((playersNumber west) * 5 * wclevel))) then {
		diag_log "WARCONTEXT: CREATING 1 GROUP TO PROTECT OPFOR BASE";
		_handle = [_markersource, wcfactions call BIS_fnc_selectRandom, false] spawn WC_fnc_creategroup;
	};

	wcheavyfactory removeAllEventHandlers "HandleDamage";
	wcheavyfactory addeventhandler ['HandleDamage', {
		if (_this select 2 > wcdammagethreshold) then {
			wcheavyfactory removeAllEventHandlers "HandleDamage";
			wcheavyfactory setdamage 1;
			wcmessageW = ["Heavy Factory", "has been destroyed"];
			if!(isDedicated) then { wcmessageW spawn EXT_fnc_infotext; } else { ["wcmessageW", "client"] call WC_fnc_publicvariable;};
			diag_log "WARCONTEXT: HEAVY FACTORY HAS BEEN DESTROYED";
		};
	}];

	wcbarrack removeAllEventHandlers "HandleDamage";
	wcbarrack addeventhandler ['HandleDamage', {
		if (_this select 2 > wcdammagethreshold) then {
			wcbarrack removeAllEventHandlers "HandleDamage";
			wcbarrack setdamage 1;
			wcmessageW = ["Barrack", "has been destroyed"];
			if!(isDedicated) then { wcmessageW spawn EXT_fnc_infotext; } else { ["wcmessageW", "client"] call WC_fnc_publicvariable;};
			diag_log "WARCONTEXT: BARRACK HAS BEEN DESTROYED";
		};
	}];

	_factory = wcheavyfactory;
	_barrack = wcbarrack;

	while { ((getdammage _factory < 0.9) or (getdammage _barrack < 0.9)) } do {
		if(wcalert > 99 and wcradioalive) then {
				_support = false;

				if(random 1 > 0.5) then {
					if(getdammage _barrack < 0.9) then {
						for "_x" from 1 to ceil(random wcreinforcmentlevel) step 1 do {
							_enemy = nearestObjects[_factory,["Man", "LandVehicle"], 150];
							if(west countside _enemy == 0) then {
								if((diag_fps > wcminfpsonserver) and ((east countside allunits) + (resistance countside allunits) -50 < ((playersNumber west) * 5 * wclevel))) then {
									diag_log "WARCONTEXT: CALL 1 INFANTERY SUPPORT";
									_handle = [_markersource, _markerdest, wcsupportfaction, false] spawn WC_fnc_creategroupsupport;
									_support = true;
									sleep 4;
								};
							};
						};
					};
				} else {
					if(wcwithenemyvehicle == 0) then {
						if(getdammage _factory < 0.9) then {
							for "_x" from 1 to ceil(random wcreinforcmentlevel) step 1 do {	
								_enemy = nearestObjects[_factory,["Man", "LandVehicle"], 150];
								if(west countside _enemy == 0) then {
									if((diag_fps > wcminfpsonserver) and ((east countside allunits) + (resistance countside allunits) -50 < ((playersNumber west) * 5 * wclevel))) then {
										diag_log "WARCONTEXT: CALL 1 VEHICLE SUPPORT";
										_handle = [_markersource, _markerdest, (wcvehicleslistE call BIS_fnc_selectRandom), true] spawn WC_fnc_creategroupsupport;
										_support = true;
										sleep 4;
									};
								};
							};
						};
					};
				};

				if(_support) then { _counter = _counter + 1;};
				if(_counter > 3) then { 
					diag_log "WARCONTEXT: BOMBING IS AVALAIBLE";
					wcbombingavalaible = 1;
					["wcbombingavalaible", "client"] call WC_fnc_publicvariable;
					_counter = 0;
				};
				if(_support) then { 
					wcmessageW = [localize "STR_WC_MESSAGEMISSIONCOMMANDEMENT", localize "STR_WC_CALLREINFORCEMENT"];
					if!(isDedicated) then { wcmessageW spawn EXT_fnc_infotext; } else { ["wcmessageW", "client"] call WC_fnc_publicvariable;};
					sleep (600 - (wclevel * 20));
				};
		};
		sleep 1;
	};

	diag_log "WARCONTEXT: ALL SUPPORT BUILDINGS ARE DESTROYED";
	deletemarkerlocal _markersource;
	deletemarkerlocal _markerdest;