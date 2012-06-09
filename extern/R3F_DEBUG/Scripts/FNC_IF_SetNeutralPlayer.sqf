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
Neutral player, nobody will kill him

Call by :
[kind] call R3F_DEBUG_fnc_SetNeutralPlayer;
kid : 0=player is sided, 1=player is neutral
------------------------------------------------------------------------------*/
/*-----------------------------------------------------------------------------
Description :
Le joueur est neutre, personne le lui tire dessus

Appel par :
[kind] call R3F_DEBUG_fnc_SetNeutralPlayer;
kid : 0=le joueur n'est pas neutre, 1=le joueur est neutre
------------------------------------------------------------------------------*/
#include "constants_R3F_DEBUG.sqf";
R3F_DEBUG_fnc_SetNeutralPlayer ={
	private ["_kind"];
	_kind = _this select 0;
	[_kind == 1] call FNCT_R3F_DEBUG_SetNeutrality;
	VAR_R3F_DEBUG_OptionValueIndices set [4, _kind];
	true;
};
