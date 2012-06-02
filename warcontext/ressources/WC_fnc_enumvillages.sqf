	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// Parse villages on map
	// -----------------------------------------------

	private ["_countofobject", "_sizeofzone", "_y", "_x", "_array", "_temp"];

	_lastpos = [0,0];
	_sizeofzone = 300;
	_y = (wcmapbottomleft select 1);

	while { _y < (wcmaptopright select 1) } do {
		for "_x" from (wcmapbottomleft select 0) to (wcmaptopright select 0) step _sizeofzone do {
			_temp = [_x, _y];

			_array = nearestObjects [_temp, ["House"] , (_sizeofzone / 2)];
			{
				if(format["%1", typeof _x] == "Land_runway_edgelight") then {
					_array = _array - [_x];
				};
			}foreach _array;

			_countofobject = count _array;

			if((_temp distance getmarkerpos "respawn_west" > (_sizeofzone * 2)) && (_lastpos distance _temp > (_sizeofzone * 2)) && !(surfaceiswater _temp)) then {
				if (_countofobject > wcminimunbuildings) then {
					wctownlocations = wctownlocations + [createLocation ["NameVillage", _temp, (_sizeofzone / 2), (_sizeofzone / 2)]];
					_lastpos = _temp;
				} else {
					if (_countofobject == 0) then {
						if!(surfaceIsWater _temp) then {
							wcemptylocations = wcemptylocations + [_temp];
						};
					};
				};
			};
		};
		_y = _y + _sizeofzone;
		sleep 0.01;
	};

	if(wccomputedvillages > 0) then {
		for "_x" from 1 to wccomputedvillages step 1 do {
			_temp = wcemptylocations call BIS_fnc_selectRandom;
			wcemptylocations = wcemptylocations - [_temp];
			wctownlocations = wctownlocations + [createLocation ["NameCity", _temp, (_sizeofzone / 2), (_sizeofzone / 2)]];
		};
	};

	// max of towns
	if (count wctownlocations > wccomputedzones) then {
		while { count wctownlocations > wccomputedzones } do {
			_temp = wctownlocations call BIS_fnc_selectRandom;
			wctownlocations = wctownlocations - [_temp];
		};
	};

	diag_log format ["WARCONTEXT: COMPUTING %1 ZONES", count wctownlocations];