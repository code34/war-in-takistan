// for Spectating Script;
// Handles events such as keyboard keypresses;
// by Kegetys <kegetys [ät] dnainternet.net>;

private ["_type", "_param", "_dummy", "_closest", "_id", "_i", "_d", "_key", "_y", "_button", "_lifeTime", "_dropPeriod", "_size", "_cam", "_u", "_s", "_color", "_colorB", "_txt", "_killed", "_killer", "_w", "_a", "_o", "_bar", "_bars", "_pos", "_b", "_len", "_dir", "_m2", "_name", "_m"];

_type = _this select 0;
_param = _this select 1;

#define KCCAMERA 55002
#define KCTARGET 55003
#define KCNAME 55004
#define KCLBCAMERAS 55005
#define KCLBTARGETS 55006
#define KCCAMERAsBG 55007
#define KCTARGETsBG 55008
#define KCBG1 55009
#define KCBG2 55010
#define KCTITLE 55011
#define KCHELP 55012
#define KCMAP 55013
#define KCMAPFULL 55014
#define KCMAPFULLBG 55015
#define KCRBUTTON1 50018
#define KCRBUTTON2 50019
#define KCRBUTTON3 50020
#define KCRBUTTON4 50021
switch (_type) do {
	// User clicked map, find nearest unit;
	case "MapClick": {
		_dummy = "HeliHEmpty" createVehicleLocal [_param select 0, _param select 1, 0];
		_closest = 5000;
		_id = -1;
		_idxx = 0;
		{
			if ((side _x) in KEGs_ShownSides) then {
				if (_x in KEGs_units) then {
					_d = _dummy distance _x;
					if (_d < _closest) then {_id = _idxx; _closest = _d};
				};
			};
			_idxx = _idxx + 1;
		} forEach KEGs_deathCam;
		if (_id != -1) then {
			KEGs_tgtIdx = _id;
			KEGs_DroppedCamera = false;
			if (ctrlVisible KCMAPFULL) then {
				[] spawn KEGs_togmapf;
			}
		};
		deleteVehicle _dummy;
	};
	
	case "KeyDown": {
		_key = _param select 1;
		// WSAD keys: camera movement in dropped mode;
		switch(_key) do {		
			case 32: {KEGs_CamRight = true};
			case 30: {KEGs_CamLeft = true};
			case 17: {KEGs_CamForward = true};
			case 31: {KEGs_CamBack = true};
			case 35: {
				if (KEGs_NoMarkersUpdates) then {
					KEGs_NoMarkersUpdates = false;
					titleCut ["\n\n\n\n\n\n\n\n\n Map Marker Updates Enabled","PLAIN", 0.2];
				} else {
					KEGs_NoMarkersUpdates = true;
					titleCut ["\n\n\n\n\n\n\n\n\n Map Marker Updates Disabled","PLAIN", 0.2];
				};
			};
		};
	};
	
	// Key up - process keypress;
	case "KeyUp": {
		_key = _param select 1;
		switch(_key) do {
			case 32: {
				// D = Next target;
				if (!KEGs_DroppedCamera) then {
					_cur = (lbCurSel KCLBTARGETS) + 1;
					if (_cur > (lbSize KCLBTARGETS) - 1) then {_cur = 0};
					lbSetCurSel [KCLBTARGETS, _cur];
				};
				KEGs_CamRight = false;
			};	
			case 30: {
				// A = Previous target;
				if (!KEGs_DroppedCamera) then {
					_cur = (lbCurSel KCLBTARGETS) - 1;
					if (_cur < 0) then {_cur = (lbSize KCLBTARGETS) - 1};
					lbSetCurSel [KCLBTARGETS, _cur];
				};
				KEGs_CamLeft = false;
			};
			case 17: {
				// W = Previous camera;
				if (!KEGs_DroppedCamera) then {
					KEGs_cameraIdx = KEGs_cameraIdx - 1;
					if (KEGs_cameraIdx < 0) then {KEGs_cameraIdx = 4};
					lbSetCurSel [KCLBCAMERAS, KEGs_cameraIdx];
				};
				KEGs_CamForward = false;
			};	
			case 31: {
				// S = Next camera;
				if (!KEGs_DroppedCamera) then {
					KEGs_cameraIdx = KEGs_cameraIdx + 1;
					if (KEGs_cameraIdx > 4) then {KEGs_cameraIdx = 0};
					lbSetCurSel [KCLBCAMERAS, KEGs_cameraIdx];
				};
				KEGs_CamBack = false;
			};
			
			case 20: {
				// T = Toggle tags;
				KEGs_Tags = abs (KEGs_Tags - 1);
				if (KEGs_Tags == 0) then {
					["ToggleTags", [false, objNull]] call spectate_events;
				};
			};
			
			case 33: {		
				// F = Toggle filter;
				KEGs_AIfilter = abs (KEGs_AIfilter - 1);
				KEGs_NeedUpdateLB = true;
			};
			
			case 34: {		
				// G = Toggle Group/Formation Leader filter;
				KEGs_gfleader = !KEGs_gfleader;
				KEGs_NeedUpdateLB = true;
			};

			case 22: {
				// U = Toggle Dead Player filter;
				if (!KEGs_RemoveDeadFilter) then {
					KEGs_DeadFilter = abs (KEGs_DeadFilter - 1);
					KEGs_NeedUpdateLB = true;
				};
			};
			
			case 57: {
				// Space - drop camera or toggle 1stperson/gunner;
				if (KEGs_cameras select KEGs_cameraIdx == KEGs_cam_1stperson) then {
					KEGs_1stGunner = !KEGs_1stGunner;
				} else {
					KEGs_DroppedCamera = !KEGs_DroppedCamera;
					if (KEGs_DroppedCamera) then {KEGs_cameraIdx = 0};
				};
			};
			
			// Direct camera change with number keys;
			case 2: {KEGs_cameraIdx = 0};
			case 3: {KEGs_cameraIdx = 1};
			case 4: {KEGs_cameraIdx = 2};
			case 5: {KEGs_cameraIdx = 3};
			case 6: {KEGs_cameraIdx = 4};
			
			// Toggle NVG or map text type;
			case 49: {
				if (ctrlVisible KCMAPFULL) then {
					KEGs_MarkerType = KEGs_MarkerType + 1;
					if (KEGs_MarkerType > 2) then { KEGs_MarkerType = 0};
				} else {
					KEGs_UseNVG = abs (KEGs_UseNVG - 1);
				};
			};
			
			case 50: {["ToggleMap", 0] call spectate_events};
			case 15: {["ToggleUI", 0] call spectate_events};
			case 59: {["ToggleHelp", 0] call spectate_events};
			
			// Numpad + / -;
			case 78: {if (KEGs_MarkerSize < 1.7) then { KEGs_MarkerSize = KEGs_MarkerSize * 1.15 }};
			case 74: {if (KEGs_MarkerSize > 0.7) then { KEGs_MarkerSize = KEGs_MarkerSize * (1/1.15)}};
			
			// exit spectating with X key, must be enabled
			case 45: {if (KEGs_can_exit_spectator) then {KEGs_exit_spectator = true}};
		}
	}; 	
	
	// Mouse events;
	case "MouseMoving": {
		_x = (_param select 1);
		_y = (_param select 2);
		KEGs_MouseCoord = [_x, _y];
	};
		
	case "MouseButtonDown": {
		_x = _param select 2;
		_y = _param select 3;
		_button = _param select 1;
		KEGs_MouseButtons set [_button, true];
		if (!KEGs_mousecheckon) then {
			[] spawn KEGS_HMouseButtons;
		};
	};
	case "MouseButtonUp": {
		_x = _param select 2;
		_y = _param select 3;
		_button = _param select 1;
		KEGs_MouseButtons set [_button, false];
	};	
	
	case "MouseZChanged": {
		KEGs_MouseScroll = KEGs_MouseScroll + (_param select 1);
	};	

	case "MouseZChangedminimap": {
		KEGs_MinimapZoom = KEGs_MinimapZoom + ((_param select 1) * 0.066);
		switch (true) do {
			case (KEGs_MinimapZoom > 0.5): {KEGs_MinimapZoom = 0.5};
			case (KEGs_MinimapZoom < 0.05): {KEGs_MinimapZoom = 0.05};
		};
	};			
		
	case "ToggleCameraMenu": {
		// Hide/unhide camera menu;
		if (ctrlVisible KCLBCAMERAS) then {
			ctrlShow [KCLBCAMERAS, false];
			ctrlShow [KCCAMERAsBG, false];
		} else {
			ctrlShow [KCLBCAMERAS, true];
			ctrlShow [KCCAMERAsBG, true];
		};
	};
	
	case "ToggleTargetMenu": {
		// Hide/unhide targets menu;
		if (ctrlVisible KCLBTARGETS) then {
			ctrlShow [KCLBTARGETS, false];
			ctrlShow [KCTARGETsBG, false];
		} else {
			ctrlShow [KCLBTARGETS, true];
			ctrlShow [KCTARGETsBG, true];
		};
	};
	
	case "ToggleUI": {
		// Hide/unhide UI;
		if (ctrlVisible KCNAME) then {
			{ctrlShow [_x, false]} foreach KEGs_SEUI;
		} else {
			{ctrlShow [_x, true]} foreach KEGs_SEUI;
			ctrlShow [KCHELP, false];
			ctrlShow [KCLBTARGETS, false];
			ctrlShow [KCTARGETsBG, false];
			ctrlShow [KCLBCAMERAS, false];
			ctrlShow [KCCAMERAsBG, false];
		};
	};
		
	case "ToggleHelp": {
		// Hide/unhide Help text;
		if (ctrlVisible KCHELP) then {ctrlShow [KCHELP, false]} else {ctrlShow [KCHELP, true]};
	};

	case "ToggleMap": {
		// Hide/unhide Map;
		if (ctrlVisible KCMAP && ctrlVisible KCMAPFULL) then {
			// Beginning, hide both;
			ctrlShow [KCMAP, false];
			ctrlShow [KCMAPFULL, false];
			ctrlShow [KCMAPFULLBG, false];
		};
		
		if (ctrlVisible KCMAP) then {
			ctrlShow [KCMAP, false];
			ctrlShow [KCMAPFULL, true];
			ctrlShow [KCMAPFULLBG, true];
			if (ctrlVisible KCLBTARGETS) then {
				ctrlShow [KCLBTARGETS, false];
				ctrlShow [KCTARGETsBG, false];
			};
			if (ctrlVisible KCLBCAMERAS) then {
				ctrlShow [KCLBCAMERAS, false];
				ctrlShow [KCCAMERAsBG, false];
			};
			ctrlShow [KCRBUTTON1, false];
			ctrlShow [KCRBUTTON2, false];
			ctrlShow [KCRBUTTON3, false];
			ctrlShow [KCRBUTTON4, false];
			KEGs_MarkerNames = true;
			KEGs_SoundVolume = soundVolume;
			0.5 fadeSound 0.2;
		} else {
			KEGs_MarkerNames = false;
			if (ctrlVisible KCMAPFULL) then {
				ctrlShow [KCMAPFULL, false];
				ctrlShow [KCMAPFULLBG, false];
				ctrlShow [KCRBUTTON1, true];
				ctrlShow [KCRBUTTON2, true];
				ctrlShow [KCRBUTTON3, true];
				ctrlShow [KCRBUTTON4, true];
				0.5 fadeSound KEGs_SoundVolume;
				KEGs_MissileCamOver = true;
			} else {
				ctrlShow [KCMAP, true];
			};
		};
	};
	
	case "ToggleMapBird": {
		if (!dialog) then {_dd = createDialog "rscSpectateBirdMap"} else {closeDialog 0};
	};
	
	// Toggle particlesource tags;
	case "ToggleTags": {
		if (KEGs_addonavailable) then {
			if (_param select 0) then {
				// turn on;
				_lifeTime = 0.5;
				_dropPeriod = 0.05;
				_size = 0.5;
				_cam = _param select 1;
				{
					_u = _x select 0;
					_s = _x select 1;
					if (alive _u) then {
						_size = 1.33 min (((vehicle _u) distance _cam) / 100);
						_color = switch (side _u) do {
							case east: {[1, 0, 0, 1]};
							case west: {[0, 0, 1, 1]};
							case resistance: {[0, 1, 0, 1]};
							default {[1, 1, 1, 1]};
						};
						_colorB = [_color select 0, _color select 1, _color select 2, 0];
						_s setParticleParams ["extern\spect\tag.p3d", "", "billboard", 1, _lifeTime, [0, 0, 2], [0, 0, 0], 1, 1, 0.784, 0.1, [_size, _size*0.66], [_color, _color, _color, _color, _colorB], [1], 10.0, 0.0, "", "", vehicle _u];
						_s setDropInterval _dropPeriod;
					} else {
						_s setDropInterval 0;
					};
				} foreach KEGs_Tagsources;
			} else {
				// turn off;
				{(_x select 1) setDropInterval 0} foreach KEGs_Tagsources;
			};
		};
	};	
	
	/*// Add string to event log;
	case "EventLogAdd": {
		_txt = _param select 0;
		diag_log _txt;
	};*/
	
	// Killed eventhandler, add to log, only available in SP
	case "UnitKilled": {
		_killed = _param select 0;
		_killer = _param select 1;
		_txt = format["%1 (%2) was killed by %3 (%4) (%5m)", _killed, _killed call KEGs_CheckOriginalSide, _killer, side _killer, _killed distance _killer];
		player groupChat _txt;
		diag_log _txt;
	};
	
	// Fired eventhandler, display as marker in map;
	// Also missile camera is handled here;
	case "UnitFired": {
		if (KEGs_MissileCamActive) exitWith {};
		_u = _param select 0;
		_w = _param select 1;
		_a = _param select 4;
		_o = (getpos _u) nearestObject _a;
		_type = getText(configFile >> "CfgAmmo" >> typeOf _o >> "simulation");
		if (KEGs_Tags == 1 && _type == "shotBullet" && KEGs_addonavailable) then {
			// Bullet path bar;
			_bar = switch (side _u) do {
				case west: {"KEGspect_bar_red"};
				case east: {"KEGspect_bar_green"};
				default {"KEGspect_bar_yellow"};
			};
			
			_bars = [];
			for "_i" from 0 to 300 step 5 do {
				_pos = _o modelToWorld [0, _i + 2.5, 0];
				_b = _bar createVehicleLocal _pos;
				_b setVectorDir (vectorDir _o);
				_b setVectorUp (vectorUp _o);
				_bars set [count _bars, _b];
			};
			_bars spawn KEGs_barsremove;
		};
		if (ctrlVisible KCMAPFULL) then {
			_len = (speed _o) / 15;
			_dir = getdir _o;
			// Marker for shot effect (stationary circle);
			_m2 = createMarkerLocal ["DOT", getPosASL _o];
			_m2 setMarkerColorLocal "ColorYellow";
			_m2 setMarkerSizeLocal [0.45, 0.45];
			_m2 setMarkerTypeLocal "Select";
			
			// Marker for round itself, for bullet display line, everything else a named marker
			if (_type in ["shotMissile", "shotRocket", "shotShell", "shotTimeBomb", "shotPipeBomb", "shotMine", "shotSmoke"]) then {
				_opos = getPosASL _o;
				_m = createMarkerLocal ["DOT", [(_opos select 0) + (sin _dir) * _len, (_opos select 1) + (cos _dir) * _len, 0]];
				_m setMarkerTypeLocal "Dot";
				_m setMarkerColorLocal "ColorWhite";
				_m setMarkerSizeLocal [0.25, 0.5];
				_name = getText(configFile >> "CfgWeapons" >> _w >> "displayName");
				_m setMarkerTextLocal _name;
				_m2 spawn KEGs_markerdel;
				[_m, _o] spawn KEGs_markerupdateev;
			} else {
				_opos = getPosASL _o;
				_m = createMarkerLocal ["DOT", [(_opos select 0) + (sin _dir) * _len, (_opos select 1) + (cos _dir) * _len, 0]];
				_m setMarkerShapeLocal "RECTANGLE";
				_m setMarkerSizeLocal [0.25, _len];
				_m setMarkerDirLocal (getdir _o);
				_m setMarkerColorLocal "ColorYellow";
				[_m2, _m] spawn KEGs_markerdel2;
			}
		} else {		
			// Missile camera;
			if (KEGs_UseMissileCam == 1 && !KEGs_DroppedCamera) then {
				if (_u == vehicle KEGs_target && (_type in ["shotMissile", "shotRocket", "shotShell"]) && !KEGs_MissileCamActive) then {
					_name = getText(configFile >> "CfgWeapons" >> _w >> "displayName");
					KEGs_MissileCamActive = true;
					cutText [_name, "PLAIN DOWN", 0.10];
					KEGs_cam_missile switchCamera "INTERNAL";
					KEGs_cam_missile cameraEffect ["internal", "BACK"];
					KEGs_cam_missile camSetTarget _o;
					KEGs_cam_missile camSetRelPos [0, 0, 0];
					KEGs_cam_missile camSetFov 0.5;
					KEGs_cam_missile camCommit 0;
					KEGs_cam_missile camSetFov 1.25;
					KEGs_cam_missile camCommit 2;
					_o spawn KEGs_missilcamrun;
				}
			};
		};
	};

	default {
		hint "Unknown event";
	};
};

false