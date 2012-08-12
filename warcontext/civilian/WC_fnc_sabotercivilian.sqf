	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext - civilian do nasty thing

	 private [
		"_count",
		"_distancemax",
		"_needpropagander",
		"_number",
		"_position",
		"_sabotage",
		"_target",
		"_typeof",
		"_unit"
	];

	_unit = _this select 0;
	_needpropagander = true;

	{
		if(_x distance _unit < 500) then {
			_needpropagander = false;
		};
		if(isnull _x) then { wcpropagander = wcpropagander - [_x]; };
	}foreach wcpropagander;

	if (!_needpropagander) exitWith{};

	// create a new unit not depending of ALICE
	_position = position _unit;
	_typeof = typeof _unit;
	_unit removeAllEventHandlers "killed";
	_unit setpos [0,0];
	_unit setdamage 1;
	deletevehicle _unit;
	_group = creategroup civilian;
	_unit = _group createUnit [_typeof, [0,0], [], 0, "FORM"];
	_unit setpos _position;

	diag_log format["WARCONTEXT: BUILD 1 SABOTER - fame: %1", wcfame];

	wcpropagander = wcpropagander + [_unit];

	_unit allowfleeing 0;

	_position = (position _unit) findEmptyPosition [8, 100];
	if(count _position == 0) exitwith {
		diag_log "WARCONTEXT: NO FOUND EMPTY POSITION FOR CIVILIAN SABOTER";
	};

	_unit setpos _position;

	WC_fnc_findtargetvehicle = {
		private ["_unit", "_target", "_vehicles"];
		_unit = _this select 0;
		_target = nil;
		_vehicles = nearestObjects[position _unit,["LandVehicle"], 600];
		{
			if!(vehiclevarname _x == "") then {
				_target = _x;
			};
		}foreach _vehicles;
		_target;
	};

	_count = 0;
	_target = [_unit] call WC_fnc_findtargetvehicle;
	while { ((alive _unit) and (_count < 30)) } do {
		if!(isnil "_target") then {
			_count = 0;
			_sabotage = format["%1", _target getvariable "wcsabotage"];
			if((_sabotage == "<null>" ) and (_target distance _unit < 600))then {
				if(_unit distance _target > 7) then {
					_unit domove position _target;
				} else {
					for "_i" from 0 to 5 do {
						_unit dowatch _target;
						sleep 5;
						_unit playMove "AinvPknlMstpSlayWrflDnon_medic";
						sleep 10;
					};
					if((alive _unit) and (_unit distance _target < 10)) then {
						wcgarbage = [_target] spawn WC_fnc_nastyvehicleevent;
						_target setvariable ["wcsabotage", true];
					};
				};
			} else {
				_target = [_unit] call WC_fnc_findtargetvehicle;
			};
		} else {
			_count = _count + 1;
			_target = [_unit] call WC_fnc_findtargetvehicle;
		};
		sleep 4;
	};