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
Inactive or active IA.

Call by :
[kind] call R3F_DEBUG_fnc_InActiveIA;
kid : 0=IA are active, 1=IA are inactive
------------------------------------------------------------------------------*/
/*-----------------------------------------------------------------------------
Description :
Désactiver ou activer les IA

Appel par :
[kind] call R3F_DEBUG_fnc_GodSight;
kind : 0=Les IA sont inactifs, 1=Les IA sont actifs
------------------------------------------------------------------------------*/
#include "constants_R3F_DEBUG.sqf";
R3F_DEBUG_fnc_InactiveIA ={
	private ["_kind"];
	_kind = _this select 0;
	VAR_R3F_DEBUG_OptionValueIndices set [3, _kind];
	if( _kind == 0) then{
		[] call FNCT_R3F_DEBUG_InactiveIA;
	}else{
		[] call FNCT_R3F_DEBUG_ActiveIA;
	};	
	true;
};
