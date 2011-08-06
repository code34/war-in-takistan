private ["_selection", "_cLBCameras", "_selectedIndex", "_newIndex"];

disableSerialization;

_selection = _this;

_cLBCameras = _selection select 0;
_selectedIndex = _selection select 1;

if ((_selectedIndex == -1) || (lbCurSel _cLBCameras == KEGs_camSelLast)) exitWith {};

_newIndex = _selectedIndex;
switch (_selectedIndex) do {
	case 5: { // separator
		_newIndex = KEGs_camSelLast;
	};
	case 6: { // Special for toggling missile camera 
		KEGs_UseMissileCam = abs (KEGs_UseMissileCam - 1);
		_newIndex = KEGs_camSelLast;
	};
	case 7: { // Special for toggling NVG
		KEGs_UseNVG = abs (KEGs_UseNVG - 1);
		_newIndex = KEGs_camSelLast;
	};
	case 8: { // Special for toggling tags
		KEGs_Tags = abs (KEGs_Tags - 1);
		["ToggleTags", [if (KEGs_Tags == 1) then {true} else {false}, (KEGs_cameras select KEGs_cameraIdx)]] call spectate_events;
		_newIndex = KEGs_camSelLast;
	};
	case 9: { // Special for toggling AI filter
		KEGs_AIfilter = abs (KEGs_AIfilter - 1);
		_newIndex = KEGs_camSelLast;
		KEGs_NeedUpdateLB = true; // Request listbox update
	};
	case 10: { // Special for toggling Unknown (Dead) Players
		if (!KEGs_RemoveDeadFilter) then {
			KEGs_DeadFilter = abs (KEGs_DeadFilter - 1);
			KEGs_NeedUpdateLB = true; // Request listbox update
		};
		_newIndex = KEGs_camSelLast;
	};
};

if (_newIndex != KEGs_camSelLast) then {
	// Selected another camera - disable dropped cam
	KEGs_DroppedCamera = false;
};

KEGs_NewCameraIdx = _newIndex;
KEGs_camSelLast = _newIndex; //immediately capture the last selected camera index

true