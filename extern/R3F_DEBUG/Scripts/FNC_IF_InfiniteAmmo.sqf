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
The ammo are infinite or not

Call by :
[kind] call R3F_DEBUG_fnc_InfiniteAmmo;
kind : 0=not infinite, 1= infinite
------------------------------------------------------------------------------*/
/*-----------------------------------------------------------------------------
Description :
Munitions infines

Appel par :
[kind] call R3F_DEBUG_fnc_InfiniteAmmo;
kind : 0=pas infinie, 1= infinie
------------------------------------------------------------------------------*/
#include "constants_R3F_DEBUG.sqf";
R3F_DEBUG_fnc_InfiniteAmmo ={
	private ["_kind"];
	_kind = _this select 0;
	[_kind == 1] call FNCT_R3F_DEBUG_InfiniteAmmo;
	VAR_R3F_DEBUG_OptionValueIndices set [7, _level];
	true;
};
