/*******************************************************************************************
 Copyright (C) 2010 Team ~R3F~

 This program is free software under the terms of the GNU General Public License version 3.
 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.

@authors team-r3f.org
@version 0.01
@date 20100504

@function void FNCT_R3F_DEBUG_InfiniteAmmo
@params1 (boolean) CONST_R3F_DEBUG_INFINITEAMMO_ON = fonction activée, CONST_R3F_DEBUG_INFINITEAMMO_OFF = fonction désactivée
@return rien
********************************************************************************************/

#include "constants_R3F_DEBUG.sqf";

FNCT_R3F_DEBUG_InfiniteAmmo = {
	if ((count _this) > 0) then {
		VAR_R3F_DEBUG_InfiniteAmmoState = _this select 0;
	} else {
		VAR_R3F_DEBUG_InfiniteAmmoState = CONST_R3F_DEBUG_INFINITEAMMO_ON;
	};
	if ((VAR_R3F_DEBUG_InfiniteAmmoState) && (VAR_R3F_DEBUG_EH_InfAmmo == -1)) then {
		VAR_R3F_DEBUG_weapon = currentWeapon player;
		VAR_R3F_DEBUG_mag = configName (configFile >> "CfgMagazines" >> (currentMagazine player));
		VAR_R3F_DEBUG_bullet = getNumber (configFile >> "CfgMagazines" >> (currentMagazine player) >> "count");		
		VAR_R3F_DEBUG_count_bullet = 0;
		VAR_R3F_DEBUG_EH_InfAmmo = player addEventHandler ["Fired", {
			VAR_R3F_DEBUG_count_bullet = VAR_R3F_DEBUG_count_bullet + 1;
			if (VAR_R3F_DEBUG_weapon != (_this select 1)) exitWith {
				VAR_R3F_DEBUG_weapon = (_this select 1);
				VAR_R3F_DEBUG_mag = configName (configFile >> "CfgMagazines" >> (currentMagazine player));
				VAR_R3F_DEBUG_bullet = getNumber (configFile >> "CfgMagazines" >> (currentMagazine player) >> "count");
				if (VAR_R3F_DEBUG_bullet == VAR_R3F_DEBUG_count_bullet) then {
					(_this select 0) addMagazine VAR_R3F_DEBUG_mag;
					VAR_R3F_DEBUG_count_bullet = 0;
				} else {
					if (VAR_R3F_DEBUG_bullet != ((_this select 0) ammo VAR_R3F_DEBUG_weapon) + 1) then {
						VAR_R3F_DEBUG_count_bullet = (VAR_R3F_DEBUG_bullet - ((_this select 0) ammo VAR_R3F_DEBUG_weapon) + 1);
					} else {
						VAR_R3F_DEBUG_count_bullet = 1;
					};
				};
			};
			if (VAR_R3F_DEBUG_count_bullet < VAR_R3F_DEBUG_bullet) exitWith {};
			(_this select 0) addMagazine VAR_R3F_DEBUG_mag;
			VAR_R3F_DEBUG_count_bullet = 0;
		}];
	} else {
		if (VAR_R3F_DEBUG_EH_InfAmmo > -1) then {
			player removeEventHandler ["Fired",VAR_R3F_DEBUG_EH_InfAmmo];
			VAR_R3F_DEBUG_EH_InfAmmo = -1;
		};
	};
};