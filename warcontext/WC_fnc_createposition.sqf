	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext 
	// units & vehicles class
	// http://community.bistudio.com/wiki/ArmA:_CfgVehicles
	// generate a random position
	// -----------------------------------------------
	private [
		"_topright",
		"_bottomleft",
		"_xmax",
		"_ymax",
		"_xmin",
		"_ymin",
		"_xrandom",
		"_yrandom",
		"_x",
		"_y",
		"_newx",
		"_newy",
		"_position",
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
		"_onsea",
		"_gridofposition",
		"_empty"		
		];

	_topright 	= _this select 0;
	_bottomleft 	= _this select 1;

	if ( "onmountain" in _this) then { _onmountain = true; } else { _onmountain = false;};
	if ( "onflat" in _this) then { _onflat = true; } else {_onflat = false;};
	if ( "onroad" in _this) then { _onroad = true; }else {_onroad = false;};
	if ( "invillage" in _this) then { _invillage = true;} else {_invillage = false;};
	if ( "incity" in _this) then { _incity = true; } else {_incity = false;};
	if ( "incitycapital" in _this) then { _incitycapital = true; } else {_incitycapital = false;};
	if ( "onhill" in _this) then { _onhill = true; } else {_onhill = false;};
	if ( "onmount" in _this) then { _onmount = true; } else {_onmount = false;};
	if ( "onground" in _this) then { _onground = true;} else {_onground = false;};
	if ( "onsea" in _this) then { _onsea = true;} else {_onsea = false;};
	if ( "empty" in _this) then { _empty = true;} else {_empty = false;};

	// top right
	_xmax 	= _topright select 0;
	_ymax	= _topright select 1;

	// bottom left
	_xmin	= _bottomleft select 0;
	_ymin	= _bottomleft select 1;

	// random
	_xrandom = _xmax - _xmin;
	_yrandom = _ymax - _ymin;

	_position = [0,0,0];
	while {format["%1", _position] == "[0,0,0]"} do {
		_position = [0,0,0];
		_x = random _xrandom;
		_y = random _yrandom;
		_newx = _x + _xmin;
		_newy = _y + _ymin;
		_position = [_newx, _newy];
		if(_position distance (getmarkerpos "respawn_west") < 1000) then {
			_position = [0,0,0];
		};
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
		if (_onflat) then {
			_isflat = [];
			_isflat = _position isflatempty [20, 0, 0.1, 20, 0, false]; 
			if (count _isflat < 1) then { _position = [0,0,0]; };
		};
		if (_onroad) then {
			if (!isOnRoad _position) then { _position = [0,0,0]; };
		};
		if (_onhill) then {
			_nearestlocation = nearestLocation [_position, "Hill"];
			_position = position _nearestlocation;
		};
		if (_onmount) then {
			_nearestlocation = nearestLocation [_position, "Mount"];
			_position = position _nearestlocation;
		};
		if(_empty) then {
			if(count nearestObjects [_position, ["All"], 10] > 0) then {
				_position = [0,0,0];
				_invalidate = true;
			};
		};
		if(_onground) then {
			// Position can not be at less 100 meters of water
			_gridofposition = [_position, 100] call WC_fnc_creategridofposition;
			{
				if (surfaceIsWater _x) then {
					_position = [0,0,0];
				};
			} foreach _gridofposition;
		};
		if(_onsea) then {
			if!(surfaceIsWater _position) then {
				_position = [0,0,0];
			};
		};		
		sleep 0.05;
	};

	_position;