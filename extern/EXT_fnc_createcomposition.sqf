	/*
	Original Script 
	objectMapper.sqf Author: Joris-Jan van 't Land
	Edited by armatec
	
		Description:
		Takes an array of data about a dynamic object template and creates the objects.
	
		Parameter(s):
		_this select 0: compositions name - "fuelDepot_us"
		_this select 1: Direction in degrees - Number 
		_this select 2: Location to start
		
		Example:
		["fuelDepot_us", 0, getpos player] execVM "Createcomposition.sqf";
	*/

	private ["_multiplyMatrixFunc", "_group", "_markername", "_leader", "_markersize", "_pos", "_scriptinit", "_marker", "_soldier"];

	_script = _this select 0;
	_azi 	= _this select 1;
	_pos 	= _this select 2;
	_objs = [];
	_objs = call (compile (preprocessFileLineNumbers format ["\CA\modules\DynO\data\scripts\compositions\%1.sqf",_script]));
	private ["_posX", "_posY"];
	_posX = _pos select 0;
	_posY = _pos select 1;
	_newObjs = [];
	_multiplyMatrixFunc =
	{
		private ["_array1", "_array2", "_result"];
		_array1 = _this select 0;
		_array2 = _this select 1;
		_result =
		[
		(((_array1 select 0) select 0) * (_array2 select 0)) + (((_array1 select 0) select 1) * (_array2 select 1)),
		(((_array1 select 1) select 0) * (_array2 select 0)) + (((_array1 select 1) select 1) * (_array2 select 1))
		];
		_result
	};

	_group = createGroup east;

	for "_i" from 0 to ((count _objs) - 1) do
	{
			private ["_obj", "_type", "_relPos", "_azimuth", "_fuel", "_damage", "_newObj"];
			_obj = _objs select _i;
			_type = _obj select 0;
			_relPos = _obj select 1;
			_azimuth = _obj select 2;
			if ((count _obj) > 3) then {_fuel = _obj select 3;};
			if ((count _obj) > 4) then {_damage = _obj select 4;};
			private ["_rotMatrix", "_newRelPos", "_newPos"];
			_rotMatrix =[[cos _azi, sin _azi],[-(sin _azi), cos _azi]];
			_newRelPos = [_rotMatrix, _relPos] call _multiplyMatrixFunc;
			private ["_z"];
			if ((count _relPos) > 2) then {_z = _relPos select 2} else {_z = 0};
			_newPos = [_posX + (_newRelPos select 0), _posY + (_newRelPos select 1), _z];
			_newObj = _type createVehicle _newPos;
			_newObj setDir (_azi + _azimuth);
			_newObj setPos _newPos;
			if (!isNil "_fuel") then {_newObj setFuel _fuel};
			if (!isNil "_damage") then {_newObj setDamage _damage};
			if (_newObj emptyPositions "driver" > 0) then {
				_soldier = _group createUnit ["RU_Soldier_Crew", _pos, [], 0, "NONE"];
				_soldier assignAsDriver _newobj;
				_soldier moveindriver _newobj;
				wcgarbage = [_soldier, wcskill] spawn WC_fnc_setskill;
				_soldier addeventhandler ['killed', {_this spawn WC_fnc_garbagecollector}];
				_soldier addEventHandler ['Hit', '
					(_this select 0) doTarget (_this select 1);
					(_this select 0) doFire (_this select 1);
				'];
				_soldier addeventhandler ['FiredNear', {
					if((side (_this select 1)) in wcside) then {
						(_this select 0) reveal (_this select 1);
						(_this select 0) doFire (_this select 1);
					};
				}];
			};
			if (_newObj emptyPositions "gunner" > 0) then {
				_soldier = _group createUnit ["RU_Soldier_Crew", _pos, [], 0, "NONE"];
				_soldier assignAsgunner _newobj;
				_soldier moveingunner _newobj;
				wcgarbage = [_soldier, wcskill] spawn WC_fnc_setskill;
				_soldier addeventhandler ['killed', {_this spawn WC_fnc_garbagecollector}];
				_soldier addEventHandler ['Hit', '
					(_this select 0) doTarget (_this select 1);
					(_this select 0) doFire (_this select 1);
				'];
				_soldier addeventhandler ['FiredNear', {
					if((side (_this select 1)) in wcside) then {
						(_this select 0) reveal (_this select 1);
						(_this select 0) doFire (_this select 1);
					};
				}];
			};
			if (_newObj emptyPositions "commander" > 0) then {
				_soldier = _group createUnit ["RU_Soldier_Crew", _pos, [], 0, "NONE"];
				_soldier assignAscommander _newobj;
				_soldier moveincommander _newobj;
				wcgarbage = [_soldier, wcskill] spawn WC_fnc_setskill;
				_soldier addeventhandler ['killed', {_this spawn WC_fnc_garbagecollector}];
				_soldier addEventHandler ['Hit', '
					(_this select 0) doTarget (_this select 1);
					(_this select 0) doFire (_this select 1);
				'];
				_soldier addeventhandler ['FiredNear', {
					if((side (_this select 1)) in wcside) then {
						(_this select 0) reveal (_this select 1);
						(_this select 0) doFire (_this select 1);
					};
				}];
			};
			_newObj addeventhandler ['killed', {_this spawn WC_fnc_garbagecollector}];
			_newObjs = _newObjs + [_newObj];
	};

	if (count (units _group) > 0) then {
		// initialisation script for units
		_markername = format["wccompositionups%1", wccomposition];
		_markersize = 50;
		_marker = [_markername, _markersize, _pos, 'ColorBLUE', 'ICON', 'FDIAGONAL', 'EMPTY', 0, '', true] call WC_fnc_createmarker;
		sleep 1;
		_scriptinit = format["wcgarbage = [this, '%1', 'noslow', 'showmarker'] execVM 'extern\ups.sqf';", _markername];
		_leader = leader _group;
		_leader setVehicleInit _scriptinit;
		wccompositionindex = wccompositionindex + 1;
		processInitCommands;
	};

	_newObjs;