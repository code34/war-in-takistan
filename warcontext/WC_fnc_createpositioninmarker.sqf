	// -----------------------------------------------
	// Author: =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// warcontext 
	// units & vehicles class
	// http://community.bistudio.com/wiki/ArmA:_CfgVehicles
	// generate a random position in a marker
	// -----------------------------------------------
	private [
		"_position", 
		"_x", 
		"_y", 
		"_z", 
		"_newx",
		"_newy",
		"_xtemp",
		"_ytemp",
		"_marker",
		"_markersize",
		"_onmountain",
		"_onroad",
		"_inforest",
		"_invillage",
		"_incity",
		"_incitycapital",
		"_isflat",
		"_onhill",
		"_onmount",
		"_onflat",
		"_onground",
		"_gridofposition",
		"_onflatforbase",
		"_count",
		"_invalidate",
		"_empty"
		];

	_markername = _this select 0;
	_markersize = (getmarkersize _markername) select 0;
	_type = _this select 1;
	_count = 0;

	if ( "onmountain" in _this) then { _onmountain = true; } else { _onmountain = false;};
	if ( "onflat" in _this) then { _onflat = true; } else {_onflat = false;};
	if ( "onflatforbase" in _this) then { _onflatforbase = true; } else {_onflatforbase = false;};
	if ( "onroad" in _this) then { _onroad = true; }else {_onroad = false;};
	if ( "invillage" in _this) then { _invillage = true;} else {_invillage = false;};
	if ( "incity" in _this) then { _incity = true; } else {_incity = false;};
	if ( "incitycapital" in _this) then { _incitycapital = true; } else {_incitycapital = false;};
	if ( "onhill" in _this) then { _onhill = true; } else {_onhill = false;};
	if ( "onmount" in _this) then { _onmount = true; } else {_onmount = false;};
	if ( "onground" in _this) then { _onground = true;} else {_onground = false;};
	if ( "empty" in _this) then { _empty = true;} else {_empty = false;};

	for "_x" from 1 to (random (random 10)) step 1 do {
		_i = random 1;
	};

	_position = [0,0,0];
	_invalidate = true;
	_x = abs((getmarkerpos _markername) select 0);
	_y = abs((getmarkerpos _markername) select 1);

	while {(format["%1", _position] == "[0,0,0]" or _invalidate)} do {
		_position = [0,0,0];
		_invalidate = false;
		if (random 1 > 0.5) then { _xtemp = random _markersize; } else { _xtemp = (random _markersize) * -1; };
		if (random 1 > 0.5) then { _ytemp = random _markersize; } else { _ytemp = (random _markersize) * -1; };
		_newx = ceil(_xtemp + _x);
		_newy = ceil(_ytemp + _y);
		_position = [_newx, _newy];
		if (_invillage) then {
			_nearestlocation = nearestLocation [_position, "NameVillage"];
			_position = position _nearestlocation;
		};
		if (_incity) then {
			_nearestlocation = nearestLocation [_position, "NameCity"];
			_position = position _nearestlocation;
		};
		if (_incitycapital) then {
			_nearestlocation = nearestLocation [_position, "NameCityCapital"];
			_position = position _nearestlocation;
		};
		if (_onmountain) then {
			_position = [_position] call WC_fnc_getterraformvariance;
		};
		if(_empty) then {
			_position = _position findEmptyPosition [3, 100];
		};
		if (_onflat) then {
			_isflat = [];
			_isflat = _position isflatempty [2, 0, 0.2, 2, 0, false];  
			if (count _isflat == 0) then { _position = [0,0,0]; _invalidate = true;};
		};
		if (_onflatforbase) then {
			_isflat = [];
			_isflat = _position isflatempty [20, 0, 0.1, 20, 0, false];  
			if (count _isflat < 1) then { _position = [0,0,0]; _invalidate = true;};
		};
		if (_onroad) then {
			if (!isOnRoad _position) then { _position = [0,0,0]; _invalidate = true;};
		} else {
			if(count(_position nearRoads 15) > 0) then {
				_position = [0,0,0]; _invalidate = true;
			};
		};
		if (_onhill) then {
			_nearestlocation = nearestLocation [_position, "Hill"];
			_position = position _nearestlocation;
		};
		if (_onmount) then {
			_nearestlocation = nearestLocation [_position, "Mount"];
			_position = position _nearestlocation;
		};
		if(_onground) then {
			// Position can not be at less 50 meters of water
			_gridofposition = [_position, 50] call WC_fnc_creategridofposition;
			{
				if (surfaceIsWater _x) then {
					_position = [0,0,0];
					_invalidate = true;
				};
			} foreach _gridofposition;
		};
		_count = _count + 1;
		if(_count > 300) then { _onflat = false;};
		if(_count > 600) then { _position = [1,1,0]; _invalidate = false;};
		sleep 0.05;
	};

	_position;