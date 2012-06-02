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
		"_marker"
		];

	_indexparameters = 0;
	_nbparameters = count _this;
	{
		if (_indexparameters <= _nbparameters) then {
		call compile format["%1 = _this select %2;", _x, _indexparameters];
		};
		_indexparameters = _indexparameters + 1;
	}foreach _parameters;

	_markersize = (getmarkersize _marker) select 0;
	_markerposition = markerpos _marker;
	_markercolor 	= markercolor _marker;
	_markershape	= markershape _marker;
	_markerbrush 	= markerbrush _marker;
	_markertype 	= markertype _marker;
	_markerdir 	= markerdir _marker;
	_markertext 	= _markername;

	if(isnil "_markertype") then { _markertype = "" ;};
	if(isnil "_markerdir") then { _markerdir = 0;};
	if(isnil "_markertext") then { _markertext = "";};
	if(isnil "_protect") then { _protect = false;};

	_marker = createMarkerlocal[_markername, _markerposition];
	if (!isnil ("_markersize")) then { _marker setMarkerSizelocal [_markersize, _markersize]; };
	if (_markershape != "") then { _marker setMarkershapelocal _markershape; };
	if (_markercolor != "") then { _marker setMarkerColorlocal _markercolor; };
	if (_markerbrush != "") then { _marker setMarkerBrushlocal _markerbrush; };
	if (_markertext != "") then { _marker setMarkerTextlocal _markertext; };
	if (!isnil ("_markerdir")) then { _marker setMarkerDirlocal _markerdir; };
	if (!isnil ("_markertype")) then { _marker setMarkerTypelocal _markertype; };

	_marker;