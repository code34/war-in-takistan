/*******************************************************************************************
 Copyright (C) 2010 Team ~R3F~

 This program is free software under the terms of the GNU General Public License version 3.
 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.

@authors team-r3f.org
@version 0.01
@date 20100509

@function void FNCT_R3F_DEBUG_SetSkill
@params1 (int) Skill factor
@return none
********************************************************************************************/

#include "constants_R3F_DEBUG.sqf";

FNCT_R3F_DEBUG_SetSkill = {
	private ["_pos_center","_array_ai"];
	if((count _this)>0) then{
		VAR_R3F_DEBUG_Skill = _this select 0;
	}else{
		VAR_R3F_DEBUG_Skill = CONST_R3F_DEBUG_SKILL_NORMAL;
	};
	_array_ai = allunits;
	{
		if ((playerSide != side _x) && (side _x != Civilian)) then {
			_x setskill VAR_R3F_DEBUG_Skill;
		};
	} foreach _array_ai;
};