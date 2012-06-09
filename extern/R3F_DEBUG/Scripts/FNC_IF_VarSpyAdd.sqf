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
Add a variable to the watcher for monitored it

Call by :
["var"] call R3F_DEBUG_fnc_VarSpyAdd;
var is the variable to be monitored. It can also be the result of a Arma's function
------------------------------------------------------------------------------*/
/*-----------------------------------------------------------------------------
Description :
Ajouter une variable à surveiller

Appel par :
["var"] call R3F_DEBUG_fnc_VarSpyAdd;
var est la variable à surveiller. Cela peut être aussi une fonction d'Arma
------------------------------------------------------------------------------*/
#include "constants_R3F_DEBUG.sqf";
R3F_DEBUG_fnc_VarSpyAdd ={
	[_this select 0] call FNCT_R3F_DEBUG_Spy_Add;
	true;
};
