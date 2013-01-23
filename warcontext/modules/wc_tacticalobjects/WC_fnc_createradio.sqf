	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext - Compute groups/vehicles in the locations
	// create a radio tower

	if (!isServer) exitWith{};

	private [
		"_marker", 
		"_position",
		"_radio",
		"_radiotype",
		"_type"
	];

	_position = _this select 0;
	_radiotype = _this select 1;

	_type = _radiotype call BIS_fnc_selectRandom;
	
	_radio = createVehicle [_type, _position, [], 0, "NONE"];

	if(wcwithradiomarkers == 1) then {
		_marker = ['radiotower', 0.5, position _radio, 'ColorRED', 'ICON', 'FDIAGONAL', 'mil_triangle', 0, 'Radio site', false] call WC_fnc_createmarker;
	};

	_radio setVectorUp [0,0,1];
	_radio addeventhandler ['HandleDamage', {
		if (_this select 2 > wcdammagethreshold) then {
			wcradio removeAllEventHandlers "HandleDamage";
			wcradioalive = false;
			["wcradioalive", "client"] call WC_fnc_publicvariable;
			wcradio setdamage 1;
			wcmessageW = ["Radio tower", localize "STR_WC_MESSAGEHASBEENDESTROYED"];
			["wcmessageW", "client"] call WC_fnc_publicvariable;
			diag_log "WARCONTEXT: RADIO TOWER HAS BEEN DESTROYED";
		};
		(_this select 2);
	}];	
	diag_log format["WARCONTEXT: CREATE A RADIO TOWER: %1", _type];
	
	if(random 1 > 0.20) then {
		wcgarbage = [_radio] spawn WC_fnc_protectobject;
	};


	// Check for an electrical outage		
	if(random 1 < wcenemyglobalelectrical) then {
		wcradioalive = true;
		["wcradioalive", "client"] call WC_fnc_publicvariable;
		if(random 1 > 0.20) then {
			wcgarbage = [_radio] spawn WC_fnc_protectobject;
		};
	} else {
		wcmessageW = ["Radio tower", "Electrical outage"];
		["wcmessageW", "client"] call WC_fnc_publicvariable;
		_radio setdamage 1;
	};

	_radio;