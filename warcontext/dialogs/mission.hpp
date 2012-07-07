///////////////////////////////////////////////////////////////////////////
/// Base Classes
///////////////////////////////////////////////////////////////////////////

class RscDisplayMission
{
	idd = 3000;
	movingenable = 0;
	controlsBackground[] = {"RscStructuredText_1101", "RscListbox_1500", "RscMap_1307", "RscStructuredText_1100", "RscButton_1600","RscText_1000", "RscButton_1601"};
	onLoad = "ExecVM ""warcontext\dialogs\WC_fnc_menuchoosemission.sqf""; uiNamespace setVariable [""wcdisplay"", _this select 0]; menuaction = -1;";
		class RscStructuredText_1101: RscStructuredText
		{
			idc = 1101;
			x = 0.181213 * safezoneW + safezoneX;
			y = 0.075 * safezoneH + safezoneY;
			w = 0.636565 * safezoneW;
			h = 0.84775 * safezoneH;
			colorBackground[] = {0,0,0,0.5};
			colorBackgroundActive[] = {0,0,0,0};
		};
		class RscListbox_1500: RscListBox
		{
			idc = 1500;
		
			x = 0.189011 * safezoneW + safezoneX;
			y = 0.155 * safezoneH + safezoneY;
			w = 0.20 * safezoneW;
			h = 0.687 * safezoneH;
		};
		class RscStructuredText_1100:  RscText
		{
			idc = 1100;
		
			x = 0.40 * safezoneW + safezoneX;
			y = 0.105 * safezoneH + safezoneY;
			w = 0.40 * safezoneW;
			h = 0.742 * safezoneH;
			SizeEx = 0.025;
			style = ST_MULTI;
			lineSpacing = 0.7;
			colorText[] = {1, 1, 1, 1};
			colorBackground[] = {0, 0, 0, 0};
		};
		class RscMap_1307 : RscMapControl
		{
			idc = 1307;
			x = 0.45 * safezoneW + safezoneX;
			y = 0.45 * safezoneH + safezoneY;
			w = 0.3 * safezoneW;
			h = 0.4 * safezoneH;
			default = true;
			showCountourInterval = true;
		};
		class RscButton_1600: RscButton
		{
			idc = 1600;
		
			text = "Validate";
			x = 0.663526 * safezoneW + safezoneX;
			y = 0.862 * safezoneH + safezoneY;
			w = 0.141702 * safezoneW;
			h = 0.052 * safezoneH;
			action = "menuaction = 1;";
		};
		class RscText_1000: RscText
		{
			idc = 1000;
		
			text = $STR_WC_MENUCHOOSEMISSION;
			x = 0.190591 * safezoneW + safezoneX;
			y = 0.094 * safezoneH + safezoneY;
			w = 0.2 * safezoneW;
			h = 0.048 * safezoneH;
		};
		class RscButton_1601: RscButton
		{
			idc = 1601;
		
			text = "Recompute";
			x = 0.50 * safezoneW + safezoneX;
			y = 0.862 * safezoneH + safezoneY;
			w = 0.141702 * safezoneW;
			h = 0.052 * safezoneH;
			action = "menuaction = 2;";
		};
};

class RscDisplayrecruitment
{
	idd = 4000;
	movingenable = 0;
	controlsBackground[] = {"control4001", "control4002","control4004","control4005","control4006"};
	onLoad = "ExecVM ""warcontext\dialogs\WC_fnc_menurecruitment.sqf""; uiNamespace setVariable [""wcdisplay"", _this select 0]; menuaction = -1;";
		class control4001: RscStructuredText
		{
			idc = 4001;
			x = 0.2 * safezoneW + safezoneX;
			y = 0.075 * safezoneH + safezoneY;
			w = 0.25 * safezoneW;
			h = 0.84775 * safezoneH;
			colorBackground[] = {0,0,0,0.5};
			colorBackgroundActive[] = {0,0,0,0};
		};
		class control4002: RscListBox
		{
			idc = 4002;
			x = 0.2 * safezoneW + safezoneX;
			y = 0.155 * safezoneH + safezoneY;
			w = 0.25 * safezoneW;
			h = 0.687 * safezoneH;
		};
		class control4004: RscButton
		{
			idc = 4004;
			text = "Recruit";
			x = 0.2 * safezoneW + safezoneX;
			y = 0.862 * safezoneH + safezoneY;
			w = 0.08 * safezoneW;
			h = 0.052 * safezoneH;
			action = "menuaction = 1;";
		};
		class control4005: RscText
		{
			idc = 4005;
			text = $STR_WC_MENURECRUITMENT;
			x = 0.22 * safezoneW + safezoneX;
			y = 0.094 * safezoneH + safezoneY;
			w = 0.22 * safezoneW;
			h = 0.048 * safezoneH;
		};
		class control4006: RscButton
		{
			idc = 4006;
			text = "Close";
			x = 0.32 * safezoneW + safezoneX;
			y = 0.862 * safezoneH + safezoneY;
			w = 0.08 * safezoneW;
			h = 0.052 * safezoneH;
			action = "menuaction = 2;";
		};
};

class RscDisplayclothes
{
	idd = 5000;
	movingenable = 0;
	controlsBackground[] = {"control5001", "control5002","control5004","control5005"};
	onLoad = "ExecVM ""warcontext\dialogs\WC_fnc_menuchangeclothes.sqf""; uiNamespace setVariable [""wcdisplay"", _this select 0]; menuaction = -1;";
		class control5001: RscStructuredText
		{
			idc = 5001;
			x = 0.2 * safezoneW + safezoneX;
			y = 0.075 * safezoneH + safezoneY;
			w = 0.25 * safezoneW;
			h = 0.84775 * safezoneH;
			colorBackground[] = {0,0,0,0.5};
			colorBackgroundActive[] = {0,0,0,0};
		};
		class control5002: RscListBox
		{
			idc = 5002;
			x = 0.2 * safezoneW + safezoneX;
			y = 0.155 * safezoneH + safezoneY;
			w = 0.25 * safezoneW;
			h = 0.687 * safezoneH;
		};
		class control5004: RscButton
		{
			idc = 5004;
			text = "Take this";
			x = 0.22 * safezoneW + safezoneX;
			y = 0.862 * safezoneH + safezoneY;
			w = 0.141702 * safezoneW;
			h = 0.052 * safezoneH;
			action = "menuaction = 1;";
		};
		class control5005: RscText
		{
			idc = 5005;
			text = $STR_WC_MENURECRUITMENT;
			x = 0.22 * safezoneW + safezoneX;
			y = 0.094 * safezoneH + safezoneY;
			w = 0.22 * safezoneW;
			h = 0.048 * safezoneH;
		};
};

class RscDisplayTeam
{
	idd = 6000;
	movingenable = 0;
	controlsBackground[] = {"control6001", "control6002","control6003", "control6004","control6005", "control6006", "control6007", "control6008"};
	onLoad = "ExecVM ""warcontext\dialogs\WC_fnc_menumanagementteam.sqf""; uiNamespace setVariable [""wcdisplay"", _this select 0]; menuaction = -1;";
		class control6001: RscStructuredText
		{
			idc = 6001;
			x = 0.2 * safezoneW + safezoneX;
			y = 0.075 * safezoneH + safezoneY;
			w = 0.25 * safezoneW;
			h = 0.84775 * safezoneH;
			colorBackground[] = {0,0,0,0.5};
			colorBackgroundActive[] = {0,0,0,0};
		};
		class control6002: RscListBox
		{
			idc = 6002;
			x = 0.2 * safezoneW + safezoneX;
			y = 0.155 * safezoneH + safezoneY;
			w = 0.25 * safezoneW;
			h = 0.687 * safezoneH;
		};
		class control6003: RscStructuredText
		{
			idc = 6003;
			x = 0.5 * safezoneW + safezoneX;
			y = 0.075 * safezoneH + safezoneY;
			w = 0.4 * safezoneW;
			h = 0.84775 * safezoneH;
			colorBackground[] = {0,0,0,0.5};
			colorBackgroundActive[] = {0,0,0,0};
			SizeEx = 0.025;
			style = ST_MULTI;
			lineSpacing = 0.7;
		};
		class control6004: RscButton
		{
			idc = 6004;
			text = "Recruit";
			x = 0.3 * safezoneW + safezoneX;
			y = 0.862 * safezoneH + safezoneY;
			w = 0.141702 * safezoneW;
			h = 0.052 * safezoneH;
			action = "menuaction = 1;";
		};
		class control6005: RscText
		{
			idc = 6005;
			text = $STR_WC_MENUTEAMMANAGEMENT;
			x = 0.22 * safezoneW + safezoneX;
			y = 0.094 * safezoneH + safezoneY;
			w = 0.22 * safezoneW;
			h = 0.048 * safezoneH;
		};

		class control6006: RscButton
		{
			idc = 6006;
			text = $STR_ACGUI_MM_BTN_CLOSE;
			x = 0.75 * safezoneW + safezoneX;
			y = 0.862 * safezoneH + safezoneY;
			w = 0.141702 * safezoneW;
			h = 0.052 * safezoneH;
			action = "closedialog 0;";
		};

		class control6007: RscButton
		{
			idc = 6007;
			text = "Fire";
			x = 0.55 * safezoneW + safezoneX;
			y = 0.862 * safezoneH + safezoneY;
			w = 0.141702 * safezoneW;
			h = 0.052 * safezoneH;
			action = "menuaction = 2;";
		};
		class control6008: RscListBox
		{
			idc = 6008;
			x = 0.5 * safezoneW + safezoneX;
			y = 0.27 * safezoneH + safezoneY;
			w = 0.4 * safezoneW;
			h = 0.58 * safezoneH;
		};
};

class RscDisplayvehicles
{
	idd = 7000;
	movingenable = 0;
	controlsBackground[] = {"control7001", "control7002","control7003","control7004","control7005"};

	onLoad = "ExecVM ""warcontext\dialogs\WC_fnc_menubuildvehicles.sqf""; uiNamespace setVariable [""wcdisplay"", _this select 0]; menuaction = -1;";

		class control7001: RscStructuredText
		{
			idc = 7001;
			x = 0.2 * safezoneW + safezoneX;
			y = 0.075 * safezoneH + safezoneY;
			w = 0.25 * safezoneW;
			h = 0.84775 * safezoneH;
			colorBackground[] = {0,0,0,0.5};
			colorBackgroundActive[] = {0,0,0,0};
		};
		class control7002: RscListBox
		{
			idc = 7002;
			x = 0.2 * safezoneW + safezoneX;
			y = 0.155 * safezoneH + safezoneY;
			w = 0.25 * safezoneW;
			h = 0.687 * safezoneH;
		};
		class control7003: RscButton
		{
			idc = 7003;
			text = $STR_WC_BUTTONBUILD;
			x = 0.24 * safezoneW + safezoneX;
			y = 0.862 * safezoneH + safezoneY;
			w = 0.08 * safezoneW;
			h = 0.052 * safezoneH;
			action = "menuaction = 1;";
		};
		class control7004: RscText
		{
			idc = 7004;
			text = $STR_WC_MENUBUILD;
			x = 0.22 * safezoneW + safezoneX;
			y = 0.094 * safezoneH + safezoneY;
			w = 0.22 * safezoneW;
			h = 0.048 * safezoneH;
		};
		class control7005: RscButton
		{
			idc = 7005;
			text = $STR_WC_BUTTONCLOSE;
			x = 0.36 * safezoneW + safezoneX;
			y = 0.862 * safezoneH + safezoneY;
			w = 0.08 * safezoneW;
			h = 0.052 * safezoneH;
			action = "menuaction = 2;";
		};
};

class acInfoDLG
{
	idd = 10000;
	movingEnable = 0;
	enableSimulation = 1;
	enableDisplay = 1;
	fadein       =  0;
	fadeout      =  0;
	duration     =  10;
	name = "ac_info_dlg";
	controlsBackground[] = {New_BackGround};
	objects[] = {};
	controls[] = { MM_MENU1, MM_MENU2, MM_MENU3, MM_MENU4, MM_MENU5, MM_MENU6, MM_BtnTransfert, MM_TAG, infomainmission, infosidemission, MM_BtnOk, MM_BtnOpt, MM_BtnLogs, MM_BtnCredits, MM_Label, MM_PLAYERROLE, MM_BtnObj, MM_BtnTEAMSTATUS, MM_PLAYERLIST, MM_SLIDER_TRANSFER};

	onLoad = "ExecVM ""warcontext\dialogs\WC_fnc_menumissioninfo.sqf""; uiNamespace setVariable [""ac_INFO_DLG"", _this select 0];";
	
	class New_BackGround : RscPicture
	{
		style = 48; 
		x = 0;
		y = 0;
		w = 1.498;
		h = 1.2;
		moving = 0;
		text = "\ca\ui\data\ui_wiz_background_ca.paa";
	};
	
	class MM_TAG : RscPicture
	{
		style = 48; 
		x = 0.41;
		y = 0.12;
		w = 0.69;
		h = 0.73;
		colorText[] = {0.9, 0.9, 0.9, 0.9};
		text = "pics\escapefromhell2.paa";
	};
	
	class infomainmission: RscText
		{
			idc = 10001;
			x = 0.410;
			y = 0.12;
			w = 0.69;
			h = 0.11;
			SizeEx = 0.030;
			style = ST_MULTI;
			lineSpacing = 0.7;
			colorText[] = {1, 1, 1, 1};
			colorBackground[] = {0.3, 0.3, 0.3, 0.3};
		};

	class infosidemission: RscText
		{
			idc = 10006;
			x = 0.410;
			y = 0.24;
			w = 0.69;
			h = 0.11;
			SizeEx = 0.030;
			style = ST_MULTI;
			lineSpacing = 0.7;
			colorText[] = {1, 1, 1, 1};
			colorBackground[] = {0.3, 0.3, 0.3, 0.3};
		};

		
	class MM_Label: RscText
		{
			text = $STR_ACGUI_MM_LABEL;
			x = 0.04;
			y = 0.05;
		};

	class MM_MENU1: RscText
		{
			idc = 10005;
			x = 0.04;
			y = 0.12;
			SizeEx = 0.030;
		};

	class MM_MENU2: RscText
		{
			idc = 10007;
			x = 0.04;
			y = 0.16;
			SizeEx = 0.030;
		};

	class MM_MENU3: RscText
		{
			idc = 10011;
			x = 0.04;
			y = 0.20;
			SizeEx = 0.030;
		};

	class MM_MENU4: RscText
		{
			idc = 10013;
			x = 0.04;
			y = 0.24;
			SizeEx = 0.030;
		};

	class MM_MENU5: RscText
		{
			idc = 10012;
			x = 0.04;
			y = 0.28;
			SizeEx = 0.030;
		};

	class MM_MENU6: RscText
		{
			idc = 10016;
			x = 0.04;
			y = 0.36;
			SizeEx = 0.030;
		};

	class MM_SLIDER_TRANSFER : RscXSliderH {
		idc = 10015;
		x = 0.04;
		y = 0.40;
		w = 0.30;
	};

	class MM_PLAYERLIST: RscCombo {
		idc = 10014;
		x = 0.04;
		y = 0.44;
		w = 0.30;
		SizeEx = 0.030;
	};

	class MM_BtnTransfert : New_Btn 
	{
			x = 0.04;
			y = 0.45;
			w = 0.22;
			text = $STR_ACGUI_MM_BTN_TRANSFERT;
			action = "[] call WC_fnc_transfert;";
	};


	class MM_BtnObj : New_Btn 
		{
			x = 0.04;
			y = 0.54;
			w = 0.2200;
			text = $STR_ACGUI_MM_BTN_Obj;
			action = "CloseDialog 0; wcanim = [(wcobjective select 1), 6] spawn WC_fnc_camfocus;";
		};

	class MM_BtnOpt : New_Btn 
		{
			x = 0.04;
			y = 0.59;
			w = 0.2200;
			text = $STR_ACGUI_MM_BTN_Opt;
			action = "CloseDialog 0; _handle = [] execVM ""warcontext\dialogs\WC_fnc_createmenusettings.sqf""";
		};

	class MM_BtnTEAMSTATUS  : New_Btn {
			idc = 10002;
			x = 0.04;
			y = 0.64;
			w = 0.2200;
			text = $STR_ACGUI_MM_BTN_TEAMSTATUS;
			action = "CloseDialog 0; [] call WC_fnc_teamstatus;";
	};

	class MM_BtnLogs  : New_Btn 
		{
			idc = 10003;
			x = 0.04;
			y = 0.69;
			w = 0.2200;
			text = $STR_ACGUI_MM_BTN_Logs;
			action = "CloseDialog 0; wcanim = [] execVM ""warcontext\dialogs\WC_fnc_createmenureadlogs.sqf"";";
	};

	class MM_BtnCredits  : New_Btn 
		{
			idc = 10002;
			x = 0.04;
			y = 0.74;
			w = 0.2200;
			text = $STR_ACGUI_MM_BTN_CREDITS;
			action = "CloseDialog 0; wcanim = [] execVM ""warcontext\camera\WC_fnc_credits.sqf"";";
	};

	class MM_BtnOk  : New_Btn 
		{
			x = 0.89;
			y = 0.892;
			w = 0.20;
			default = true;
			text = $STR_ACGUI_MM_BTN_CLOSE;
			action = "closeDialog 0;";
		};

	class MM_PLAYERROLE: RscText
		{
			idc = 10009;
			x = 0.410;
			y = 0.36;
			w = 0.69;
			h = 0.15;
			SizeEx = 0.030;
			style = ST_MULTI;
			lineSpacing = 0.7;
			colorText[] = {1, 1, 1, 1};
			colorBackground[] = {0.3, 0.3, 0.3, 0.3};
		};		
};

class SettingsDialog {
	idd = 13000;
	movingEnable = 0;
	enableSimulation = 1;
	enableDisplay = 1;
	objects[] = {};
	controlsBackground[] = {New_BackGround};
	controls[] = {VM_VD_TXT, VM_VD_SDR, VM_TG_TXT, VM_TG_SDR, VM_BtnClose, VM_GAMESETTINGS, VM_TG_VAL, VM_LABEL, VM_WELMSG, MM_BtnWeapons, MM_BtnHBfix};
	onLoad = "ExecVM ""warcontext\dialogs\WC_fnc_menusettings.sqf""";
	
	class New_BackGround : RscPicture
	{
		style = 48; 
		x = 0;
		y = 0;
		w = 1.498;
		h = 1.2;
		text = "\ca\ui\data\ui_wiz_background_ca.paa";
	};
		
		class VM_VD_TXT: RscText 
		{
			idc = 13001;
			text = "";
			x = 0.04;
			y = 0.25;
			sizeEx = 0.03;
		};
		
		class VM_VD_SDR : RscXSliderH 
		{
			idc = 13002;
			x = 0.04;
			y = 0.29;
			w = 0.28;
		};
		
		class VM_TG_TXT: RscText 
		{
			idc = 13003;
			text = "";
			x = 0.04;
			y = 0.33;
			sizeEx = 0.03;
		};
	
		
		class VM_TG_SDR : RscXSliderH 
		{
			idc = 13004;
			x = 0.04;
			y = 0.37;
			w = 0.28;
		};

		class MM_BtnWeapons  : New_Btn {
				idc = 13005;
				x = 0.04;
				y = 0.41;
				w = 0.2200;
				text = $STR_ACGUI_MM_BTN_WEAPONS;
				action = "[] call WC_fnc_exportweaponsplayer;";
		};

		class MM_BtnHBfix  : New_Btn 
		{
			idc = 10002;
			x = 0.04;
			y = 0.46;
			w = 0.2200;
			text = $STR_ACGUI_MM_BTN_HBFIX;
			action = "[] call WC_fnc_fixheadbug;";
		};
	
		class VM_BtnClose  : New_Btn 
		{
			x = 0.87;
			y = 0.892;
			w = 0.22;
			default = true;
			text = $STR_ACGUI_VM_BTN_CLOSE;
			action = "MenuAction = 2";
		};

		//class VM_GAMESETTINGS: RscText
		//{
		//	idc = 13007;
		//	x = 0.410;
		//	y = 0.120;
		//	w = 0.69;
		//	h = 0.73;
		//	SizeEx = 0.030;
		//	style = ST_MULTI;
		//	lineSpacing = 0.7;
		//	colorText[] = {1, 1, 1, 1};
		//	colorBackground[] = {0.3, 0.3, 0.3, 0.3};
		//};

		class VM_GAMESETTINGS: RscListBox
		{
			idc = 13007;
			x = 0.410;
			y = 0.120;
			w = 0.69;
			h = 0.73;
		};
		
		class VM_TG_VAL: RscText 
		{
			idc = 13008;
			text = "%";
			x = 0.25;
			y = 0.33;
			sizeEx = 0.03;
		};
		
		class VM_LABEL: RscText
		{
			text = $STR_ACGUI_MM_LABEL;
			x = 0.04;
			y = 0.05;
		};
		
		class VM_WELMSG: RscText
		{
			idc = 13009;
			x = 0.04;
			y = 0.12;
			SizeEx = 0.030;
		};
};


class RscDisplayPaperboard
{
	idd = 14000;
	movingenable = 0;
	onLoad = "ctrlSetFocus MyButtonOK;";

	class Controls
	{
		class MyBackground: RscText
		{
			idc = 14001;
			x = 0.3125 * safezoneW + safezoneX;
			y = 0.35 * safezoneH + safezoneY;
			w = 0.375 * safezoneW;
			h = 0.38 * safezoneH;
			colorBackground[] = {0,0,0,0.5};
		};
		class MyHeader: RscText
		{
			style = ST_CENTER;
		
			idc = 14002;
			text = "Paperboard";
			x = 0.3125 * safezoneW + safezoneX;
			y = 0.35 * safezoneH + safezoneY;
			w = 0.375 * safezoneW;
			h = 0.05 * safezoneH;
			colorBackground[] = {0,0,0,0.5};
		};
		class MyEditbox: RscEdit
		{
			idc = 14003;
		
			x = 0.328125 * safezoneW + safezoneX;
			y = 0.425 * safezoneH + safezoneY;
			w = 0.34375 * safezoneW;
			h = 0.15 * safezoneH;
		};
		class MyButtonOK: RscShortcutButton
		{
			onButtonClick = "if(count wcmotd > 5 ) then { wcmotd = wcmotd - [wcmotd select 0]; }; wcmotd = wcmotd + [ctrltext ((ctrlParent (_this select 0)) displayCtrl 14003)]; publicvariable 'wcmotd'; closedialog 0;";
			idc = 14004;
			text = "Write Paperboard";
			x = 0.53125 * safezoneW + safezoneX;
			y = 0.575 * safezoneH + safezoneY;
			w = 0.140625 * safezoneW;
			h = 0.1 * safezoneH;
		};
		class MyButtonBack: RscShortcutButton
		{
			onButtonClick = "wcmotd = []; publicvariable 'wcmotd'; closedialog 0;";
		
			idc = 14005;
			text = "Clear Paperboard";
			x = 0.328125 * safezoneW + safezoneX;
			y = 0.575 * safezoneH + safezoneY;
			w = 0.140625 * safezoneW;
			h = 0.1 * safezoneH;
		};
	};
};

class RscDisplayLogs {
	idd = 15000;
	movingEnable = 0;
	enableSimulation = 1;
	enableDisplay = 1;
	objects[] = {};
	controlsBackground[] = {Logbackground};
	controls[] = {Logbackground, LogLabel, Logtext, LogClose};
	onLoad = "  ExecVM ""warcontext\dialogs\WC_fnc_menureadlogs.sqf""; ";

	class LogLabel: RscText
	{
		idc = 15001;
		text = $STR_ACGUI_MM_LABEL;
		x = 0.04;
		y = 0.05;
	};
	
	class Logbackground : RscPicture
	{
		idc = 15002;
		style = 48; 
		x = 0;
		y = 0;
		w = 1.498;
		h = 1.2;
		text = "\ca\ui\data\ui_wiz_background_ca.paa";
	};

	class Logtext: RscListBox
	{
		idc = 15003;
		x = 0.410;
		y = 0.120;
		w = 0.69;
		h = 0.73;
	};

	class LogClose  : New_Btn 
	{
		idc = 15004;
		x = 0.87;
		y = 0.892;
		w = 0.22;
		default = true;
		text = $STR_ACGUI_MM_BTN_CLOSE;
		action = "closedialog 0;";
	};
};
