#include "definitions.sqf"

class PresetDialog {
	idd = BON_PRESET_DIALOG;
	movingEnable = true;
	enableSimulation = true;
	onLoad = "[_this] execVM 'bon_loadoutpresets\bon_buildlistbox.sqf'";

	__EXEC( _xSpacing = 0.0075;  _ySpacing = 0.01;)
	__EXEC( _xInit = 12 * _xSpacing; _yInit = 18 * _ySpacing;)
	__EXEC( _windowWidth = 101; _windowHeight = 64;)
	__EXEC( _windowBorder = 1;)

	class controlsBackground
	{
		class Mainbackgrnd : HW_RscPicture {
			idc = BON_PRESET_BCKGRND;
			x = 0.042; y = 0.101;
			w = 1.2549; h = 0.836601;
			text = "\ca\ui\data\igui_background_debriefing_ca.paa";
		};
		class PresetTitle : HW_RscText {
		   	idc = BON_PRESET_TITLE;
			x = 0.11; y =  0.105;
			w = __EVAL(100 * _xSpacing);
			h = __EVAL(3 * _ySpacing);
			colorText[] = Color_White;
			colorBackground[] = { 1, 1, 1, 0 };
			sizeEx = 0.035;
			text = "";
		};
		class PresetSection : HW_RscText {
		   	idc = BON_PRESET_PRESETSECTION;
			x = 0.045; y =  0.305;
			w = __EVAL(50 * _xSpacing);
			h = __EVAL(3 * _ySpacing);
			colorText[] = Color_White;
			colorBackground[] = { 1, 1, 1, 0 };
			sizeEx = 0.035;
			text = "Presets:";
		};
	};

	class controls
	{
		class Available_presets: HW_RscGUIListBox {
			idc = BON_PRESET_LIST;
			default = 1;
			x = 0.045; y = 0.35;
			w = 0.44; h = 0.5;
			//lineSpacing = 0;
			onLBSelChanged = "['weapons'] call presetDialogUpdate";
			onLBDblClick = "[player,currentpreset] execVM 'bon_loadoutpresets\bon_equip.sqf';";
			rowHeight = 0.04;
			soundSelect[] = {"\ca\ui\data\sound\mouse2", 0.09, 1};
			maxHistoryDelay = 10;
			canDrag = 0;
			xcolumn1 = "0.1f";
			xcolumn2 = "0.25f";
			xcolumn3 = "0.85f";		
		};
		class PresetWeapons : HW_RscStructuredText {
		   	idc = BON_PRESET_WEAPONS;
			style = ST_MULTI;
			x = 0.51; y = 0.151;
			w = 0.465; h = 0.7;
			colorBackground[] = { 1, 1, 1, 0 };
			colorText[] = { 1, 1, 1, 1 };
			lineSpacing = 1;
			size = 0.0175;
		};
		class WeaponsPreview : HW_RscStructuredText {
		   	idc = BON_PRESET_WEAPONPREVIEW;
			style = ST_MULTI;
			x = 0.1; y = 0.16;
			w = 0.45; h = 0.12;
			colorBackground[] = { 1, 1, 1, 0 };
			colorText[] = { 1, 1, 1, 1 };
			lineSpacing = 1;
			size = 0.0425;
			class Attributes {
				font = FontM;
				color = "#FFFFFF";
				align = "center";
				valign = "middle";
				shadow = true;
				shadowColor = "#000000";
				size = "2.25";
			};
		};
		class WeaponsButton: HW_RscGUIShortcutButton{
			x = 0.052; y = 0.16;
			w = 0.1275; h = 0.0522876;
			sizeEx = 0.023;
			text = "weapons";
			onButtonClick = "['weapons'] call presetDialogUpdate";
		};
		class MagsButton : WeaponsButton {
			x = 0.052; y = 0.22;
			text = "magazines";
			onButtonClick = "['magazines'] call presetDialogUpdate";
		};
//		class RuckWepButton : WeaponsButton {
//			x = 0.219; y = 0.16;
//			w = 0.26;
//			text = "weapons in rucksack";
//			onButtonClick = "['ruckweps'] call presetDialogUpdate";
//		};
//		class RuckMagsButton : WeaponsButton {
//			x = 0.219; y = 0.22;
//			w = 0.26;
//			text = "magazines in rucksack";
//			onButtonClick = "['ruckmags'] call presetDialogUpdate";
//		};
		class EquipButton: HW_RscGUIShortcutButton {
			x = 0.8; //0.695;
			y = 0.867;
			text = "Equip";
			onButtonClick = "[player,currentpreset] execVM 'bon_loadoutpresets\bon_equip.sqf';";
		};
		class CloseButton: EquipButton {
			x = 0.6;
			text = "Close";
			onButtonClick = "CloseDialog 0;";
		};
	};
};