	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext - Compute groups/vehicles in the locations
	// create a radio tower

	if (!isServer) exitWith{};

	private [
		"_marker", 
		"_position",
		"_type"
	];

	_position = _this select 0;

	_type = wcradiotype call BIS_fnc_selectRandom;
	
	wcradio = createVehicle [_type, _position, [], 0, "NONE"];

	if(wcwithradiomarkers == 1) then {
		_marker = ['radiotower', 0.5, position wcradio, 'ColorRED', 'ICON', 'FDIAGONAL', 'mil_triangle', 0, 'Radio site', false] call WC_fnc_createmarker;
	};

	wcradio setVectorUp [0,0,1];
	wcradio addeventhandler ['HandleDamage', {
		if (_this select 2 > wcdammagethreshold) then {
			wcradio removeAllEventHandlers "HandleDamage";
			wcradioalive = false;
			["wcradioalive", "client"] call WC_fnc_publicvariable;
			wcradio setdamage 1;
			wcmessageW = ["Radio tower", localize "STR_WC_MESSAGEHASBEENDESTROYED"];
			if!(isDedicated) then { wcgarbage = wcmessageW spawn EXT_fnc_infotext;};
			["wcmessageW", "client"] call WC_fnc_publicvariable;
			diag_log "WARCONTEXT: RADIO TOWER HAS BEEN DESTROYED";
		};
		(_this select 2);
	}];	
	diag_log format["WARCONTEXT: CREATE A RADIO TOWER: %1", _type];


	// Check for an electrical outage		
	if(random 1 < wcenemyglobalelectrical) then {
		wcradioalive = true;
		["wcradioalive", "client"] call WC_fnc_publicvariable;
		if(random 1 > 20) then {
			wcgarbage = [_vehicle] spawn WC_fnc_protectobject;
		};
	} else {
		wcmessageW = ["Radio tower", "Electrical outage"];
		if!(isDedicated) then { wcgarbage = wcmessageW spawn EXT_fnc_infotext;};
		["wcmessageW", "client"] call WC_fnc_publicvariable;
		wcradio setdamage 1;
	};