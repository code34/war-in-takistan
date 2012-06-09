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
Kill them all !!!. Kill all IA on the mission

Call by :
[] call R3F_DEBUG_fnc_KillthemAll;
------------------------------------------------------------------------------*/
/*-----------------------------------------------------------------------------
Description :
Tuez les tous !!!, Tuez tous les IA de la mission

Appel par :
[] call R3F_DEBUG_fnc_KillthemAll;
------------------------------------------------------------------------------*/
#include "constants_R3F_DEBUG.sqf";
R3F_DEBUG_fnc_KillThemAll ={
	[] call FNCT_R3F_DEBUG_KillThemAll;
	true;
};
