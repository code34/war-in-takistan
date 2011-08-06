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
The player will move faster and faster as the chosen level

Call by :
[level] call R3F_DEBUG_fnc_GoFaster;
level : 1=normal, 2= faster, 3=faster++, 4=rambo, 5=like when you'e purchased by a dog
------------------------------------------------------------------------------*/
/*-----------------------------------------------------------------------------
Description :
Le joueur se déplacera de plus en plus vite selon le niveau choisi

Appel par :
[level] call R3F_DEBUG_fnc_GoFaster;
level : 1=normal, 2= faster, 3=faster++, 4=rambo, 5=like when you'e purchased by a dog
------------------------------------------------------------------------------*/
#include "constants_R3F_DEBUG.sqf";
R3F_DEBUG_fnc_GoFaster ={
	private ["_level"];
	_level = _this select 0;
	VAR_R3F_DEBUG_SetVelocity = switch (_level) do
	{
  		case 0: {CONST_R3F_DEBUG_VELOCITY1};
  		case 1: {CONST_R3F_DEBUG_VELOCITY2};
  		case 2: {CONST_R3F_DEBUG_VELOCITY4};
  		case 3: {CONST_R3F_DEBUG_VELOCITY8};
  		case 4: {CONST_R3F_DEBUG_VELOCITY16};
  		case 5: {CONST_R3F_DEBUG_VELOCITY32};
	};
	VAR_R3F_DEBUG_OptionValueIndices set [6, _level];
	true;
};
