	// -----------------------------------------------
	// Author: team  code34 nicolas_boiteux@yahoo.fr
	// warcontext - WIT - enum faction
	// -----------------------------------------------

	private ["_classlist", "_count", "_actual", "_side", "_scope", "_class", "_vehicleclass", "_faction", "_factions", "_count", "_position", "_sidetoget", "_sidenum"];

	_sidetoget = _this select 0;

	switch (_sidetoget) do {
		case east : { _sidenum = 0;};
		case west : { _sidenum = 1;};
		case resistance : { _sidenum = 2;};
		case civilian : { _sidenum = 3;};
	};

	_classlist = [];
	_factions = [];

	_classlist = [];
	_count = count (configfile >> "cfgVehicles");
	for [{_i = 0}, {_i < _count}, {_i = _i + 1}] do {
		_actual = (configfile >> "cfgVehicles") select _i;
		if (isclass _actual) then {
			_class = configname _actual;
			_vehicleclass = gettext (configfile >> "cfgvehicles" >> _class >> "vehicleClass");
			if(_class iskindof "Man") then {
				if !(_vehicleclass in ["Sounds","Mines"]) then {
					_scope = getnumber (_actual >> "scope");
					_side = getnumber (_actual >> "side");
					if (_scope == 2 && _side == _sidenum) then {
						_faction = gettext (configfile >> "cfgvehicles" >> _class >> "faction");
						if!(_faction in _factions) then { _factions = _factions + [_faction];};
						_classlist = _classlist + [[_faction, _class]];
					};
				};
			};
		};
	};

	[_factions, _classlist];