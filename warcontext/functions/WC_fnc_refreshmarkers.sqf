	// -----------------------------------------------------------------
	// Author: code34 nicolas_boiteux@yahoo.fr
	// warcontext - Description: refresh all markers in array at x time
	// -----------------------------------------------------------------

	private [
		"_markers",
		"_position",
		"_time"
	];

	_markers = _this select 0;
	_time = _this select 1;

	while { true } do {
		{
			_position = getmarkerpos (_x select 0);
			(_x select 0) setMarkerPos _position;
			sleep 0.01;
		}foreach _markers;
		sleep _time;
	};