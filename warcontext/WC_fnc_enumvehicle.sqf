	// -----------------------------------------------
	// Author: team =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// warcontext - WIT - enum vehicle
	// -----------------------------------------------

	private ["_classlist", "_classlistwithout", "_count", "_actual", "_side", "_scope", "_class", "_vehicleclass", "_hasdriver", "_faction",  "_count", "_position", "_sidetoget", "_sidenum", "_weapon", "_manual"];

	_sidetoget = _this select 0;

	switch (_sidetoget) do {
		case east : { _sidenum = 0;};
		case west : { _sidenum = 1;};
		case resistance : { _sidenum = 2;};
		case civilian : { _sidenum = 3;};
	};

	_classlist = [];
	_classlistwithout = [];

	_count = count (configfile >> "cfgVehicles");
	for [{_i = 0}, {_i < _count}, {_i = _i + 1}] do {
		_actual = (configfile >> "cfgVehicles") select _i;
		if (isclass _actual) then {
			_class = configname _actual;
			_vehicleclass = gettext (configfile >> "cfgvehicles" >> _class >> "vehicleClass");
			if(_class iskindof "LandVehicle") then {
				if !(_vehicleclass in ["Sounds","Mines"]) then {
					_scope = getnumber (_actual >> "scope");
					_side = getnumber (_actual >> "side");
					_hasdriver = getnumber (_actual >> "hasdriver");
					if (_scope == 2 && _side == _sidenum && _hasdriver == 1) then {
						_classlist = _classlist + [_class];
					};
				};
			};
		};
	};
	
	_classlist;