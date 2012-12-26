﻿/**
 * Fait réapparaître un joueur en attente de réanimation à la base.
 * La position de réapparition est la même que celle qu'ArmA a
 * déterminé à l'aide du système de marqueurs "respawn_XXX".
 * 
 * Copyright (C) 2010 madbull ~R3F~
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

	// On ferme tout les fils d'exécution éventuels
	terminate R3F_REV_fil_exec_attente_reanimation;
	terminate R3F_REV_fil_exec_reapparaitre_camp;
	terminate R3F_REV_fil_exec_effet_inconscient;

	_camp = _this select 0;

// Mémorisation du fil d'exécution lancé
R3F_REV_fil_exec_reapparaitre_camp = [_camp] spawn
{

	// Camp can be ; base, tent, hq
	private ["_camp"];

	_camp = _this select 0;

	if(_camp == "tent") then {
		if(isnil "wctent") then {
			_camp = "base";
			wcrespawnmarker setmarkerposlocal [0,0];
			wcrespawnmarker setmarkersizelocal [0, 0];
			wcrespawnmarker setmarkertextlocal "";
		} else {
			if((getdammage wctent > 0.9) or !(alive wctent)) then {
				_camp = "base"; 
				wcrespawnmarker setmarkerposlocal [0,0];
				wcrespawnmarker setmarkersizelocal [0, 0];
				wcrespawnmarker setmarkertextlocal "";
			};
		};
	};

	if(_camp == "hq") then {
		if(format ["%1", wcteleport] == "any") then {
			_camp = "base";
		};
	};

	closeDialog 0;

	if(rank player == "Private") then {
		wcplayeraddscore = [player, -7];
	};
	if(rank player == "Corporal") then {
		wcplayeraddscore = [player, -6];
	};
	if(rank player == "Sergeant") then {
		wcplayeraddscore = [player, -5];
	};
	if(rank player == "Lieutenant") then {
		wcplayeraddscore = [player, -4];
	};
	if(rank player == "Captain") then {
		wcplayeraddscore = [player, -3];
	};
	if(rank player == "Major") then {
		wcplayeraddscore = [player, -2];
	};
	if(rank player == "Colonel") then {
		wcplayeraddscore = [player, -1];
	};
	["wcplayeraddscore", "server"] call WC_fnc_publicvariable;
	
	if (R3F_REV_CFG_afficher_marqueur) then
	{
		player setvariable ["deadmarker", false, true];
	};

	// On masque ce qui se passe au joueur (joueur dans les airs + animations forcés)
	R3F_REV_effet_video_couleur ppEffectAdjust [0.25, 1, 0, [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]];
	R3F_REV_effet_video_couleur ppEffectCommit 0;

	R3F_REV_corps_avant_mort = player;
	
	// Isoler le corps
	player setPos [getPos player select 0, getPos player select 1, 2000];
	player setDamage 0;
	
	// Stop animation blessé, reprise arme debout
	player selectWeapon (primaryWeapon player);
	player playMoveNow "AmovPercMstpSlowWrflDnon";
	
	sleep 3;

	// Retour du corps au marqueur de réapparition
	player setVelocity [0, 0, 0];

	switch (_camp) do {
		case "base": {
			wcgarbage = [localize "STR_R3F_REV_dontrespawnatbase"] call BIS_fnc_dynamicText;
			wcrespawntobase = name player;
			["wcrespawntobase", "all"] call WC_fnc_publicvariable;
			player setPos getmarkerpos "respawn_west";
			R3F_REV_nb_reanimations = R3F_REV_CFG_nb_reanimations;
		};

		case "hq": {
			wcgarbage = [localize "STR_R3F_REV_dontrespawnatbase"] call BIS_fnc_dynamicText;
			wcrespawntohq = name player;
			["wcrespawntohq", "all"] call WC_fnc_publicvariable;
			_position = (position wcteleport) findemptyposition [10, 300];
			if(count _position == 0) then {
				diag_log "WARCONTEXT: NO FOUND EMPTY POSITION FOR TELEPORT TO HQ";
			};
			player setpos _position;	
		};

		case "tent": {
			wcgarbage = [localize "STR_R3F_REV_dontrespawnatbase"] call BIS_fnc_dynamicText;
			wcrespawntotent = name player;
			["wcrespawntotent", "all"] call WC_fnc_publicvariable;
			player setpos (wcrespawnposition select 0);
		};
	};

	player setCaptive false;

	wcgarbage = [] spawn WC_fnc_restoreactionmenu;

	if(wcwithACE == 1) then {
		player addweapon "ACE_Earplugs";
	};
	
	ppEffectDestroy R3F_REV_effet_video_flou;
	ppEffectDestroy R3F_REV_effet_video_couleur;

	sleep 5;

	player setVehicleInit "this allowdammage true;";
	processInitCommands;
};