	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext - civilian sabotage friendly vehicles

	 private [
		"_count",
		"_distancemax",
		"_missioncomplete",
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

	wcpropagander = wcpropagander + [_unit];

	diag_log format["WARCONTEXT: BUILD 1 SABOTER - fame: %1", wcfame];

	_position = (position _unit) findEmptyPosition [8, 100];
	if(count _position == 0) then {
		diag_log "WARCONTEXT: NO FOUND EMPTY POSITION FOR CIVILIAN SABOTER";
	} else {
		_unit setpos _position;
	};

	WC_fnc_findtargetvehicle = {
		private ["_unit", "_target", "_vehicles"];
		_unit = _this select 0;

		_target = objnull;
		_vehicles = nearestObjects[_unit,["LandVehicle"], 600];
		{
			if!(vehiclevarname _x == "") then {
				if(format["%1", (_x getvariable "wcsabotage")] == "<null>") then {
					_target = _x;
				};
			};
		}foreach _vehicles;
		_target;
	};

	_target = [_unit] call WC_fnc_findtargetvehicle;

	_missioncomplete = false;

	while { ((alive _unit) and (!_missioncomplete)) } do {
		if!(isnull _target) then {
			if( west countside (nearestObjects[_target,["Man"], 30]) > 0) then {
				_unit setvariable ["civilrole", "civil", true];
			} else {
				_unit setvariable ["civilrole", "saboter", true];
			};
			_unit setvariable ["target", _target, false];
			if (_target distance _unit < 600) then {
				if(_unit distance _target > 7) then {
					_unit stop false;
					_position = position _target;
					_unit domove _position;
					_unit setvariable ["destination", _position, false];
				} else {
					for "_i" from 0 to 4 do {
						if(alive _unit) then {
							_unit dowatch _target;
							sleep 3;
							_unit playMove "AinvPknlMstpSnonWnonDnon_medic_2";
							sleep 5;
						};
						_unit playMove "";
					};
					if((alive _unit) and (_unit distance _target < 10)) then {
						wcgarbage = [_target] spawn WC_fnc_nastyvehicleevent;
						_target setvariable ["wcsabotage", "saboted", false];
						_unit stop false;
						_target = [_unit] call WC_fnc_findtargetvehicle;
					};
				};
			};
		} else {
			_target = [_unit] call WC_fnc_findtargetvehicle;
			if(isnull _target) then {
				_unit setvariable ["civilrole", "civil", true];
			} else {
				_unit setvariable ["civilrole", "saboter", true];
			};
		};
		if((getmarkerpos "jail") distance _unit < 50) then {
			wcmessageW = ["Saboter", "A prisonner is in jail"];
			if!(isDedicated) then { wcgarbage = wcmessageW spawn EXT_fnc_infotext; };
			_unit setpos getmarkerpos "jail";
			[_unit] joinSilent group prisoner;
			_unit allowdammage false;
			_unit setUnitPos "Up"; 
			_unit playMoveNow "AmovPercMstpSnonWnonDnon_AmovPercMstpSsurWnonDnon";
			_unit stop true;
			_unit disableAI "MOVE";
			_unit disableAI "ANIM";
			_missioncomplete = true;
		};
		sleep 5;
	};