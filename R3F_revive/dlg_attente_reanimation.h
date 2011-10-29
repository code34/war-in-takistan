/**
 * Boîte de dialogue affichant le bouton de réapparition au camp
 * 
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

class R3F_REV_dlg_attente_reanimation
{
	idd = 89453;
	
	// Masquer le bouton reapparaitre_camp si l'option n'est pas activée
	onLoad = "if !(R3F_REV_CFG_autoriser_reapparaitre_camp) then {_this select 0 displayCtrl 89454 ctrlShow false;} else {_this select 0 displayCtrl 89454 ctrlSetText STR_R3F_REV_btn_reapparition};";
	
	// Si on ferme la fenêtre avec échap, on la rouvre un peu plus tard (on laisse le temps de quitter la partie si voulu, sinon on remet le menu)
	onKeyDown = "if (_this select 1 == 1) then {[] spawn {sleep 2; if (damage player > 0.7 && isNull (findDisplay 89453)) then {createDialog ""R3F_REV_dlg_attente_reanimation"";};};}; false";
	
	controlsBackground[] = {};
	objects[] = {};
	controls[] =
	{
		R3F_REV_dlg_AR_btn_reapparaitre_hq,
		R3F_REV_dlg_AR_btn_reapparaitre_camp,
		R3F_REV_dlg_AR_btn_reapparaitre_tent
	};

	class R3F_REV_dlg_AR_btn_reapparaitre_camp
	{
		idc = 89454;
		
		type = 1;
		style = 0x02;
		w = 0.27; x = 0.73;
		h = 0.05; y = 0.9;
		text = "Respawn at base";
		action = "['base'] spawn R3F_REV_FNCT_reapparaitre_camp;";
		colorText[] = {0.65, 0.89, 0.52, 1};
		font = "BitStream";
		sizeEx = 0.035;
		colorBackground[] = {0.3, 0.4, 0.3, 1};
		colorFocused[] = {1, 0, 0, 1};
		colorDisabled[] = {0.5, 0.5, 0.5, 0.7};
		colorBackgroundDisabled[] = {0.2, 0.2, 0.2, 0.7};
		colorBackgroundActive[] = {0.5, 0.6, 0.5, 1};
		offsetX = 0.003;
		offsetY = 0.003;
		offsetPressedX = 0.002;
		offsetPressedY = 0.002;
		colorShadow[] = {0, 0, 0, 0.5};
		colorBorder[] = {0, 0, 0, 1};
		borderSize = 0;
		soundEnter[] = {"", 0, 1};
		soundPush[] = {"", 0.1, 1};
		soundClick[] = {"", 0, 1};
		soundEscape[] = {"", 0, 1};
	};

	class R3F_REV_dlg_AR_btn_reapparaitre_tent
	{
		idc = 89455;
		
		type = 1;
		style = 0x02;
		w = 0.27; x = 0.73;
		h = 0.05; y = 0.8;
		text = "Respawn at tent";
		action = "['tent'] spawn R3F_REV_FNCT_reapparaitre_camp;";
		colorText[] = {0.65, 0.89, 0.52, 1};
		font = "BitStream";
		sizeEx = 0.035;
		colorBackground[] = {0.3, 0.4, 0.3, 1};
		colorFocused[] = {1, 0, 0, 1};
		colorDisabled[] = {0.5, 0.5, 0.5, 0.7};
		colorBackgroundDisabled[] = {0.2, 0.2, 0.2, 0.7};
		colorBackgroundActive[] = {0.5, 0.6, 0.5, 1};
		offsetX = 0.003;
		offsetY = 0.003;
		offsetPressedX = 0.002;
		offsetPressedY = 0.002;
		colorShadow[] = {0, 0, 0, 0.5};
		colorBorder[] = {0, 0, 0, 1};
		borderSize = 0;
		soundEnter[] = {"", 0, 1};
		soundPush[] = {"", 0.1, 1};
		soundClick[] = {"", 0, 1};
		soundEscape[] = {"", 0, 1};
	};

	class R3F_REV_dlg_AR_btn_reapparaitre_hq
	{
		idc = 89456;
		
		type = 1;
		style = 0x02;
		w = 0.27; x = 0.73;
		h = 0.05; y = 1;
		text = "Respawn at HQ";
		action = "['hq'] spawn R3F_REV_FNCT_reapparaitre_camp;";
		colorText[] = {0.65, 0.89, 0.52, 1};
		font = "BitStream";
		sizeEx = 0.035;
		colorBackground[] = {0.3, 0.4, 0.3, 1};
		colorFocused[] = {1, 0, 0, 1};
		colorDisabled[] = {0.5, 0.5, 0.5, 0.7};
		colorBackgroundDisabled[] = {0.2, 0.2, 0.2, 0.7};
		colorBackgroundActive[] = {0.5, 0.6, 0.5, 1};
		offsetX = 0.003;
		offsetY = 0.003;
		offsetPressedX = 0.002;
		offsetPressedY = 0.002;
		colorShadow[] = {0, 0, 0, 0.5};
		colorBorder[] = {0, 0, 0, 1};
		borderSize = 0;
		soundEnter[] = {"", 0, 1};
		soundPush[] = {"", 0.1, 1};
		soundClick[] = {"", 0, 1};
		soundEscape[] = {"", 0, 1};
	};
};