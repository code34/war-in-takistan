	// -----------------------------------------------
	// Author: team  code34 nicolas_boiteux@yahoo.fr
	// warcontext - Description:
	// Get an object by its editor ID
	// Example:
	// [172851] execVM "WC_fnc_getobject.sqf";
	// -----------------------------------------------

	private [
		"_objectid",
		"_markersize",
		"_markername",
		"_marker",
		"_position",
		"_object"
	];

	_objectid = _this select 0;

	_markersize = 1;
	_markername = "getobject";
	_position = [0, 0];

	_marker = [_markername, _markersize, _position, 'ColorBLUE', 'ELLIPSE', 'FDIAGONAL'] call WC_fnc_createmarkerlocal;
	_object = (getMarkerPos _marker) nearestObject _objectid;
	deletemarkerlocal _marker;

	_object;