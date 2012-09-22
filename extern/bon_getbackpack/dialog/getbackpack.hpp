#include "definitions.sqf"

class getBackpackDialog {
	idd = BON_BACKPACK_DIALOG;
	movingEnable = true;
	enableSimulation = true;
	onLoad = "[] execVM 'extern\bon_getbackpack\dialog_update.sqf'";


	class controlsBackground {

		class Mainback : HW_RscPicture {
			idc = 0;
			x = 0.2; y = 0.25;
			w = 0.9; h = 0.6;
			text = "\ca\ui\data\ui_background_video_ca.paa";
		};

		class Title : HW_RscText {
			idc = -1;
			moving = false;
			colorBackground[] = { 0, 0, 0, 0 };
			colorText[] = { 1, 1, 1, 1 };
			x = 0.225; y = 0.31;
			w = 0.3; h = 0.03;
			sizeEx = 0.03;
			text = "get yaself a backpack! fa free!";
		};

		class equiphint : HW_RscText {
			idc = -1;
			moving = false;
			colorBackground[] = { 0, 0, 0, 0 };
			colorText[] = { 0, 0, 0, 1 };
			x = 0.7; y = 0.8125;
			w = 0.2; h = 0.023;
			sizeEx = 0.023;
			text = "click on image to equip";
		};

		class BackpackPicture : HW_RscStructuredText {
			idc = BON_BACKPACK_PICTURE;
			style = ST_MULTI;
			x = 0.11; y = 0.45;
			w = 1.2; h = 1.0;
			colorBackground[] = { 1, 1, 1, 0 };
			colorText[] = { 1, 1, 1, 1 };
			lineSpacing = 1;
			size = 0.125;
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

	};


	class controls {

		class Unitlist: HW_RscGUIListBox {
			idc = BON_BACKPACK_LIST;
			default = 1;
			x = 0.21; y = 0.35;
			w = 0.275; h = 0.4925;
			colorSelect[] = {0, 0, 0, 0.9};
			colorSelect2[] = {0, 0, 0, 0.9};
			colorSelectBackground[] = {1, 1, 1, 0.75};
			colorSelectBackground2[] = {1, 1, 1, 0.75};
			onLBDblClick = "";
			onLBSelChanged = "[] execVM 'extern\bon_getbackpack\dialog_update.sqf'";
			rowHeight = 0.025;
			soundSelect[] = {"\ca\ui\data\sound\mouse2", 0.09, 1};
			maxHistoryDelay = 10;
			canDrag = 0;
			xcolumn1 = "0.1f";
			xcolumn2 = "0.25f";
			xcolumn3 = "0.85f";		
		};

		class EquipButton : HW_RscButton {
			idc = BON_BACKPACK_EQUIPBUTTON;
			x = 0.075; y = 0.4;
			w = 1.0; h = 1.0;
			colorText[] = { 0, 0, 0, 0 };
			colorFocused[] = { 0, 0, 0, 0 };
			colorDisabled[] = { 0, 0, 0, 0 };
			colorBackground[] = { 0, 0, 0, 0 };
			colorBackgroundDisabled[] = { 0, 0, 0, 0 };
			colorBackgroundActive[] = { 0, 0, 0, 0 };
			colorShadow[] = { 0, 0, 0, 0 };
			colorBorder[] = { 0, 0, 0, 0 };
			soundEnter[] = {"\ca\ui\data\sound\mouse2", 0.09, 1};
			soundPush[] = {"\ca\ui\data\sound\new1", 0.09, 1};
			soundClick[] = {"\ca\ui\data\sound\mouse3", 0.07, 1};
			soundEscape[] = {"\ca\ui\data\sound\mouse1", 0.09, 1};
			text = "";
			onButtonClick = "removeBackpack bon_backpack_caller; bon_backpack_caller addBackPack (bon_getbackpack_backpacks select bon_getbackpack_index); closeDialog 0";			
		};
	};
};