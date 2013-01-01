/*******************************************************************************************
 Copyright (C) 2010 Team ~R3F~

 This program is free software under the terms of the GNU General Public License version 3.
 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.

@authors team-r3f.org
@version 0.01
@date 20100504
@function void FNCT_R3F_DEBUG_SetInvulnerability
@params1 (boolean) true = invulnérabilité, false = non invulnérable
@return rien
********************************************************************************************/

FNCT_R3F_DEBUG_SetTeleportation = {
	if((count _this)==0) then{
		VAR_R3F_DEBUG_Teleportation = true;
	}else{
		VAR_R3F_DEBUG_Teleportation = _this select 0;
	};
	if (VAR_R3F_DEBUG_Teleportation) then {
		onMapSingleClick "vehicle player setpos [_pos select 0, _pos select 1]; true;";
	} else {
		onMapSingleClick "";
	};
};