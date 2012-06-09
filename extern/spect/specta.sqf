// Spectating Script for Armed Assault
// by Kegetys <kegetys [ät] dnainternet.net>

KEGs_can_exit_spectator = true;
KEGs_playable_only = true;
KEGs_no_butterfly_mode = true;

if (!isNil "KEGs_SPECTATINGON") exitWith {};
KEGs_SPECTATINGON = true;

waitUntil {time > 0};

disableSerialization;

private ["_player", "_killer", "_seagull"];

_player = player;
_killer = objnull;
_seagull = objnull;

if (isNil "KEGs_FuncsInited") then {
	KEGs_FuncsInited = true;
	call compile preprocessFileLineNumbers "extern\spect\spect_funcs.sqf";
	spectate_events = compile preprocessFileLineNumbers "extern\spect\specta_events.sqf";
	KEGs_menucamslbchange = compile preprocessFileLineNumbers "extern\spect\menucamslbchange.sqf";
};

private ["_factor", "_i", "_oldUseNVG", "_olduseMCam", "_oldTags", "_oldAIfilter", "_oldDeadFilter", "_flybydst", "_lastTgt", "_oldtarget", "_hasdropped", "_oldnname", "_oldnrole", "_oldcamselidx", "_oldCameraIdx", "_deadstr", "_unknownstr", "_name", "_pilotstr", "_driverstr", "_gunnerstr", "_commanderstr", "_selcamstr", "_clbcols", "_markstr", "_disp", "_kdowneh", "_kupeh", "_cCamera", "_cTarget", "_cName", "_cLBCameras", "_cLBTargets", "_cMap", "_cMapFull", "_cRButton1", "_cRButton2", "_cRButton3", "_cRButton4", "_nearest", "_rbuttonsvisible", "_pos", "_cameras", "_cameraNames", "_dummy", "_cLbSeparator", "_cLbMissileCam", "_cLbToggleNVG", "_cLbToggleTags", "_cLbToggleAiFilter", "_cLbToggleDeadFilter", "_tgtSelLast", "_nNoDialog", "_nextmarkertime", "_nextmaptime", "_lastUpdateTags", "_lasttgtIdx", "_cxpos", "_cypos", "_czpos", "_cspeedx", "_cspeedy", "_tbase", "_h", "_allUnits", "_allVehicles", "_nn", "_fh", "_gg", "_m", "_OriginalSide", "_s", "_strlifet", "_fangle", "_fangleY", "_sdistance", "_strlt", "_llbsize", "_idx", "_ot", "_oside", "_coldidx", "_rate", "_map", "_mm", "_dir", "_bb", "_foo", "_l", "_w", "_hstr", "_role", "_vectar", "_spd", "_spdbase", "_bstr", "_tbasebstr", "_objs", "_dist", "_d", "_vpmtw", "_gjp", "_lsdist", "_z", "_co", "_comSpeed", "_tt", "_t", "_doexitx", "_bpos", "_bird", "_ret"];

// safety check to wait for a still running spectator script
if (!isNil "KEGs_exit_spectator") then {waitUntil {isNil "KEGs_exit_spectator"}};

// KEGs_can_exit_spectator = true, the player can exit spectating with the X key
if (isNil "KEGs_can_exit_spectator") then {KEGs_can_exit_spectator = false};
// KEGs_playable_only = true, only playable (MP) or switchableUnits (SP) units will be shown in the target listbox
if (isNil "KEGs_playable_only") then {KEGs_playable_only = false};
// KEGs_no_butterfly_mode = true, if a player presses Esc he won't switch to butterfly mode but the spectating dialog gets restarted after a second
if (isNil "KEGs_no_butterfly_mode") then {KEGs_no_seagull_mode = false};
// markers are enabled as default, set KEGs_NoMarkersUpdates to true to completely disable marker updates
if (isNil "KEGs_NoMarkersUpdates") then {KEGs_NoMarkersUpdates = false};
// if KEGs_UseLog is set to true, spctator messages are written to group chat and RPT
// in Singleplayer killed messages are logged too
if (isNil "KEGs_UseLog") then {KEGs_UseLog = false};
// do also check if a unit is unconscious and don't add it to the target list, KEGs_CheckUncon = true
if (isNil "KEGs_CheckUncon") then {KEGs_CheckUncon = false};
// display only units in the target list that are max KEGs_CheckDist meters away, -1 = no check
if (isNil "KEGs_CheckDist") then {KEGs_CheckDist = -1};
// if KEGs_RemoveDeadFilter = true dead units will allways get removed from the target listbox, doesn't matter if you change it during spectating
if (isNil "KEGs_RemoveDeadFilter") then {KEGs_RemoveDeadFilter = false};

 // KEGs_showbuttonattime = 300 will show some buttons that you can assign actions to after 5 minutes (300 seconds)
 if (isNil "KEGs_showbuttonattime") then {
	_factor = if (isNil "KEGs_RevShowButtonTime") then {99999999999} else {KEGs_RevShowButtonTime};
	KEGs_showbuttonattime = time + _factor;
};

// if you add text to the array it will show the corresponding button
// for example, KEGs_RevButtons = ["Respawn 1", "Respawn 2", "", ""];
// will only show button 1 and 2 with
// You don't have to make an array with four elements, it will get filled automatically
// default no buttons visible
if (isNil "KEGs_RevButtons") then {KEGs_RevButtons = ["","","",""]};
if (count KEGs_RevButtons < 4) then {
	for "_i" from (count KEGs_RevButtons - 1) to 3 do {KEGs_RevButtons set [count KEGs_RevButtons, ""]};
};

if (isNil "KEGs_addonavailable") then {KEGs_addonavailable = false};

// Unit sides shown - Show all if sides not set
// example: KEGs_ShownSides = [west];
if (isNil "KEGs_ShownSides") then {
	KEGs_ShownSides = [west, east, resistance, civilian];
} else {
	if (count KEGs_ShownSides == 0 || count KEGs_ShownSides > 4) then {
		KEGs_ShownSides = [west, east, resistance, civilian];
	};
};

// Maximum distance for camera
// 10 ~ 100 m, 50 ~ 500 m, default = 50, example KEGs_maxDistance) = 20;
if (isNil "KEGs_maxDistance") then {KEGs_maxDistance = 50};

KEGs_SEUI = [55002, 55003, 55004, 55005, 55006, 55007, 55008, 55009, 55010, 55011, 55012];

_seagull = "noWait";
// If seagull is valid we came from the respawn scene
if (typeName _seagull != "string") then {
	_seagull setPos [-1000, -1000, 1000];
	sleep 1.5;
	titleCut["", "BLACK OUT", 1.5];
};

if (isNil "KEGs_OldNVGMethod") then {KEGs_OldNVGMethod = false};
KEGs_Spect_Init = false;
KEGs_target = objNull;
KEGs_MouseButtons = [false, false];
KEGs_MouseScroll = 0;
KEGs_MouseCoord = [0.5, 0.5];
KEGs_UseNVG = 0;
_oldUseNVG = 0;
KEGs_MissileCamActive = false;
KEGs_UseMissileCam = 1;
_olduseMCam = 1;
KEGs_MarkerNames = false;
KEGs_MarkerType = 1; // 0 = disabled, 1 = names, 2 = types
KEGs_Tags = 0;
_oldTags = 0;
KEGs_AIfilter = 0;
_oldAIfilter = 0;
KEGs_DeadFilter = if (KEGs_RemoveDeadFilter) then {1} else {0};
_oldDeadFilter = 0;
KEGs_MarkerSize = 1.0;
KEGs_MinimapZoom = 0.5;
KEGs_1stGunner = false;
KEGs_DroppedCamera = false;
KEGs_CamForward = false;
KEGs_CamBack = false;
KEGs_CamLeft = false;
KEGs_CamRight = false;
KEGs_NeedUpdateLB = false;
KEGs_exitspect = false;
KEGs_gfleader = false;
KEGs_units = [];
KEGs_MissileCamOver = false;
KEGs_markersrun = false;
KEGs_sdistance = 1;
KEGs_fangle  = 0;
KEGs_fangleY = 15;
_flybydst = 35;
KEGs_szoom = 0.976;
KEGs_markers = [];
KEGs_Tagsources = [];
KEGs_updating_lb = false;
_lastTgt = -1;

KEGs_mouseDeltaPos = [0, 0];

KEGs_mousecheckon = false;
KEGs_newCheckUn = false;

_oldtarget = objNull;
_hasdropped = true;

_oldnname = "";
_oldnrole = "";
_oldcamselidx = -1000;
_oldCameraIdx = -123;

_deadstr = "(DEAD) ";
_unknownstr = "Unknown";
_name = _unknownstr;
_pilotstr = "(Pilot)";
_driverstr = "(Driver)";
_gunnerstr = "(Gunner)";
_commanderstr = "(Commander)";
_selcamstr = "Camera: %1";

_clbcols = [[1, 0.5, 0, 1], [0.8, 0.8, 1, 1], [1, 0.8, 0.8, 1], [0.8, 1, 0.8, 1], [1, 1, 1, 1], [0.5, 0.5, 0.5, 1]];
_markstr = "KEGs_Marker%1";

KEGs_deathCam = [];
KEGs_ehVehicles = [];

if (typeName _seagull != "string") then {
	sleep 1;
	titleCut ["", "BLACK IN", 8];
} else {
	titleText["", "BLACK IN", 0];
};

createDialog "rscSpectate";
_disp = (findDisplay 55001);
_disp displaySetEventHandler ["KeyDown", "[""KeyDown"", _this] call spectate_events"];
_disp displaySetEventHandler ["KeyUp", "[""KeyUp"", _this] call spectate_events"];

(_disp displayCtrl 55012) ctrlSetStructuredText parseText ("Spectating Script v1.03 by Kegetys<br/><br/>" +
	"Click at the camera/target text at the top to open camera/target menus." + "<br/>" + "Units on the map can be clicked to target them." +
	"Keyboard controls:" + "<br/>" + "A/D - Previous/Next target" + "<br/>" +
	"W/S - Previous/Next camera" + "<br/>" + "1-5 - Direct camera change" + "<br/>" +
	"N - 3D view: Toggle night vision on/off" + "<br/>" + "N - Full map: Toggle marker text off/names/types" + "<br/>" +
	"T - Toggle unit tags on/off" + "<br/>" + "F - Toggle AI filter on/off" + "<br/>" +
	"G - Toggle Group/Formation Leader filter on/off" + "<br/>" + "H - Toggle Map Markers Updates on/off" + "<br/>" +
	"Tab - Toggle UI on/off" + "<br/>" + "M - Toggle map on/full/off" + "<br/>" +
	"Numpad plus/minus - Increase/decrease full map marker size" + "<br/>" + "Space - Drop camera (W,S,A,D keys = movement)" + "<br/>" +
	"Space - Toggle gunsight (1st person view)" + "<br/>" + "Esc - Butterfly mode" + "<br/>" +
	"X - Quit spectating (if enabled)" + "<br/><br/>" + "Mouse controls:" + "<br/>" +
	"Right button - Rotate camera (free camera mode only)" + "<br/>" + "Left button - Move camera" + "<br/>" +
	"Left and right button - Zoom" + "<br/><br/>Improvement modifications by Dwarden, Vipermaul and norrin<br/>Complete rewrite by Xeno<br/>");

["ToggleCameraMenu", 0] call spectate_events;
["ToggleTargetMenu", 0] call spectate_events;
["ToggleHelp", 0] call spectate_events;
["ToggleMap", 1] call spectate_events;

_cCamera = 55002;
_cTarget = 55003;
_cName = 55004;
_cLBCameras = 55005;
_cLBTargets = 55006;
_cMap = 55013;
_cMapFull = 55014;
_cRButton1 = 50018;
_cRButton2 = 50019;
_cRButton3 = 50020;
_cRButton4 = 50021;
_nearest = objNull;
_rbuttonsvisible = false;

KEGs_namecache = [];
KEGs_sidecache = [];

_pos = [(player modelToWorld [0, 0, 0] select 0) - 1 + random 2, (player modelToWorld [0, 0, 0] select 1) - 1 + random 2, 2];
KEGs_cam_static = "camera" camCreate _pos;
KEGs_cam_target = "camera" camCreate _pos;
KEGs_cam_free = "camera" camCreate _pos;
KEGs_cam_flyby = "camera" camCreate _pos;
KEGs_cam_topdown = "camera" camCreate _pos;
KEGs_cam_1stperson = "camera" camCreate _pos;
KEGs_cam_missile = "camera" camCreate _pos;
KEGs_cam_fullmap = "camera" camCreate _pos;
_cameras = [KEGs_cam_free, KEGs_cam_static, KEGs_cam_flyby, KEGs_cam_topdown, KEGs_cam_1stperson];
_cameraNames = ["Free", "Chase", "Flyby", "Top-down", "1st person"];
_dummy = "HeliHEmpty" createVehicleLocal [0, 0, 0];
KEGs_cameras = _cameras;

lbClear _cLBCameras;
{lbAdd [_cLBCameras, _x]} foreach _cameraNames;

_cLbSeparator = lbAdd [_cLBCameras, "---"];
lbSetColor [_cLBCameras, _cLbSeparator, [0.5, 0.5, 0.5, 0.5]];
_cLbMissileCam = lbAdd [_cLBCameras, "Missile camera"];
_cLbToggleNVG = lbAdd [_cLBCameras, "Night vision"];
_cLbToggleTags = lbAdd [_cLBCameras, "Unit tags"];
_cLbToggleAiFilter = lbAdd [_cLBCameras, "Filter AI"];
_cLbToggleDeadFilter = lbAdd [_cLBCameras, "Filter Unknown (Dead)"];

lbSetColor [_cLBCameras, _cLbMissileCam, [1, 0.5, 0, 1]];
lbSetColor [_cLBCameras, _cLbToggleNVG, [1, 1, 1, 0.33]];
lbSetColor [_cLBCameras, _cLbToggleTags, [1, 1, 1, 0.33]];
lbSetColor [_cLBCameras, _cLbToggleAiFilter, [1, 1, 1, 0.33]];
lbSetColor [_cLBCameras, _cLbToggleDeadFilter, [1, 1, 1, 0.33]];

KEGs_tgtIdx = 0;
KEGs_cameraIdx = 0;
KEGs_NewCameraIdx = 0;
showcinemaborder false;
lbClear _cLBTargets;
onMapSingleClick "['MapClick', _pos] call spectate_events";

if (KEGs_UseLog) then {["EventLogAdd", ["Initialize", [1, 1, 1, 1]]] call spectate_events};

[] spawn {
	sleep 3;
	if (dialog) then {
		if (!KEGs_can_exit_spectator) then {
			cutText["Press F1 for help", "PLAIN DOWN", 0.75];
		} else {
			cutText["Press F1 for help, X to exit spectating!", "PLAIN DOWN", 0.75];
		};
	};
};

KEGs_camSelLast = 0;
_tgtSelLast = -1;
KEGs_mouseLastX = 0.5;
KEGs_mouseLastY = 0.5;
_nNoDialog = 0;
KEGs_lastCheckNewUnits = -100;
_nextmarkertime = time + 3;
_nextmaptime = -100;
_lastUpdateTags = -100;
KEGs_lastAutoUpdateLB = time;
_lasttgtIdx = 0;
KEGs_CamPos = [0, 0, 0];
_cxpos = 0;
_cypos = 0;
_czpos = 0;
_cspeedx = 0;
_cspeedy = 0;
_tbase = 0.1;
_h = 2;
KEGs_unit_idx = 0;

startLoadingScreen ["Initializing Spectator Script..."];
KEGs_lastCheckNewUnits = time;

_allUnits = if (isNil "d_init_started") then {allUnits} else {if (isMultiplayer) then {playableUnits} else {switchableUnits}};
_allVehicles = vehicles;
if (count _allVehicles > 0) then {
	KEGs_ehVehicles = _allVehicles;
	{
		_nn = _x getVariable "KEGs_EHFired";
		if (isNil "_nn") then {
			_fh = _x addEventHandler ["fired", {["UnitFired",_this] call spectate_events}];
			_x setVariable ["KEGs_EHFired", _fh];
			_x setVariable ["KEGs_mapmove", false];
		};
	} foreach _allVehicles;
};
if (count _allUnits > 0) then {
	{
		_gg = _x getVariable "KEGs_SPECT";
		if (isNil "_gg") then {_gg = false};
		if (!_gg) then {
			_x setVariable ["KEGs_SPECT", true];
			_x setVariable ["KEGs_mapmove", false];
		};
		
		if (!isMultiplayer && KEGs_UseLog) then {
			_nn = _x getVariable "KEGs_EHKilled";
			if (isNil "_nn") then {
				_fh = _x addEventHandler ["killed", {["UnitKilled",_this] call spectate_events}];
				_x setVariable ["KEGs_EHKilled", _fh];
			};
		};
		
		_m = createMarkerLocal [format[_markstr, count KEGs_markers], [0, 0, 0]];
		_m setMarkerTypeLocal "Dot";
		_m setMarkerSizeLocal [0.4, 0.4];
		_nn = if (alive _x) then {name _x} else {_unknownstr};
		KEGs_markers set [count KEGs_markers, [_m, _x, _nn]];
		
		_OriginalSide = _x call KEGS_CheckOriginalSide;
		KEGs_sidecache set [count KEGs_sidecache, _OriginalSide];
		
		_m setMarkerColorLocal (_OriginalSide call KEGs_GetMCol);
		_m setMarkerPosLocal (getPosASL (vehicle _x));
		
		_s = "#particlesource" createVehicleLocal getPosASL _x;
		KEGs_Tagsources set [count KEGs_Tagsources, [_x, _s]];
		
		if (KEGs_Tags == 1) then {
			["ToggleTags",[false, (_cameras select KEGs_cameraIdx)]] call spectate_events;
			["ToggleTags",[true, (_cameras select KEGs_cameraIdx)]] call spectate_events;
		};
		KEGs_namecache set [count KEGs_namecache, _nn];
	} forEach _allUnits;
	
	KEGs_deathCam = _allUnits;
	KEGs_NeedUpdateLB = true;
};
endLoadingScreen;

while {dialog} do {
	KEGs_cameraIdx = KEGs_NewCameraIdx;
	_fangle = KEGs_fangle;
	_fangleY = KEGs_fangleY;
	KEGs_mouseDeltaPos set [0, KEGs_mouseLastX - (KEGs_MouseCoord select 0)];
	KEGs_mouseDeltaPos set [1, KEGs_mouseLastY - (KEGs_MouseCoord select 1)];
	KEGs_mouseLastX = KEGs_MouseCoord select 0;
	KEGs_mouseLastY = KEGs_MouseCoord select 1;
	if (KEGs_MouseScroll != 0) then {
		KEGs_sdistance = KEGs_sdistance - (KEGs_MouseScroll * 0.11);
		KEGs_MouseScroll = KEGs_MouseScroll * 0.75;
		switch (true) do {
			case (KEGs_sdistance > KEGs_maxDistance): {KEGs_sdistance = KEGs_maxDistance};
			case (KEGs_sdistance < -KEGs_maxDistance): {KEGs_sdistance = -KEGs_maxDistance};
		};
		if (KEGs_sdistance < -0.6) then {KEGs_sdistance = -0.6};
	};
	_sdistance = KEGs_sdistance;
	_llbsize = lbSize _cLBTargets;
	if (_llbsize > 0 && !KEGs_updating_lb) then {
		if (lbCurSel _cLBTargets > (_llbsize - 1)) then {
			lbSetCurSel [_cLBTargets, _llbsize - 1];
		};
		if (_tgtSelLast != lbCurSel _cLBTargets) then {
			KEGs_DroppedCamera = false;
			
			for "_idx" from 0 to (lbSize _cLBTargets) - 1 do {
				if (_idx == (lbSize _cLBTargets)) exitWith {};
				if (lbValue [_cLBTargets, _idx] == _lasttgtIdx) exitWith {
					_ot = KEGs_deathcam select _lasttgtIdx;
					_oside = KEGs_sidecache select _lasttgtIdx;
					_coldidx = if (alive _ot) then {switch (_oside) do {case west: {1};case east: {2};case resistance: {3};case civilian: {4};}} else {5};
					lbSetColor [_cLBTargets, _idx, _clbcols select _coldidx];
				};
			};
			
			_tgtSelLast = lbCurSel _cLBTargets;
			KEGs_tgtIdx = lbValue [_cLBTargets, _tgtSelLast];
			_lasttgtIdx = KEGs_tgtIdx;
			lbSetColor [_cLBTargets, _tgtSelLast, [1, 0.5, 0, 1]];
		};
	};
	
	if (time - KEGs_lastCheckNewUnits > 4 && !KEGs_MissileCamActive && !KEGs_NeedUpdateLB && !KEGs_newCheckUn) then {
		KEGs_newCheckUn = true;
		[_markstr,_unknownstr,_cameras] spawn KEGs_CheckNew;
	};
	
	if (count KEGs_deathCam < 1) exitWith {};
	if (!KEGs_Spect_Init) then {if (count KEGs_deathCam > 0) then {player groupChat "Spectator Mode Initialized."; KEGs_Spect_Init = true}};
	
	if ((KEGs_NeedUpdateLB || (time - KEGs_lastAutoUpdateLB > 20)) && !KEGs_MissileCamActive && !KEGs_markersrun && !KEGs_newCheckUn && !KEGs_updating_lb) then {
		[_cLBTargets, KEGs_sidecache, KEGs_namecache, _deadstr, _clbcols] spawn KEGs_UpdateLB;
	};
	
	if (!KEGs_updating_lb) then {
		if (!(KEGs_target in KEGs_units)) then {
			if (lbSize _cLBTargets > 0) then {
				KEGs_tgtIdx = lbValue [_cLBTargets, 0];
			};
		};
		
		switch (true) do {
			case (KEGs_tgtIdx > (count KEGs_deathCam - 1)): {KEGs_tgtIdx = (count KEGs_deathCam) - 1};
			case (KEGs_tgtIdx < 0): {KEGs_tgtIdx = 0};
		};
	};


	if (!KEGs_MissileCamActive) then {
		KEGs_target = KEGs_deathCam select KEGs_tgtIdx;
		if (_oldtarget != KEGs_target) then {
			if (!isNull _oldtarget) then {(vehicle _oldtarget) setVariable ["KEGs_mapmove", false]};
		};
		_oldtarget = KEGs_target;
		if (KEGs_cameraIdx != 4) then {
			if (_oldCameraIdx != KEGs_cameraIdx || KEGs_MissileCamOver) then {
				KEGs_MissileCamOver = false;
				(_cameras select KEGs_cameraIdx) cameraEffect["internal", "BACK"];
				(_cameras select KEGs_cameraIdx) camCommit 0;
				_oldCameraIdx = KEGs_cameraIdx;
			};
		};
	};
	if (KEGs_cameraIdx == 4) then {
		if (KEGs_1stGunner) then {
			if (cameraView != "GUNNER") then {(vehicle KEGs_target) switchCamera "GUNNER"};
		} else {
			(vehicle KEGs_target) switchCamera "INTERNAL";
		};
		_oldCameraIdx = KEGs_cameraIdx;
		(vehicle KEGs_target) cameraEffect ["terminate","BACK"];
		(vehicle KEGs_target) camCommit 0.01;
	};
	
	lbSetCurSel [_cLBCameras, KEGs_cameraIdx];

	if (lbValue [_cLBTargets, (lbCurSel _cLBTargets)] != KEGs_tgtIdx && !KEGs_updating_lb) then {
		for "_idx" from 0 to (lbSize _cLBTargets) - 1 do {
			if (_idx == (lbSize _cLBTargets)) exitWith {};
			if (lbValue [_cLBTargets, _idx] == KEGs_tgtIdx) exitWith {
				lbSetCurSel [_cLBTargets, _idx];
			};
		};
	};
	
	if (KEGs_OldNVGMethod) then {
		camUseNVG (if (KEGs_UseNVG == 1) then {true} else {false});
		setAperture (if (KEGs_UseNVG == 1) then {4} else {-1});
	} else {
		setAperture (if (KEGs_UseNVG == 1) then {0.07} else {-1});
	};
	
	if (ctrlVisible _cMapFull) then {
		KEGs_cam_fullmap cameraEffect ["internal", "BACK"];
	};

	if (KEGs_Tags == 1 && !KEGs_MissileCamActive) then {
		if (time - _lastUpdateTags > 0.3) then {
			_lastUpdateTags = time;
			["ToggleTags", [true, (_cameras select KEGs_cameraIdx)]] call spectate_events;
		};
	};
	
	if (!KEGs_NoMarkersUpdates) then {
		if (!KEGs_NeedUpdateLB) then {
			if (time > _nextmarkertime) then {
				_rate = (round ((count KEGs_markers) / 99)) max 1;
				_nextmarkertime = time + _rate;
				[KEGs_markers] spawn KEGs_updatemarkers;
			};
		};
	};

	if (time >= _nextmaptime) then {
		_nextmaptime = time + 0.2;
		_map = _disp displayCtrl _cMap;
		if (KEGs_DroppedCamera) then {
			ctrlMapAnimClear _map;
			_map ctrlMapAnimAdd [0.19, KEGs_MinimapZoom, [_cxpos, _cypos, 0]];
			ctrlMapAnimCommit _map;
			if (!isNull KEGs_target) then {(vehicle KEGs_target) setVariable ["KEGs_mapmove", false]};
		} else {
			_mm = (vehicle KEGs_target) getVariable "KEGs_mapmove";
			if (isNil "_mm") then {_mm = false};
			if (speed vehicle KEGs_target > 0 || !_mm) then {
				ctrlMapAnimClear _map;
				_map ctrlMapAnimAdd [(_nextmaptime - time - 0.01), KEGs_MinimapZoom, getPosASL KEGs_target];
				ctrlMapAnimCommit _map;
				(vehicle KEGs_target) setVariable ["KEGs_mapmove", true]
			};
		};
	};
	
	if (KEGs_tgtIdx != _lastTgt) then {
		_map = _disp displayCtrl _cMapFull;
		ctrlMapAnimClear _map;
		_lastTgt = KEGs_tgtIdx;
		_map ctrlMapAnimAdd [0.2, 1.0, getPosASL (KEGs_deathCam select _lastTgt)];
		ctrlMapAnimCommit _map;
	};
	
	_dir = direction vehicle KEGs_target;
	_bb = boundingBox vehicle KEGs_target;
	_foo = ((_bb select 1) select 2) - ((_bb select 0) select 2);
	_l = ((_bb select 1) select 1) - ((_bb select 0) select 1);
	_w = ((_bb select 1) select 0) - ((_bb select 0) select 0);
	
	_hstr = 0.15;
	_h = (_foo * _hstr) + (_h * (1 - _hstr));
	
	_role = "";
	if (KEGs_DroppedCamera && isNull _nearest) then {
		_name = ""; _role = "";
	} else {
		_vectar = vehicle KEGs_target;
		if (_vectar != KEGs_target) then {
			_role = switch (KEGs_target) do {
				case (driver _vectar): {if (_vectar isKindOf "Air") then {_pilotstr} else {_driverstr}};
				case (gunner _vectar): {_gunnerstr};
				case (commander _vectar): {_commanderstr};
				default {""};
			};
		};
		_name = KEGs_namecache select KEGs_tgtIdx;
	};
	if (_name != _oldnname || _role != _oldnrole) then {
		ctrlSetText [_cName, format ["%1 %2", _name, _role]];
		_oldnname = _name; _oldnrole = _role;
	};
	
	if (KEGs_cameraIdx != _oldcamselidx) then {
		ctrlSetText [_cCamera, format[_selcamstr, _cameraNames select KEGs_cameraIdx]];
		_oldcamselidx = KEGs_cameraIdx;
	};

	if (KEGs_DroppedCamera) then {
		(_disp displayCtrl _cName) ctrlSetTextColor [0.6, 0.6, 0.6, 1];
		_hasdropped = true;
	} else {
		if (_hasdropped) then {
			(_disp displayCtrl _cName) ctrlSetTextColor [1, 1, 1, 1];
			_hasdropped = false;
		};
	};
	
	if (_olduseMCam != KEGs_UseMissileCam) then {
		if (KEGs_UseMissileCam == 1) then {lbSetColor [_cLBCameras, _cLbMissileCam, [1, 0.5, 0, 1]]}
		else {lbSetColor [_cLBCameras, _cLbMissileCam, [1, 1, 1, 0.33]]};
		_olduseMCam = KEGs_UseMissileCam;
	};
	
	if (_oldUseNVG != KEGs_UseNVG) then {
		if (KEGs_UseNVG == 1) then {lbSetColor [_cLBCameras, _cLbToggleNVG, [1, 0.5, 0, 1]]}
		else {lbSetColor [_cLBCameras, _cLbToggleNVG, [1, 1, 1, 0.33]]};
		_oldUseNVG = KEGs_UseNVG;
	};
	
	if (_oldTags != KEGs_Tags) then {
		if (KEGs_Tags == 1) then {lbSetColor [_cLBCameras, _cLbToggleTags, [1, 0.5, 0, 1]]}
		else {lbSetColor [_cLBCameras, _cLbToggleTags, [1, 1, 1, 0.33]]};
		_oldTags = KEGs_Tags;
	};

	if (_oldAIfilter != KEGs_AIfilter) then {
		if (KEGs_AIfilter == 1) then {lbSetColor [_cLBCameras, _cLbToggleAiFilter, [1, 0.5, 0, 1]]}
		else {lbSetColor [_cLBCameras, _cLbToggleAiFilter, [1, 1, 1, 0.33]]};
		_oldAIfilter = KEGs_AIfilter;
	};

	if (_oldDeadFilter != KEGs_DeadFilter) then {
		if (KEGs_DeadFilter == 1) then {lbSetColor [_cLBCameras, _cLbToggleDeadFilter, [1, 0.5, 0, 1]]}
		else {lbSetColor [_cLBCameras, _cLbToggleDeadFilter, [1, 1, 1, 0.33]]};
		_oldDeadFilter = KEGs_DeadFilter;
	};
	
	if (KEGs_DroppedCamera) then {
		if (KEGs_cameraIdx != 0) then {
			KEGs_DroppedCamera = false;
		};
		
		if (KEGs_CamForward) then {
			_spd = (_sdistance max 1) * 20;
			_spdbase = _spd * _tbase;
			_cspeedx = _cspeedx + (_spdbase * sin _fangle);
			_cspeedy = _cspeedy + (_spdbase * cos _fangle);
		};
		if (KEGs_CamBack) then {
			_spd = (_sdistance max 1) * 20;
			_spdbase = -_spd * _tbase;
			_cspeedx = _cspeedx + (_spdbase * sin _fangle);
			_cspeedy = _cspeedy + (_spdbase * cos _fangle);
		};		
		if (KEGs_CamLeft) then {
			_spd = (_sdistance max 1) * 20;
			_spdbase = _spd * _tbase;
			_cspeedx = _cspeedx + (_spdbase * sin (_fangle - 90));
			_cspeedy = _cspeedy + (_spdbase * cos (_fangle - 90));
		};
		if (KEGs_CamRight) then {
			_spd = (_sdistance max 1) * 20;
			_spdbase = -_spd * _tbase;
			_cspeedx = _cspeedx + (_spdbase * sin (_fangle - 90));
			_cspeedy = _cspeedy + (_spdbase * cos (_fangle - 90));
		};				

		_cxpos = _cxpos + (_cspeedx * _tbase);
		_cypos = _cypos + (_cspeedy * _tbase);
		_czpos = 0;
		_h = 2;
		_l = 2.2;

		_bstr = 5;
		_tbasebstr = (1.0 - (_tbase * _bstr)) max 0;
		_cspeedx = _cspeedx * _tbasebstr;
		_cspeedy = _cspeedy * _tbasebstr;

		_dummy setpos[_cxpos, _cypos, 1.5];
		_objs = [_cxpos, _cypos, 1.5] nearObjects 10;
		_nearest = objNull;
		_dist = 10;
		{
			{
				_d = _dummy distance _x;
				if (_d < _dist && _x in KEGs_deathCam && alive _x) then {_nearest = _x; _dist = _d};
			} foreach crew _x;
		} foreach _objs;
		if (!isNull _nearest) then {KEGs_tgtIdx = KEGs_deathCam find _nearest};
	} else {
		_vpmtw = ((vehicle KEGs_target) modelToWorld [0, 0, 0]);
		_cxpos = _vpmtw select 0;
		_cypos = _vpmtw select 1;
		_czpos = _vpmtw select 2;
	};
	KEGs_cam_target camSetPos [_cxpos, _cypos, _czpos + (_h * 0.7)];
	KEGs_cam_static camSetTarget KEGs_cam_target;
	_gjp = [_cxpos, _cypos, _czpos + (_h * 0.6)];
	KEGs_cam_free camSetTarget _gjp;
	KEGs_cam_flyby camSetTarget KEGs_cam_target;
	KEGs_cam_topdown camSetTarget _gjp;
	{_x camSetFov KEGs_szoom} foreach _cameras;

	_lsdist = -(_l * _sdistance);
	KEGs_cam_static camSetRelPos [sin _dir * _lsdist, cos _dir * _lsdist, 0.6 * abs _sdistance];

	_lsdist = _l * (0.3 max _sdistance);
	_d = -_lsdist;
	_z = sin _fangleY * _lsdist;
	_co = cos _fangleY;
	KEGs_cam_free camSetRelPos [(sin _fangle * _d) * _co, (cos _fangle * _d) * _co, _z];
	KEGs_cam_free camCommit 0;

	if (KEGs_target distance KEGs_cam_flyby > (_flybydst * 1.1)) then {
		_flybydst = 20 + (speed vehicle KEGs_target);
		KEGs_cam_flyby camSetRelPos [sin _dir * _flybydst, cos _dir * _flybydst, 1 + ((random _h) * 1.5)];
		KEGs_cam_flyby camCommit 0;
		KEGs_cam_target camCommit 0;
	};

	KEGs_cam_topdown camSetRelPos [0.0, -0.01, 2 + ((0 max _sdistance) * 15)];
	KEGs_cam_topdown camCommit 0;

	_comSpeed = if ((vehicle KEGs_target) distance KEGs_cam_static > 650) then {0} else {(1.0 - ((speed vehicle KEGs_target) / 70)) max 0.0};
	KEGs_cam_static camCommit _comSpeed / 2;
	KEGs_cam_target camCommit _comSpeed / 3;
	KEGs_cam_flyby camCommit _comSpeed;

	_tt = time;
	sleep 0.0034;
	_tbase = time - _tt;
	if (!isNil "KEGs_exit_spectator") exitWith {};
};

d_phd_invulnerable = false;

titleText ["", "BLACK IN", 0.5];

{camDestroy _x} foreach _cameras;
camDestroy KEGs_cam_target;
camDestroy KEGs_cam_missile;
camDestroy KEGs_cam_fullmap;
deletevehicle KEGs_cam_target;
deletevehicle KEGs_cam_missile;
deletevehicle KEGs_cam_fullmap;
KEGs_exitspect = true;
sleep 0.01;
{deleteMarkerLocal (_x select 0)} foreach KEGs_markers;
deletevehicle _t;
if (KEGs_UseNVG == 1) then {setAperture -1};
onMapSingleClick "";
{deletevehicle (_x select 1)} foreach KEGs_Tagsources;
deleteVehicle _dummy;

{
	if (!isNull _x) then {
		_fh = _x getVariable "KEGs_EHFired";
		if (!isNil "_fh") then {_x removeEventHandler["fired", _fh]};
		_x setVariable ["KEGs_EHFired", nil];
	};
} foreach KEGs_ehVehicles;

{
	if (!isNull _x) then {
		(vehicle _x) setVariable ["KEGs_mapmove", nil];
		if (!isMultiplayer && KEGs_UseLog) then {
			_fh = _x getVariable "KEGs_EHKilled";
			if (!isNil "_fh") then {_x removeEventHandler["killed", _fh]};
		};
	};
} forEach KEGs_deathCam;

_doexitx = false;
if (!isNil "KEGs_exit_spectator") then {
	player switchCamera "INTERNAL";
	player cameraEffect["terminate", "FRONT"];
	closeDialog 0;
	_doexitx = true;
	KEGs_showbuttonattime = nil;
};

KEGs_deathCam = nil;
KEGs_units = nil;
KEGs_namecache = nil;
KEGs_sidecache = nil;
KEGs_MouseButtons = nil;
KEGs_MouseCoord = nil;
KEGs_units = nil;
KEGs_markers = nil;
KEGs_Tagsources = nil;
KEGs_mouseDeltaPos = nil;
KEGs_ehVehicles = nil;
KEGs_SEUI = nil;

KEGs_exit_spectator = nil;

if (_doexitx) exitWith {KEGs_SPECTATINGON = nil};

if (KEGs_no_butterfly_mode) exitWith {
	titleText ["", "BLACK OUT", 0.2];
	player switchCamera "INTERNAL";
	player cameraEffect["terminate", "FRONT"];
	sleep 2;
	titleText ["", "BLACK IN", 0.2];
	closeDialog 0;
	KEGs_SPECTATINGON = nil;
	d_phd_invulnerable = true;
	[] spawn {sleep 0.01; [_player, _killer, "noWait"] execVM "extern\spect\specta.sqf"};
};

_bpos = [(((vehicle KEGs_target) modelToWorld [0, 0, 0]) select 0) - 5 + random 10, (((vehicle KEGs_target) modelToWorld [0, 0, 0]) select 1) - 5 + random 10, 1];
_bird = "ButterFly" createVehicle _bpos;
_bird setVelocity [0, 0, 5];
_bird setPos _bpos;
_bird switchCamera "INTERNAL";
_bird cameraEffect ["terminate", "FRONT"];
_bird camCommand "manual on";

KEGs_Bird = _bird;
onMapSingleClick "KEGs_Bird setpos [_pos select 0, _pos select 1, 2]; KEGs_Bird setvelocity [0, 0, 5]; if (dialog) then {closeDialog 0}";

cutText ["Land on ground to return to spectating\nClick at map to jump to location", "PLAIN DOWN", 0.75];

KEGs_birdkeyDownEHId = (findDisplay 46) displayAddEventHandler ["KeyDown", "
	_ret = false;
	if ((_this select 1) in ([50] + (actionKeys 'ShowMap') + (actionKeys 'HideMap'))) then {
		['ToggleMapBird', 0] call spectate_events;
		_ret = true;
	};
	_ret
"];

waitUntil {(_bird modelToWorld [0, 0, 0]) select 2 < 0.05 && speed _bird < 1};
onMapSingleClick "";
if (dialog) then {closeDialog 0};
(findDisplay 46) displayRemoveEventHandler ["KeyDown", KEGs_birdkeyDownEHId];

sleep 0.5;

player switchCamera "INTERNAL";
player cameraEffect["terminate", "FRONT"];
deletevehicle _bird;
KEGs_SPECTATINGON = nil;
[_player, _killer, "noWait"] execVM "extern\spect\specta.sqf";