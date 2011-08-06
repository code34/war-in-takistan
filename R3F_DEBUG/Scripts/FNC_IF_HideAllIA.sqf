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
Hide all IA on the map

Call by :
[] call R3F_DEBUG_fnc_HideAllIA;
------------------------------------------------------------------------------*/
/*-----------------------------------------------------------------------------
Description :
Cacher tous les IA sur la carte

Appel par :
[] call R3F_DEBUG_fnc_HideAllIA;
------------------------------------------------------------------------------*/
#include "constants_R3F_DEBUG.sqf";
R3F_DEBUG_fnc_HideAllIA ={
	VAR_R3F_DEBUG_OptionValueIndices set [0, false];
	[CONST_R3F_DEBUG_HIDE_IA] spawn FNCT_R3F_DEBUG_SetShowIA;
	true;
};
