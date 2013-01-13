	// -----------------------------------------------
	// Author: team  code34 nicolas_boiteux@yahoo.fr
	// warcontext - Description: 
	// create a marker
	// -----------------------------------------------
	private [
		"_indexparameters",
		"_nbparameters",
		"_parameters",
		"_marker",
		"_markername",
		"_markersize",
		"_markerposition",
		"_markercolor",
		"_markershape",
		"_markerbrush",
		"_markertype",
		"_markerdir",
		"_markertext",
		"_protect"
		];

	_parameters = [
		"_markername",
		"_markersize",
		"_markerposition",
		"_markercolor",
		"_markershape",
		"_markerbrush",
		"_markertype",
		"_markerdir",
		"_markertext",
		"_protect"
		];

	_indexparameters = 0;
	_nbparameters = count _this;
	{
		if (_indexparameters <= _nbparameters) then {
		call compile format["%1 = _this select %2;", _x, _indexparameters];
		};
		_indexparameters = _indexparameters + 1;
	}foreach _parameters;

	if(isnil "_markertype") then { _markertype = "" ;};
	if(isnil "_markerdir") then { _markerdir = 0;};
	if(isnil "_markertext") then { _markertext = "";};
	if(isnil "_protect") then { _protect = false;};

	if(isnil "_markerposition") exitwith { diag_log format["WARCONTEXT: Marker %1 %2 position error", _markername, _markerposition];};
	if(count _markerposition < 3) exitwith { diag_log format["WARCONTEXT: Marker %1 %2 position error", _markername, _markerposition];};

	_marker = createMarkerlocal[_markername, _markerposition];
	if (!isnil ("_markersize")) then { _marker setMarkerSizelocal [_markersize, _markersize]; };
	if (_markershape != "") then { _marker setMarkershapelocal _markershape; };
	if (_markercolor != "") then { _marker setMarkerColorlocal _markercolor; };
	if (_markerbrush != "") then { _marker setMarkerBrushlocal _markerbrush; };
	if (_markertext != "") then { _marker setMarkerTextlocal _markertext; };
	if (!isnil ("_markerdir")) then { _marker setMarkerDirlocal _markerdir; };
	if (!isnil ("_markertype")) then { _marker setMarkerTypelocal _markertype; };

	_marker;