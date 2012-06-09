KEGs_fnc_arrayPushStack = {
	{
		(_this select 0) set [count (_this select 0), _x];
	} foreach (_this select 1);
	(_this select 0)
};

KEGs_missilcamrun = {
	private "_oldcam";
	_oldcam = KEGs_cameraIdx;
	while {!isNull _this && speed _this > 1 && _oldcam == KEGs_cameraIdx && dialog} do {
		KEGs_cam_missile camSetTarget _this;
		KEGs_cam_missile camSetRelPos [0, -0.5, 0.30];
		KEGs_cam_missile camCommit 0;
		sleep 0.01;
	};
	if ((_oldcam == KEGs_cameraIdx) && dialog) then {
		sleep 3;
	};
	KEGs_MissileCamActive = false;
	KEGs_MissileCamOver = true;
};

KEGs_markerdel = {
	sleep 2; deleteMarkerLocal _this
};

KEGs_markerupdateev = {
	private ["_m", "_o"];
	_m = _this select 0;_o = _this select 1;
	while {!isNull _o} do {
		_m setMarkerPosLocal getPosASL _o;
		_m setMarkerDirLocal getdir _o;
		sleep 0.02;
	};
	_m setMarkerColorLocal "ColorBlack";
	sleep 3;
	deleteMarkerLocal _m;
};

KEGs_markerdel2 = {
	sleep 1.0;(_this select 1) setMarkerColorLocal "ColorYellow";sleep 1;deleteMarkerLocal (_this select 1);deleteMarkerLocal (_this select 0)
};

KEGs_barsremove = {
	sleep 1.5; {deleteVehicle _x} foreach _this
};

KEGs_togmapf = {
	sleep 0.25; ["ToggleMap", 0] call spectate_events; ["ToggleMap", 0] call spectate_events;
};

KEGs_GetMCol = {
	switch (_this) do {
		case west: {"ColorBlue"};
		case east: {"ColorRed"};
		case resistance: {"ColorGreen"};
		case civilian: {"ColorWhite"};
		default {"ColorWhite"};
	}
};

KEGs_CheckOriginalSide =  {
	private ["_s", "_r", "_rd"];
	_s = _this getVariable "KEGs_oside";
	if (isNil "_s") then {
		if (alive _this && !(captive _this)) then {
			_r = rating _this;
			if (_r < 0) then {
				_rd = abs _r;
				_this addRating _rd;
				_s = side _this;
				_this addRating -_rd;
			} else {
				_s = side _this;
			};
			_this setVariable ["KEGs_oside", _s];
		} else {
			_s = switch (getNumber(configFile >> "CfgVehicles" >> typeOf _this >> "side")) do {
				case 0: {east};
				case 1: {west};
				case 2: {resistance};
				default {civilian};
			};
			_this setVariable ["KEGs_oside", _s];
		}
	};
	_s
};

KEGs_updatemarkers = {
	KEGs_markersrun = true;
	private ["_markers", "_disp", "_cMapFull", "_mapFull", "_mappos", "_markedVehicles", "_i", "_m", "_u", "_OriginalSide", "_type", "_icon"];
	_markers = _this select 0;
	disableSerialization;
	_disp = (findDisplay 55001);
	_cMapFull = 55014;
	if (ctrlVisible _cMapFull) then {
		_mapFull = _disp displayctrl _cMapFull;
		_mappos = _mapFull posScreenToWorld[0.5, 0.5];
		KEGs_cam_fullmap camSetTarget _mappos;
		KEGs_cam_fullmap camSetRelPos [0, -1, 150];
		KEGs_cam_fullmap camCommit 0;
	};
	
	_markedVehicles = [];
	for "_i" from 0 to (count _markers - 1) do {
		if (KEGs_exitspect) exitWith {};
		if (_i >= count _markers) exitWith {};
		_mo = _markers select _i;
		_m = _mo select 0;
		_u = _mo select 1;
		if (KEGs_MissileCamActive) then {
			waitUntil {!KEGs_MissileCamActive || KEGs_exitspect};
		};
		if (_u in KEGs_units) then {
			if (speed vehicle _u > 0) then {
				_m setMarkerPosLocal ((vehicle _u modelToWorld [0,0,0]));
			} else {
				if (alive _u) then {
					_hpos = getPosASL (vehicle _u); _mpos = markerPos _m;
					if (_hpos select 0 != _mpos select 0 || _hpos select 1 != _mpos select 1) then {
						_m setMarkerPosLocal ((vehicle _u modelToWorld [0,0,0]));
					};
				};
			};
			
			_OriginalSide = _u call KEGs_CheckOriginalSide;
			if (!(_OriginalSide in KEGs_ShownSides)) then {
				if (markerAlpha _m != 0) then {_m setMarkerAlphaLocal 0};
			} else { 				
				if (markerAlpha _m == 0) then {_m setMarkerAlphaLocal 1};
				if (KEGs_MarkerNames || KEGs_MinimapZoom < 0.15) then {
					if (ctrlVisible _cMapFull) then {
						switch(KEGs_MarkerType) do {
							case 0: {
								if (markerText _m != "") then {_m setMarkerTextLocal ""};
							};
							case 1: {
								if (alive (vehicle _u)) then {
									if (markerText _m != (_mo select 2)) then {_m setMarkerTextLocal (_mo select 2)};
								};
							};
							case 2: {
								_na = getText (configFile >> "CfgVehicles" >> typeOf (vehicle _u) >> "DisplayName");
								if (markerText _m != _na) then {_m setMarkerTextLocal _na};
							};
						};
					} else {
						if (markerText _m != "") then {_m setMarkerTextLocal ""};
					};
					
					_icon = (vehicle _u) getVariable "KEGs_icon";
					if (isNil "_icon") then {
						_icon = switch (getText(configFile >> "CfgVehicles" >> typeOf (vehicle _u) >> "simulation")) do {
							case "tank": {"n_armor"};
							case "car": {"n_motor_inf"};
							case "soldier": {"n_inf"};
							case "airplane": {"n_plane"};
							case "helicopter": {"n_air"};
							case "motorcycle": {"n_motor_inf"};
							default {"Arrow"};
						};
						(vehicle _u) setVariable ["KEGs_icon", _icon];
					};
					if (markerType _m != _icon) then {_m setMarkerTypeLocal _icon};
					_siz = markerSize _m;
					_nnsiz = 0.42 * KEGs_MarkerSize;
					if (_siz select 0 != _nnsiz || _siz select 1 != _nnsiz) then {_m setMarkerSizeLocal [_nnsiz, _nnsiz]};
					_ddir = direction vehicle _u;
					if (markerDir _m != _ddir) then {_m setMarkerDirLocal _ddir};
				} else {
					if (markerText _m != "") then {_m setMarkerTextLocal ""};
					if (markerType _m != "Dot") then {_m setMarkerTypeLocal "Dot"};
					_siz = markerSize _m;
					if (_siz select 0 != 0.4 || _siz select 1 != 0.4) then {_m setMarkerSizeLocal [0.4, 0.4]};
				};
			};
			
			if (!alive _u) then {_m setMarkerColorLocal "ColorBlack"};
			
			if (vehicle _u in _markedVehicles) then {
				if (markerAlpha _m != 0) then {_m setMarkerAlphaLocal 0};
			} else {
				_markedVehicles set [count _markedVehicles, vehicle _u];
			};
			sleep 0.01;
		} else {
			if (markerAlpha _m != 0) then {_m setMarkerAlphaLocal 0};
			sleep 0.01;
		};
	};
	KEGs_markersrun = false;
};

KEGs_HMouseButtons = {
	KEGs_mousecheckon = true;
	while {(KEGs_MouseButtons select 0) || (KEGs_MouseButtons select 1)} do {
		switch (true) do {
			case (!(KEGs_MouseButtons select 0) && (KEGs_MouseButtons select 1)): {
				KEGs_fangle = KEGs_fangle - ((KEGs_mouseDeltaPos select 0) * 360);
				KEGs_fangleY = KEGs_fangleY + ((KEGs_mouseDeltaPos select 1) * 180);
				switch (true) do {
					case (KEGs_fangleY > 89): {KEGs_fangleY = 89};
					case (KEGs_fangleY < -89): {KEGs_fangleY = -89};
				};
			};
			case ((KEGs_MouseButtons select 0) && !(KEGs_MouseButtons select 1)): {
				KEGs_sdistance = KEGs_sdistance - ((KEGs_mouseDeltaPos select 1) * 10);
				switch (true) do {
					case (KEGs_sdistance > KEGs_maxDistance): {KEGs_sdistance = KEGs_maxDistance};
					case (KEGs_sdistance < -KEGs_maxDistance): {KEGs_sdistance = -KEGs_maxDistance};
				};
				if (KEGs_sdistance < -0.6) then {KEGs_sdistance = -0.6};
			};
			case ((KEGs_MouseButtons select 0) && (KEGs_MouseButtons select 1)): {
				KEGs_szoom = KEGs_szoom - ((KEGs_mouseDeltaPos select 1) * 3);
				switch (true) do {
					case (KEGs_szoom > 2): {KEGs_szoom = 2};
					case (KEGs_szoom < 0.05): {KEGs_szoom = 0.05};
				};
			};
		};
		if (KEGs_exitspect) exitWith {};
		sleep 0.0034;
	};
	KEGs_mousecheckon = false;
};

KEGs_CheckU = {
	private ["_r", "_isloc", "_isalive"];
	_r = true;_isalive = alive _this;
	if (KEGs_playable_only) then {if (!((_this in playableUnits) || (_this in switchableUnits))) then {_r = false}};
	if (_r) then {
		if (!isPlayer _this) then {if (KEGs_AIfilter == 1) then {_r = false}};
		if (_r) then {
			_isloc = (_this == player);
			if (!_isloc && !_isalive) then {if (KEGs_DeadFilter == 1) then {_r = false}};
			if (_r) then {
				if (!_isloc && KEGs_gfleader) then {if ((_this != formationLeader _this) || (_this != leader _this)) then {_r = false}};
				if (_r) then {if (!_isloc && KEGs_CheckDist != -1) then {if (_this distance player > KEGs_CheckDist) then {_r = false}}};
			};
		};
	};
	[_r, _isalive]
};

KEGs_UpdateLB = {
	KEGs_updating_lb = true;
	private ["_cLBTargets", "_sidecache", "_namecache", "_deadstr", "_clbcols", "_idx", "_oside", "_rr", "_name", "_i", "_colidx", "_prest"];
	_cLBTargets = _this select 0;
	_sidecache = _this select 1;
	_namecache = _this select 2;
	_deadstr = _this select 3;
	_clbcols = _this select 4;
	_uns = []; _rest = []; _idx = 0; _prest = [];
	{
		_oside = _sidecache select _idx;
		if (_oside in KEGs_ShownSides) then {
			_rr = _x call KEGs_CheckU; 
			if (_rr select 0) then {
				_uns set [count _uns, _x];
				_name = _namecache select _idx;
				if (!(_rr select 1)) then {_name = _deadstr + _name};
				_colidx =  if (_idx == KEGs_tgtIdx) then {0} else {if (_rr select 1) then {switch (_oside) do {case west: {1};case east: {2};case resistance: {3};case civilian: {4};}} else {5}};
				if (isNil "KEGs_withSpect") then {
					_rest set [count _rest, [_name, _idx, _colidx]];
				} else {
					if (_x != player) then {
						_rest set [count _rest, [_name, _idx, _colidx]];
					} else {
						_prest = [_name, _idx, _colidx];
					};
				};
			};
		};
		_idx = _idx + 1;
		if (KEGs_exitspect) exitWith {};
	} forEach KEGs_deathCam;
	if (KEGs_exitspect) exitWith {};
	if (count _prest > 0) then {
		_rest resize (count _rest + 1);
		for "_v" from (count _rest - 1) to 1 step - 1 do {
			_rest set [_v, _rest select (_v - 1)];
		};
		_rest set [0, _prest];
		_uns = _uns - [player];
		_uns resize (count _uns + 1);
		for "_v" from (count _uns - 1) to 1 step - 1 do {
			_uns set [_v, _uns select (_v - 1)];
		};
		_uns set [0, player];
	};
	KEGs_units = _uns;
	lbClear _cLBTargets;
	{
		_i = lbAdd [_cLBTargets, _x select 0];
		lbSetValue [_cLBTargets, _i, _x select 1];
		lbSetColor [_cLBTargets, _i, _clbcols select (_x select 2)];
		if (KEGs_exitspect) exitWith {};
	} forEach _rest;
	KEGs_lastAutoUpdateLB = time;
	KEGs_NeedUpdateLB = false;
	sleep 1;
	KEGs_updating_lb = false;
};

KEGs_CheckNew = {
	private ["_newUnits", "_newVehicles", "_nn", "_fh", "_iswu", "_gg", "_m", "_markstr", "_unknownstr", "_OriginalSide", "_s", "_cameras", "_nunits"];
	_markstr = _this select 0;
	_unknownstr = _this select 1;
	_cameras = _this select 2;
	_allUnits = if (isNil "d_init_started") then {allUnits} else {if (isMultiplayer) then {playableUnits} else {switchableUnits}};
	_newUnits = _allUnits - KEGs_deathCam;
	_newVehicles = vehicles - KEGs_ehVehicles;
	if (count _newVehicles > 0) then {
		KEGs_ehVehicles = [KEGs_ehVehicles, _newVehicles] call KEGs_fnc_arrayPushStack;
		{
			_nn = _x getVariable "KEGs_EHFired";
			if (isNil "_nn") then {
				_fh = _x addEventHandler ["fired", {["UnitFired",_this] call spectate_events}];
				_x setVariable ["KEGs_EHFired", _fh];
				_x setVariable ["KEGs_mapmove", false];
			};
		} foreach _newVehicles;
	};
	if (count _newUnits > 0) then {
		_nunits = [];
		{
			_iswu = false;
			_gg = _x getVariable "KEGs_SPECT";
			if (isNil "_gg") then {_gg = false};
			if (!_gg) then {
				_x setVariable ["KEGs_SPECT", true];
				_x setVariable ["KEGs_mapmove", false];
				_iswu = true;
			};
			if (!isMultiplayer && KEGs_UseLog) then {
				_nn = _x getVariable "KEGs_EHKilled";
				if (isNil "_nn") then {
					_fh = _x addEventHandler ["killed", {["UnitKilled",_this] call spectate_events}];
					_x setVariable ["KEGs_EHKilled", _fh];
				};
			};
			if (!_iswu) then {
				_nunits set [count _nunits, _x];
				_m = createMarkerLocal [format[_markstr, count KEGs_markers], [0, 0, 0]];
				_m setMarkerTypeLocal "Dot";
				_m setMarkerSizeLocal [0.4, 0.4];
				_nn = if (alive _x) then {name _x} else {_unknownstr};
				KEGs_markers set [count KEGs_markers, [_m, _x, _nn]];

				_OriginalSide = _x call KEGs_CheckOriginalSide;
				KEGs_sidecache set [count KEGs_sidecache, _OriginalSide];

				_m setMarkerColorLocal (_OriginalSide call KEGs_GetMCol);
				_m setMarkerPosLocal (getPosASL (vehicle _x));

				_s = "#particlesource" createVehicleLocal getPosASL _x;
				KEGs_Tagsources set [count KEGs_Tagsources, [_x, _s]];

				if (KEGs_Tags == 1) then {
					["ToggleTags", [false, (_cameras select KEGs_cameraIdx)]] call spectate_events;
					["ToggleTags", [true, (_cameras select KEGs_cameraIdx)]] call spectate_events;
				};
				KEGs_namecache set [count KEGs_namecache, _nn];
			};
		} forEach _newUnits;

		KEGs_deathCam = [KEGs_deathCam, _nunits] call KEGs_fnc_arrayPushStack;				

		KEGs_NeedUpdateLB = true;
	};
	KEGs_lastCheckNewUnits = time;
	KEGs_newCheckUn = false;
};
