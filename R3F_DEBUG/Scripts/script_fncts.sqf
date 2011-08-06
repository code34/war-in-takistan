/*******************************************************************************************
 Copyright (C) 2010 Team ~R3F~

 This program is free software under the terms of the GNU General Public License version 3.
 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.

@authors team-r3f.org
@version 0.01
@date 20100906
********************************************************************************************/

#include "r3f_debug_command_panel_includes.h"
#include "constants_R3F_DEBUG.sqf";
private ["_ed_script","_action"];

_action = _this select 0;

disableSerialization;

_dlg = uiNamespace getVariable "R3F_SCRIPT_DLG";

_ed_script = _dlg displayCtrl R3F_DEBUG_ID_SCRIPT_EDITOR;

if(_action=="do_init") then {
	_ed_script ctrlSetText VAR_R3F_DEBUG_Default_Script;
};
if(_action=="do_exec") then {
	VAR_R3F_DEBUG_Default_Script = ctrlText _ed_script;
	VAR_R3F_EXECUTED_SCRIPT = VAR_R3F_EXECUTED_SCRIPT + [[] spawn {call compile VAR_R3F_DEBUG_Default_Script;}];	
};
if(_action=="do_terminate") then {
	{
		terminate _x;
		VAR_R3F_EXECUTED_SCRIPT = VAR_R3F_EXECUTED_SCRIPT - [_x];
	}foreach VAR_R3F_EXECUTED_SCRIPT;
};
if(_action=="do_raz") then {
	VAR_R3F_DEBUG_Default_Script = "";
	_ed_script ctrlSetText VAR_R3F_DEBUG_Default_Script;
};
if(_action=="do_close") then {
	closeDialog 0;
};
