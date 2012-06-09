/****************************************************************************
Copyright (C) 2010 Team ~R3F~
This program is free software under the terms of the GNU General Public License version 3.
You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
@authors team-r3f.org
@version 0.01
@date 20101003
*****************************************************************************/
/*-----------------------------------------------------------------------------
Description :
God sight. Destroy and/or kill all that you look

Call by :
[level] call R3F_DEBUG_fnc_GodSight;
level : 0=no god sight, 1=kill all IA, 2=kill all IA and destroy all buildings
------------------------------------------------------------------------------*/
/*-----------------------------------------------------------------------------
Description :
Vue divine. Tuer et détruire tout ce qui est regardé

Appel par :
[level] call R3F_DEBUG_fnc_GodSight;
level : 0=pas de vue divine, 1=Tuer tous les IA, 2=Tuer tous les IA + destruction des batiments
------------------------------------------------------------------------------*/
#include "constants_R3F_DEBUG.sqf";
R3F_DEBUG_fnc_GodSight ={
	private ["_skill"];
	_level = _this select 0;
	VAR_R3F_DEBUG_OptionValueIndices set [2, _level];
	[_level] call FNCT_R3F_DEBUG_GodSight;
	true;
};
