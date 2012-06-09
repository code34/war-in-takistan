/*******************************************************************************************
 Copyright (C) 2010 Team ~R3F~

 This program is free software under the terms of the GNU General Public License version 3.
 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.

@authors team-r3f.org
@version 0.01
@date 20100504

@function void FNCT_R3F_DEBUG_SetNeutrality
@params1 (boolean) CONST_R3F_DEBUG_NEUTRALITY_ON = neutralité, CONST_R3F_DEBUG_NEUTRALITY_OFF = non neutre
@return rien
********************************************************************************************/

#include "constants_R3F_DEBUG.sqf";

FNCT_R3F_DEBUG_SetNeutrality = {
	if ((count _this)>0) then{
		VAR_R3F_DEBUG_Neutrality = _this select 0;
	}else{
		VAR_R3F_DEBUG_Neutrality = CONST_R3F_DEBUG_NEUTRALITY_ON;
	};
	player setCaptive VAR_R3F_DEBUG_Neutrality;
};