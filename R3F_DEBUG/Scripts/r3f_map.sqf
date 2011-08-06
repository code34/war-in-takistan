/*******************************************************************************************
 Copyright (C) 2010 Team ~R3F~

 This program is free software under the terms of the GNU General Public License version 3.
 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.

@authors team-r3f.org
@version 0.01
@date 20100528
********************************************************************************************/

private ["_cam"];

#include "constants_R3F_DEBUG.sqf";
#include "r3f_debug_command_panel_includes.h"

disableSerialization;
_display = uiNamespace getVariable "VAR_R3F_DEBUG_DLG_ShowMap";

_title = _display displayCtrl R3F_DEBUG_ID_Title;
_btn_ok = _display displayCtrl R3F_DEBUG_ID_MapOk;

if(VAR_R3F_DEBUG_MapMode == CONST_R3F_DEBUG_MAP4TELEPORT) then {
	_title ctrlSetText localize "STR_R3F_DEBUG_CLICKONMAP_TELEPORT";
}else{
	if(VAR_R3F_DEBUG_MapMode == CONST_R3F_DEBUG_MAP4CAMERA) then {
		_title ctrlSetText localize "STR_R3F_DEBUG_CLICKONMAP_CAMERA";
	};	
};

if ( (count _this) > 0) then {
	if ( (_this select 1) == 0 ) then {
		if(!isnil("VAR_R3F_DEBUG_MapMarker")) then {
			deleteMarkerLocal VAR_R3F_DEBUG_MapMarker;
			VAR_R3F_DEBUG_MapMarker = nil;
		};
		VAR_R3F_DEBUG_MapMarkerPos = (_this select 0) ctrlMapScreenToWorld [_this select 2, _this select 3];
		VAR_R3F_DEBUG_MapMarker = createMarkerLocal["markername",[VAR_R3F_DEBUG_MapMarkerPos select 0,VAR_R3F_DEBUG_MapMarkerPos select 1]];
		VAR_R3F_DEBUG_MapMarker setMarkerShapeLocal "ICON";
		VAR_R3F_DEBUG_MapMarker setMarkerTypeLocal "DOT";
	};
	if ( ((_this select 1) == 1) && (!isnil("VAR_R3F_DEBUG_MapMarker")) ) then {
		if(VAR_R3F_DEBUG_MapMode == CONST_R3F_DEBUG_MAP4TELEPORT) then {
			[[VAR_R3F_DEBUG_MapMarkerPos select 0, VAR_R3F_DEBUG_MapMarkerPos select 1, 0]] call FNCT_R3F_DEBUG_DoTeleport;
		}else{
			if(VAR_R3F_DEBUG_MapMode == CONST_R3F_DEBUG_MAP4CAMERA) then {
				[[(VAR_R3F_DEBUG_MapMarkerPos  select 0), (VAR_R3F_DEBUG_MapMarkerPos  select 1), 30]] call FNCT_R3F_DEBUG_DoCamera;
			};
		};	
	};
	if ( ((_this select 1) == 2) && (!isnil("VAR_R3F_DEBUG_MapMarker"))) then {
		deleteMarkerLocal VAR_R3F_DEBUG_MapMarker;
		VAR_R3F_DEBUG_MapMarker = nil;
	};
};

_btn_ok ctrlEnable (!isnil("VAR_R3F_DEBUG_MapMarker"));
