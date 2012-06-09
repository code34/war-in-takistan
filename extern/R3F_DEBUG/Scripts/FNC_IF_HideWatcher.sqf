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
Hide the variables spy panel

Call by :
[] call R3F_DEBUG_fnc_HideWatcher;
------------------------------------------------------------------------------*/
/*-----------------------------------------------------------------------------
Description :
Masquer le panneau des variables espionnées

Appel par :
[] call R3F_DEBUG_fnc_HideWatcher;
------------------------------------------------------------------------------*/

R3F_DEBUG_fnc_HideWatcher ={
	VAR_R3F_DEBUG_ShowDlgWatcher = false;
	[VAR_R3F_DEBUG_ShowDlgWatcher] call FNCT_R3F_DEBUG_ShowWatcher;
	true;
};
