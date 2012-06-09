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
Delete a variable from the watcher

Call by :
["var"] call R3F_DEBUG_fnc_VarSpyDel;
var is the variable to remove from the watcher.
------------------------------------------------------------------------------*/
/*-----------------------------------------------------------------------------
Description :
Retirer une variable de la liste des variables à surveiller

Appel par :
["var"] call R3F_DEBUG_fnc_VarSpydel;
var est la variable à supprimer de la liste
------------------------------------------------------------------------------*/
#include "constants_R3F_DEBUG.sqf";
R3F_DEBUG_fnc_VarSpyDel ={
	[_this select 0] call FNCT_R3F_DEBUG_Spy_Del;
	true;
};
