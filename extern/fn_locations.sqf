scriptName "Functions\systems\fn_locations.sqf";
/*
	File: locations.sqf
	Author: Karel Moricky

	Description:
	Creates location logics in the given area

	Parameter(s):
	_this select 0: String, Location, Object or Array - Location type(s), list of custom locations or list of logics
	_this select 1: Object or Array - Checked area (trigger or array in format [center,distance])
	_this select 2: Boolean - Debug mode

	Returned value:
	Array - list of all location logics in given area (both new and already created ones)
	
	Note: If locations given by type (String) only config locations are used (not custom locations created via createLocation - because there is no way to get unique id/name for them). For script created locations - give list of them to this function.
*/

private ["_types","_area","_debug","_logicFnc","_center","_maxdis","_locations","_logics","_result","_current","_classname","_position","_type","_logic","_name","_neighbors","_neighborsLogic","_neighbor","_marker","_pos1","_pos2","_diffX","_diffY","_lx","_ly","_dis","_dir","_class","_typeLogic","_mode","_pos","_maxvalue","_houselist","_houselistnew","_housecount","_rarityurban"];
if (typename _this == typename "") then {_this = ["citycenter",[],true]}; //--- Debug

_types = if (count _this > 0) then {_this select 0} else {["citycenter"]};
_area = if (count _this > 1) then {_this select 1} else {[[0,0,0],1000000]};
_debug = if (count _this > 2) then {true} else {false};
_logicFnc = bis_functions_mainscope;
_result = [];

if (typename _types in [typename "",typename locationnull]) then {_types = [_types]};

//--- Parallel code to set neighbor connections
_setNeigbors = {
    _logic = _this select 0;
	_neighbors = _this select 1;
	_debug = _this select 2;
	_neighborsLogic = [];
	waituntil {isnil {bis_functions_mainscope getvariable "BIS_fnc_locations_pending"}};
	{
		call compile format ["if !(isnil 'BIS_loc_%1') then {_neighborsLogic = _neighborsLogic + [BIS_loc_%1]}",_x];	
	} foreach _neighbors;
	if (isnil {_logic getvariable "neighbors"}) then {_logic setvariable ["neighbors",_neighborsLogic,true]};

	//--- Connections
	{
		_neighbor = _x;

		//--- Add logic to all neighbors
		[_x,"neighbors",[_logic],true,true] call bis_fnc_variablespaceadd;

		if (_debug) then {
			_marker = createmarker [format ["%1_%2",_logic getvariable "class",_neighbor getvariable "class"],[0,0,0]];
			_marker setmarkershape "rectangle";
			_marker setmarkerbrush "solid";
			_marker setmarkercolor "colorblack";	
			_marker setmarkeralpha 0.5;

			_pos1 = position _logic;
			_pos2 = position _neighbor;

			_difX = (_pos1 select 0) - (_pos2 select 0) +0.1;
			_difY = (_pos1 select 1) - (_pos2 select 1) +0.1;
			_lx = (_pos2 select 0) + _difX / 2;
			_ly = (_pos2 select 1) + _difY / 2;
			_dis = sqrt(_difX^2 + _difY^2);
			_dir = atan (_difX / _difY);
			_marker setmarkerpos [_lx,_ly];
			_marker setmarkersize [10,_dis/2];
			_marker setmarkerdir _dir;

			if (!isnil "cheat1") then {
				if !(cheat1) exitwith {};
				_markera = createmarker [format ["%1_%2_arrow",_logic getvariable "class",_neighbor getvariable "class"],[0,0,0]];
				_markera setmarkertype "mil_arrow2";
				_markera setmarkercolor "colorred";
				_markera setmarkerpos [_lx,_ly];
				_markera setmarkerdir ([_logic,_neighbor] call bis_fnc_dirto);
				_markera setmarkersize [0.5,1];
			};
		};
	} foreach _neighborsLogic;
};


//--- Crossroads
switch (typename _types) do {

	//////////////////////////////////////////////////////////////////////////////////////////////////////////
	/// Create Logic
	//////////////////////////////////////////////////////////////////////////////////////////////////////////
	case "ARRAY": {

		//--- Exit
		if (typename _types != typename []) exitwith {debuglog "Log: [Functions/location] Types (0) must be of type Array or String!"};
		if (typename _area != typename [] && typename _area != typename objnull) exitwith {debuglog "Log: [Functions/location] Area (1) must be of type Array!"};

		_logicFnc setvariable ["BIS_fnc_locations_pending",true];

		_center = if (typename _area == typename []) then {if (count _area > 0) then {_area select 0} else {[0,0,0]}} else {[0,0,0]};
		_maxdis = if (typename _area == typename []) then {if (count _area > 1) then {_area select 1} else {100000}} else {100000};
		_locations = configfile >> "cfgworlds" >> worldname >> "names";
		_logics = [];

		if (typename (_types select 0) == typename "") then {

			//--- Create config-base locations
			for "_i" from 0 to (count _locations - 1) do {
				_current = _locations select _i;
				_classname = format ["BIS_loc_%1",configname _current];
				_position = getarray(_current >> "position");		
				_type = gettext(_current >> "type");
				_typeLogic = gettext (configFile >> "cfgLocationTypes" >> _type >> "logicClass");	
				if (_typeLogic == "") then {_typeLogic = "LocationLogic"};
		
				_inArea = if (typename _area == typename []) then {_position distance _center < _maxdis} else {[_area,_position] call bis_fnc_intrigger};
				if (isnil _classname &&  {_x == _type} count _types > 0 && _inArea) then {

					//--- Create logic
					_logic = (group _logicFnc) createunit [_typeLogic,_position,[],0,"none"];
					_logics = _logics + [_logic];
					_result = _result + [_logic];
					_name = gettext(_current >> "name");
					if (_name == "") then {_name = _classname};
					_neighbors = getarray(_current >> "neighbors");
					_demography = getarray(_current >> "demography");

					//--- Set name
					call compile format ["%1 = _logic;",_classname];
					_logic setvariable ["name",_name,true];
					_logic setvariable ["class",configname _current,true];
					_logic setvariable ["type",_type,true];
					if (!isnil "_demography") then {_logic setvariable ["demography",_demography,true]};
	
					//--- Save neighbors
					if (count _neighbors > 0) then {
						[_logic,_neighbors,_debug] spawn _setNeigbors;
					} else {_logic setvariable ["neighbors",[],true];};

					//--- Debug - draw marker
					if (_debug) then {
						_marker = createmarker [_classname,_position];
						_marker setmarkertype "mil_dot";
						_marker setmarkercolor "colorblack";
						if (typename _this == typename "") then {_marker setmarkertext _name};
						_marker setmarkeralpha 0.5;
					};
				} else {
					if (!isnil _classname &&  {_x == _type} count _types > 0 && _position distance _center < _maxdis) then {
						_logic = objnull;
						call compile format ["_logic = %1",_classname];
						if !(isnull _logic) then {_result = _result + [_logic]};
					};
				};
			};
		} else {

			//--- Create custom created locations
			if (typename (_types select 0) == typename locationnull) then {
				{
					_location = _x;
					_position = position _location;
					_classname = "BIS_loc_" + name _location;
					_name = name _location;
					_class = _classname;
					_type = type _location;
					_typeLogic = gettext (configFile >> "cfgLocationTypes" >> _type >> "logicClass");				
					if (_typeLogic == "") then {_typeLogic = "LocationLogic"};		    

					if (_classname == "BIS_loc_") then {
						_n = 0;
						while {!isnil format ["BIS_loc_custom_%1",_n]} do {
							_n = _n + 1;
						};
						_classname = format ["BIS_loc_custom_%1",_n];
					};
					if (_name == "") then {_name = _classname};

					//--- Create logic
					_logic = (group _logicFnc) createunit [_typeLogic,_position,[],0,"none"];
					_logics = _logics + [_logic];
					_result = _result + [_logic];

					//--- Set name
					call compile format ["%1 = _logic;",_classname];
					_logic setvariable ["name",_name,true];
					_logic setvariable ["class",_classname,true];
					_logic setvariable ["neighbors",[]];

					//--- Debug - draw marker
					if (_debug) then {

						_marker = createmarker [_classname,_position];
						_marker setmarkertype "mil_dot";
						_marker setmarkercolor "colorblack";
						_marker setmarkertext _name;
					};
				} foreach _types;
			} else {
		
				//--- Register already existing logic
				if (typename (_types select 0) == typename objnull) then {
					{
						_logic = _x;
						_classname = _logic getvariable "class";
						_name = _logic getvariable "name";
						if (isnil "_classname") then {
							_n = 0;
							while {!isnil format ["BIS_loc_custom_%1",_n]} do {
								_n = _n + 1;
							};
							_classname = format ["BIS_loc_custom_%1",_n];

							_name = _logic getvariable "name";
							if (isnil "_name") then {_name = _classname};

							_logic setvariable ["name",_name,true];
							_logic setvariable ["class",_classname,true];

							//--- Register logic (EP1)
							_logics = _logics + [_logic];
							_result = _result + [_logic];

							//--- Set name
							call compile format ["%1 = _logic;",_classname];

							//--- Debug - draw marker
							if (_debug) then {
								_marker = createmarker [_name,position _logic];
								_marker setmarkertype "mil_dot";
								_marker setmarkercolor "colorblack";
								_marker setmarkertext _name;
							};

						} else {textLogFormat ["Log: [Functions/location] Object %1 is already registred, only neighbors were set.",_logic]};

						//--- Save neighbors
						_neighbors = _logic getvariable "neighbors";
						if !(isnil "_neighbors") then {
							[_logic,_neighbors,_debug] spawn _setNeigbors;
						} else {_logic setvariable ["neighbors",synchronizedobjects _logic]}; //--- EP - synchronized objects

					} foreach _types;
				};
			};
		};
		[_logicFnc,"locations",_logics, true] call bis_fnc_variablespaceadd;
		_logicFnc setvariable ["BIS_fnc_locations_pending",nil];
	};

	//////////////////////////////////////////////////////////////////////////////////////////////////////////
	/// Set rarity value
	//////////////////////////////////////////////////////////////////////////////////////////////////////////
	case "OBJECT": {
		_logic = _types;
		_mode = _area select 0;
		_maxvalue = if (count _area > 1) then {_area select 1} else {100};
		_result = -1;
		_classname = _logic getvariable "class";

		//--- Exit
		if (typename _mode != typename "") exitwith {debuglog "Log: [Functions/location] Mode (1) must be of type String!"};
		if (_maxvalue == 0) exitwith {debuglog "Log: [Functions/location] Maxvalue (1/1) must not be 0!"};

		switch (_mode) do {
			case "RARITY": {
				_pos = position _logic;
				//waituntil {_pos nearObjectsReady 500};
				_houselist = _pos nearobjects ["House",500];
				_houselistnew = [];
				//--- Remove small objects and objects on blacklist
				{
					if ((_x selectionposition "AIdoor1") distance [0,0,0] != 0) then {
						_houselistnew = _houselistnew + [_x];
					};
				} foreach _houselist;
				_housecount = count _houselistnew;
				_rarityurban = _housecount / _maxvalue;
				if (_rarityurban > 1) then {_rarityurban = 1};
				if (_rarityurban < 0) then {_rarityurban = 0};
				_result = _rarityurban;
				_logic setvariable ["rarityurban",_rarityurban,true];

				if (_debug) then {
					_classname setmarkertext str _rarityurban;
				};
			};
		};
	};
};

_result;