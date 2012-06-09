/**
 * Réaction à l'évènement killed : gère les effets, l'attente de soins, ...
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

if (_this select 0 != player) exitWith {};

if(vehicle (_this select 1) == (_this select 1)) then {
	wcplayeraddscore =  [(_this select 1), -1];
	["wcplayeraddscore", "server"] call WC_fnc_publicvariable;
};

// On ferme tout les fils d'exécution éventuels
terminate R3F_REV_fil_exec_attente_reanimation;
terminate R3F_REV_fil_exec_reapparaitre_camp;
terminate R3F_REV_fil_exec_effet_inconscient;

// Contexte interruptible et mémorisation du fil d'exécution lancé
R3F_REV_fil_exec_attente_reanimation = [] spawn {

	private ["_position_avant_mort", "_direction_avant_mort", "_chargeurs_avant_mort", "_armes_avant_mort", "_hasruck", "_hasruckace", "_ruckmags", "_ruckweapons", "_rucktype", "_enemy", "_sacados_avant_mort", "_backpack", "_weapononback", "_prisonneer", "_enemys"];
	
	// Mémorisation des données du cadavre avant qu'ArrowHead ne corompe la référence vers celui-ci
	_position_avant_mort = getPosatl R3F_REV_corps_avant_mort;
	_direction_avant_mort = getDir R3F_REV_corps_avant_mort;
	_chargeurs_avant_mort = magazines R3F_REV_corps_avant_mort;
	_armes_avant_mort = weapons R3F_REV_corps_avant_mort;

	_hasruck = false;
	_hasruckace = false;

	if!(isnull (unitBackpack R3F_REV_corps_avant_mort)) then {
		_hasruck = true;
		_backpack = unitBackpack R3F_REV_corps_avant_mort;
		_rucktype = typeof _backpack;
		_ruckmags = getMagazineCargo _backpack;
		_ruckweapons = getWeaponCargo _backpack;
	};

	_ruckmags = [];
	_ruckweapons = [];
	_weapononback = [];
	
	if(wcwithACE == 1) then {
		_weapononback = R3F_REV_corps_avant_mort getvariable "ACE_weapononback";
		if (R3F_REV_corps_avant_mort call ace_sys_ruck_fnc_hasRuck) then {
			_rucktype = R3F_REV_corps_avant_mort call ACE_Sys_Ruck_fnc_FindRuck;
			_ruckmags = R3F_REV_corps_avant_mort getvariable "ACE_RuckMagContents";
			_ruckweapons = R3F_REV_corps_avant_mort getvariable "ACE_RuckWepContents";
			_hasruckace = true;
		};
	};
	
	closeDialog 0;
	
	if (R3F_REV_CFG_afficher_marqueur) then {
		player setvariable ["deadmarker", false, true];
		deleteMarker R3F_REV_mark;
	};

	sleep 2;

	"dynamicBlur" ppEffectEnable true;
	"dynamicBlur" ppEffectAdjust [0];
	"dynamicBlur" ppEffectCommit 1;
	
	// Effet de fondu en noir pour symbolisé la mort du joueur
	ppEffectDestroy R3F_REV_effet_video_flou;
	R3F_REV_effet_video_flou = ppEffectCreate ["DynamicBlur", 472];
	R3F_REV_effet_video_flou ppEffectEnable true;
	R3F_REV_effet_video_flou ppEffectAdjust [0.3+random 0.3];
	R3F_REV_effet_video_flou ppEffectCommit 2;
	
	ppEffectDestroy R3F_REV_effet_video_couleur;
	R3F_REV_effet_video_couleur = ppEffectCreate ["ColorCorrections", 1587];
	R3F_REV_effet_video_couleur ppEffectEnable true;
	R3F_REV_effet_video_couleur ppEffectAdjust [0.25, 1, 0, [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]];
	R3F_REV_effet_video_couleur ppEffectCommit 2;
	
	// Attendre que le nouveau corps apparaissent
	waitUntil {alive player};

	hidebody R3F_REV_corps_avant_mort;

	player setVehicleInit "this allowdammage false;";
	processInitCommands;

	wcaddkilled = player;
	["wcaddkilled", "all"] call WC_fnc_publicvariable;
	
	if (R3F_REV_nb_reanimations > 0) then {
		private ["_nb_soins_suppl"];
	
		// Isoler le nouveau corps
		player setPos [_position_avant_mort select 0, _position_avant_mort select 1, 2000];
		
		player setCaptive true;
		
		// Retrait de l'équipement
		removeAllWeapons player;
		removeAllItems player;
		if!(_hasruck) then { removebackpack player; };
		
		// Couché sans arme dans les mains, posture blessé
		player switchMove "AmovPpneMstpSnonWnonDnon_injured";
		
		// Restauration des armes d'avant le décès
		{player addMagazine _x;} forEach _chargeurs_avant_mort;
		{player addWeapon _x;} forEach _armes_avant_mort;

		if(wcwithACE == 1) then {
			if (_hasruckace) then {
				[player, "ALL"] call ACE_fnc_RemoveGear;
				if (!isNil "_ruckmags") then {
					player setvariable ["ACE_RuckMagContents", _ruckmags];
				};
				if (!isNil "_ruckweapons") then {
					player setvariable ["ACE_RuckWepContents", _ruckweapons];
				};
			};
			if (!isNil "_weapononback") then {
				[player, "WOB"] call ACE_fnc_RemoveGear;
				player setvariable ["ACE_weapononback", _weapononback];
			};
		};
		if (_hasruck) then {
			[player, [_rucktype, _ruckweapons, _ruckmags]] call R3F_REV_FNCT_assigner_sacados;
		};

		// Marqueur sur la position du joueur, si l'option est activée
		if (R3F_REV_CFG_afficher_marqueur) then {
			player setvariable ["deadmarker", true, true];
		};
		
		// Ouverture de la boîte de dialogue qui permet le respawn base et de désactivation les interactions in-game
		closeDialog 0;
		createDialog "R3F_REV_dlg_attente_reanimation";
		wcgarbage = [localize "STR_R3F_REV_attente_reanimation"] call BIS_fnc_dynamicText;

		// On blesse le nouveau corps pour qu'il nécessite des soins d'un medic
		player setDamage 0.8;
		
		sleep 5;
		
		// Ramener le nouveau corps au lieu du décès
		player setVelocity [0, 0, 0];
		player setDir _direction_avant_mort;
		player setPosatl _position_avant_mort;
		
		// Suppression de l'ancien corps (compatibilité ArmA2)
		deletevehicle R3F_REV_corps_avant_mort;
		
		// On mémorise le nouveau corps pour la prochaine fois que le joueur mourra
		R3F_REV_corps_avant_mort = player;
		
		// Fil d'exécution générant des effets vidéo et d'animations symbolisant l'état inconscient
		// Il sera terminé dès que le joueur aura reçu des soins
		R3F_REV_fil_exec_effet_inconscient = [] spawn
		{
			while {(damage player > 0.7)} do
			{
				R3F_REV_effet_video_flou ppEffectAdjust [0.3+random 0.3];
				R3F_REV_effet_video_flou ppEffectCommit 0;
					
				player playMoveNow "AmovPpneMstpSnonWnonDnon_healed";
				R3F_REV_effet_video_couleur ppEffectAdjust [random 0.3, random 0.2, 0, [random 1, 0, 0, 0.1], [1, 0, 0, 0], [1, 0, 0, 0]];
				R3F_REV_effet_video_couleur ppEffectCommit (2.2+random 0.4);
				sleep random 4;
					
				player playMoveNow "AmovPpneMstpSnonWnonDnon_injured";
				R3F_REV_effet_video_couleur ppEffectAdjust [0.25, 1, 0, [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]];
				R3F_REV_effet_video_couleur ppEffectCommit (1.7+random 0.2);
				sleep random 4;
			};
		};

		// Attente d'un soin par medic
		while {((damage player > 0.7) and !(wcteamscore < wcscorelimitmin) and !(wcteamscore > wcscorelimitmax))} do {
			sleep 1;
		};
	
		if (R3F_REV_CFG_afficher_marqueur) then {
			player setvariable ["deadmarker", false, true];
		};

		player setVehicleInit "this allowdammage true;";
		processInitCommands;
		
		// On le reblaisse quand même par mesure de réalisme
		player setDamage 0.4;
		
		// Retour en vue normale du jeu
		terminate R3F_REV_fil_exec_effet_inconscient;
		closeDialog 0;
		ppEffectDestroy R3F_REV_effet_video_flou;
		ppEffectDestroy R3F_REV_effet_video_couleur;
		
		sleep 0.2;
		// Stop animation blessé, reprise arme
		player selectWeapon (primaryWeapon player);
		player playMoveNow "AmovPpneMstpSrasWrflDnon";
		
		R3F_REV_nb_reanimations = R3F_REV_nb_reanimations - 1;
		
		// Il est de retour au combat, donc il n'est plus ignoré par l'IA
		player setCaptive false;
		
		if (R3F_REV_nb_reanimations > 0) then {
			if (R3F_REV_nb_reanimations > 1) then {
				wcgarbage = [format [localize "STR_R3F_REV_nb_reanimations_plusieurs", R3F_REV_nb_reanimations]] call BIS_fnc_dynamicText;
			} else {
				wcgarbage = [format [localize "STR_R3F_REV_nb_reanimations_une", R3F_REV_nb_reanimations]] call BIS_fnc_dynamicText;
			};
		}
		else {
			wcgarbage = [localize "STR_R3F_REV_nb_reanimations_zero"] call BIS_fnc_dynamicText;
		};

		wcgarbage = [] spawn WC_fnc_restoreactionmenu;

		if(wcwithACE == 1) then {
			player addweapon "ACE_Earplugs";
		};
	} else {
		wcrespawntobase = name player;
		["wcrespawntobase", "server"] call WC_fnc_publicvariable;

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

		wcgarbage = [localize "STR_R3F_REV_plus_de_reanimation"] call BIS_fnc_dynamicText;
		
		R3F_REV_nb_reanimations = R3F_REV_CFG_nb_reanimations;
			
		// Restauration des armes d'avant le décès
		if!(_hasruck) then { removebackpack player; };
		removeAllWeapons player;
		removeAllItems player;

		{player addMagazine _x;} forEach _chargeurs_avant_mort;
		{player addWeapon _x;} forEach _armes_avant_mort;
		player selectWeapon (primaryWeapon player);

		if(wcwithACE == 1) then {
			if (_hasruck) then {
				removeBackpack player;
				player addweapon _rucktype;
				if (!isNil "_ruckmags") then {
					player setvariable ["ACE_RuckMagContents", _ruckmags];
				};
				if (!isNil "_ruckweapons") then {
					player setvariable ["ACE_RuckWepContents", _ruckweapons];
				};
			};
		} else {
			if !(isNil "R3F_REV_FNCT_assigner_sacados") then {
				[player, _sacados_avant_mort] call R3F_REV_FNCT_assigner_sacados;
			};
		};

		if (R3F_REV_CFG_afficher_marqueur) then {
			player setvariable ["deadmarker", false, true];
		};
			
		// Retour du corps au marqueur de réapparition
		player setVelocity [0, 0, 0];
		player setPos getmarkerpos "respawn_west";

		player setVehicleInit "this allowdammage true;";
		processInitCommands;
			
		sleep 5;
		wcgarbage = [localize "STR_R3F_REV_respawn_camp"] call BIS_fnc_dynamicText;
			
		ppEffectDestroy R3F_REV_effet_video_flou;
		ppEffectDestroy R3F_REV_effet_video_couleur;

		R3F_REV_corps_avant_mort = player;

		wcgarbage = [] spawn WC_fnc_restoreactionmenu;
	};
};