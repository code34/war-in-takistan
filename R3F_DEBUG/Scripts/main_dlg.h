/*******************************************************************************************
 Copyright (C) 2010 Team ~R3F~

 This program is free software under the terms of the GNU General Public License version 3.
 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.

@authors team-r3f.org
@version 0.01
@date 20100913
********************************************************************************************/

#include "std_include.h"
#include "r3f_debug_command_panel_includes.h"

#define CONST_R3F_DEBUG_FRAME_X 			0
#define CONST_R3F_DEBUG_FRAME_Y				0


#define CONST_FRAME_BORDER_MARGIN			0.010

#define CONST_R3F_DEBUG_FRAME_LEFT			(0.230 + CONST_FRAME_BORDER_MARGIN)

#define MACRO_R3f_DEBUG_POSITION_LEFT_RIGHT(PosLeft, PosRight) 	\
	x = (CONST_R3F_DEBUG_FRAME_X + PosLeft); 					\
	w = (PosRight - PosLeft);									\

#define MACRO_R3f_DEBUG_POSITION_TOP(PosTop)  (CONST_R3F_DEBUG_FRAME_Y + PosTop)


#define CONST_R3F_DEBUG_OPTIONS_Y			0.125
#define CONST_R3F_DEBUG_OPTION_DELTA_Y 		0.030

#define CONST_R3F_DEBUG_OPTION_0_Y 			MACRO_R3f_DEBUG_POSITION_TOP( CONST_R3F_DEBUG_OPTIONS_Y )
#define CONST_R3F_DEBUG_OPTION_1_Y			(CONST_R3F_DEBUG_OPTION_0_Y + CONST_R3F_DEBUG_OPTION_DELTA_Y * 1)
#define CONST_R3F_DEBUG_OPTION_2_Y			(CONST_R3F_DEBUG_OPTION_0_Y + CONST_R3F_DEBUG_OPTION_DELTA_Y * 2)
#define CONST_R3F_DEBUG_OPTION_3_Y			(CONST_R3F_DEBUG_OPTION_0_Y + CONST_R3F_DEBUG_OPTION_DELTA_Y * 3)
#define CONST_R3F_DEBUG_OPTION_4_Y			(CONST_R3F_DEBUG_OPTION_0_Y + CONST_R3F_DEBUG_OPTION_DELTA_Y * 4)
#define CONST_R3F_DEBUG_OPTION_5_Y			(CONST_R3F_DEBUG_OPTION_0_Y + CONST_R3F_DEBUG_OPTION_DELTA_Y * 5)
#define CONST_R3F_DEBUG_OPTION_6_Y			(CONST_R3F_DEBUG_OPTION_0_Y + CONST_R3F_DEBUG_OPTION_DELTA_Y * 6)
#define CONST_R3F_DEBUG_OPTION_7_Y			(CONST_R3F_DEBUG_OPTION_0_Y + CONST_R3F_DEBUG_OPTION_DELTA_Y * 7)
#define CONST_R3F_DEBUG_OPTION_8_Y			(CONST_R3F_DEBUG_OPTION_0_Y + CONST_R3F_DEBUG_OPTION_DELTA_Y * 8)
#define CONST_R3F_DEBUG_OPTION_9_Y			(CONST_R3F_DEBUG_OPTION_0_Y + CONST_R3F_DEBUG_OPTION_DELTA_Y * 9)
#define CONST_R3F_DEBUG_OPTION_10_Y			(CONST_R3F_DEBUG_OPTION_0_Y + CONST_R3F_DEBUG_OPTION_DELTA_Y * 10)
#define CONST_R3F_DEBUG_OPTION_11_Y			(CONST_R3F_DEBUG_OPTION_0_Y + CONST_R3F_DEBUG_OPTION_DELTA_Y * 11)
#define CONST_R3F_DEBUG_OPTION_12_Y			(CONST_R3F_DEBUG_OPTION_0_Y + CONST_R3F_DEBUG_OPTION_DELTA_Y * 12)
#define CONST_R3F_DEBUG_OPTION_13_Y			(CONST_R3F_DEBUG_OPTION_0_Y + CONST_R3F_DEBUG_OPTION_DELTA_Y * 13)
#define CONST_R3F_DEBUG_OPTION_14_Y			(CONST_R3F_DEBUG_OPTION_0_Y + CONST_R3F_DEBUG_OPTION_DELTA_Y * 14)
#define CONST_R3F_DEBUG_OPTION_15_Y			(CONST_R3F_DEBUG_OPTION_0_Y + CONST_R3F_DEBUG_OPTION_DELTA_Y * 15)

#define CONST_R3f_DEBUG_FRAME_HEIGHT 		(CONST_R3F_DEBUG_OPTIONS_Y + CONST_R3F_DEBUG_OPTION_DELTA_Y * CONST_R3F_DEBUG_OPTION_COUNT + CONST_FRAME_BORDER_MARGIN)

class R3F_DEBUG_DLG_commandpanel_main
{	
    idd = R3F_DEBUG_ID_main_panel;	
    movingEnable = false;
    duration = 1000000000;
    fadein = 0;
    name = "R3F_DEBUG_DLG_commandpanel_main"; 
	onLoad = "uiNamespace setVariable [""VAR_R3F_DEBUG_main_dialog"", _this select 0];";
    
	controls[] = 
	{ 
		R3F_DEBUG_dlg_frame, 
		R3F_DEBUG_dlg_title,
		R3F_DEBUG_dlg_version,
		R3F_DEBUG_dlg_title_icon,
		
		R3F_DEBUG_option_0,
		R3F_DEBUG_option_1,
		R3F_DEBUG_option_2,
		R3F_DEBUG_option_3,
		R3F_DEBUG_option_4,
		R3F_DEBUG_option_5,
		R3F_DEBUG_option_6,
		R3F_DEBUG_option_7,
		R3F_DEBUG_option_8,
		R3F_DEBUG_option_9,
		R3F_DEBUG_option_10,
		R3F_DEBUG_option_11,
		R3F_DEBUG_option_12,
		R3F_DEBUG_option_13,
		R3F_DEBUG_option_14,
		
		R3F_DEBUG_option_value_0,
		R3F_DEBUG_option_value_1,
		R3F_DEBUG_option_value_2,
		R3F_DEBUG_option_value_3,
		R3F_DEBUG_option_value_4,
		R3F_DEBUG_option_value_5,
		R3F_DEBUG_option_value_6,
		R3F_DEBUG_option_value_7,
		R3F_DEBUG_option_value_8,
		R3F_DEBUG_option_value_9,
		R3F_DEBUG_option_value_10,
		R3F_DEBUG_option_value_11,
		R3F_DEBUG_option_value_12,
		R3F_DEBUG_option_value_13,
		R3F_DEBUG_option_value_14,
		
		R3F_DEBUG_Watcher,
		R3F_DEBUG_Watcher_Title,
		R3F_DEBUG_Watcher_List
	};
	
	class R3F_DEBUG_dlg_text_base
	{
		idc = -1;
		type = CT_STATIC;
		style = ST_CENTER;
		colorText[] = { CONST_R3F_DEBUG_OPTION_TEXT_COLOR };
		colorBackground[] = { CONST_R3F_DEBUG_OPTION_BACKGROUND_COLOR };
		font = "BitStream";
		sizeEx = 0.023;
		h = 0.023;
		text = "";
	};
	
	class R3F_DEBUG_dlg_image_base
	{
		idc = -1;
		type = CT_STATIC;
		style = ST_PICTURE;
		colorText[] = { 1.0, 1.0, 1.0, 1.0 };
		colorBackground[] = { 0.0, 0.0, 0.0, 0.0 };
		font = "BitStream";
		sizeEx = 0.028;
		h = 0.028;
		text = "";
	};

	class R3F_DEBUG_dlg_frame
	{
		type = CT_STATIC;
		idc = R3F_DEBUG_ID_frame;
		style = 0;
	
		colorText[] = { 0.15, 0.16, 0.12, 1 };
		colorBackground[] = { 0.40, 0.43, 0.28, 0.25 };
		
		MACRO_R3f_DEBUG_POSITION_LEFT_RIGHT(0.0, CONST_R3F_DEBUG_FRAME_LEFT)
		y = MACRO_R3f_DEBUG_POSITION_TOP(0.0);
		h = CONST_R3f_DEBUG_FRAME_HEIGHT;
		
		font = "Zeppelin32";
		sizeEx = 0.028;
		text = "";
	};
	
	class R3F_DEBUG_dlg_title_icon : R3F_DEBUG_dlg_image_base
	{
		idc = R3F_DEBUG_ID_icon;
		MACRO_R3f_DEBUG_POSITION_LEFT_RIGHT(0, 0.140)
		y = MACRO_R3f_DEBUG_POSITION_TOP(-0.010);
		h = 0.160;
		text = "R3F_DEBUG\Images\r3f_debug_alpha_256.paa";
	};
	
	class R3F_DEBUG_dlg_title : R3F_DEBUG_dlg_text_base
	{
		name = "R3F_DEBUG_dlg_title";
		idc = R3F_DEBUG_ID_title;
		style = ST_RIGHT;
		
		font = "Zeppelin32";
		
		MACRO_R3f_DEBUG_POSITION_LEFT_RIGHT(0.0, CONST_R3F_DEBUG_FRAME_LEFT)
		y = MACRO_R3f_DEBUG_POSITION_TOP(0.0);
		h = 0.05;
		sizeEx = 0.028;
		text = "ALT+F [DEBUG]";
	};
	
	class R3F_DEBUG_dlg_version : R3F_DEBUG_dlg_text_base
	{
		idc = R3F_DEBUG_ID_VERSION;
		style = ST_RIGHT;	
		MACRO_R3f_DEBUG_POSITION_LEFT_RIGHT(0.0, CONST_R3F_DEBUG_FRAME_LEFT)
		y = MACRO_R3f_DEBUG_POSITION_TOP(0.055);
		h = 0.05;
		sizeEx = 0.020;
		colorBackground[] = Color_NoColor;
		text = $STR_R3F_VERSION;
	};
	
	class R3F_DEBUG_option_base : R3F_DEBUG_dlg_text_base
	{
		font = "LucidaConsoleB";
		style = ST_LEFT;
		MACRO_R3f_DEBUG_POSITION_LEFT_RIGHT(0.005, 0.160)
	};
	
	class R3F_DEBUG_option_value_base : R3F_DEBUG_dlg_text_base
	{
		type = CT_STATIC;
		style = ST_CENTER;
		MACRO_R3f_DEBUG_POSITION_LEFT_RIGHT(0.165, 0.230)
	};
	
	class R3F_DEBUG_option_0 : R3F_DEBUG_option_base
	{
		idc = R3F_DEBUG_ID_option_0;
		y = CONST_R3F_DEBUG_OPTION_0_Y;
		text = "Option 0";
	};
	
	class R3F_DEBUG_option_1 : R3F_DEBUG_option_base
	{
		idc = R3F_DEBUG_ID_option_1;
		y = CONST_R3F_DEBUG_OPTION_1_Y;
		text = "Option 1";
	};
	
	class R3F_DEBUG_option_2 : R3F_DEBUG_option_base
	{
		idc = R3F_DEBUG_ID_option_2;
		y = CONST_R3F_DEBUG_OPTION_2_Y;
		text = "Option 2";
	};
	
	class R3F_DEBUG_option_3 : R3F_DEBUG_option_base
	{
		idc = R3F_DEBUG_ID_option_3;
		y = CONST_R3F_DEBUG_OPTION_3_Y;
		text = "Option 3";
	};
	
	class R3F_DEBUG_option_4 : R3F_DEBUG_option_base
	{
		idc = R3F_DEBUG_ID_option_4;
		y = CONST_R3F_DEBUG_OPTION_4_Y;
		text = "Option 4";
	};
	
	class R3F_DEBUG_option_5 : R3F_DEBUG_option_base
	{
		idc = R3F_DEBUG_ID_option_5;
		y = CONST_R3F_DEBUG_OPTION_5_Y;
		text = "Option 5";
	};
	
	class R3F_DEBUG_option_6 : R3F_DEBUG_option_base
	{
		idc = R3F_DEBUG_ID_option_6;
		y = CONST_R3F_DEBUG_OPTION_6_Y;
		text = "Option 6";
	};
	
	class R3F_DEBUG_option_7 : R3F_DEBUG_option_base
	{
		idc = R3F_DEBUG_ID_option_7;
		y = CONST_R3F_DEBUG_OPTION_7_Y;
		text = "Option 7";
	};
	
	class R3F_DEBUG_option_8 : R3F_DEBUG_option_base
	{
		idc = R3F_DEBUG_ID_option_8;
		y = CONST_R3F_DEBUG_OPTION_8_Y;
		text = "Option 8";
	};
	
	class R3F_DEBUG_option_9 : R3F_DEBUG_option_base
	{
		idc = R3F_DEBUG_ID_option_9;
		y = CONST_R3F_DEBUG_OPTION_9_Y;
		text = "Option 9";
	};

	class R3F_DEBUG_option_10 :  R3F_DEBUG_option_base
	{
		idc = R3F_DEBUG_ID_option_10;
		y = CONST_R3F_DEBUG_OPTION_10_Y;
		text = "Option 10";
	};

	class R3F_DEBUG_option_11 :  R3F_DEBUG_option_base
	{
		idc = R3F_DEBUG_ID_option_11;
		y = CONST_R3F_DEBUG_OPTION_11_Y;
		text = "Option 11";
	};

	class R3F_DEBUG_option_12 :  R3F_DEBUG_option_base
	{
		idc = R3F_DEBUG_ID_option_12;
		y = CONST_R3F_DEBUG_OPTION_12_Y;
		text = "Option 12";
	};

	class R3F_DEBUG_option_13 :  R3F_DEBUG_option_base
	{
		idc = R3F_DEBUG_ID_option_13;
		y = CONST_R3F_DEBUG_OPTION_13_Y;
		text = "Option 13";
	};

	class R3F_DEBUG_option_14 :  R3F_DEBUG_option_base
	{
		idc = R3F_DEBUG_ID_option_14;
		y = CONST_R3F_DEBUG_OPTION_14_Y;
		text = "Option 14";
	};

	class R3F_DEBUG_option_15 :  R3F_DEBUG_option_base
	{
		idc = R3F_DEBUG_ID_option_15;
		y = CONST_R3F_DEBUG_OPTION_15_Y;
		text = "Option 15";
	};


	class R3F_DEBUG_option_value_0 : R3F_DEBUG_option_value_base
	{
		idc = R3F_DEBUG_ID_option_value_0;
		y = CONST_R3F_DEBUG_OPTION_0_Y;
		text = "Value 0";
	};
	
	class R3F_DEBUG_option_value_1 : R3F_DEBUG_option_value_base
	{
		idc = R3F_DEBUG_ID_option_value_1;
		y = CONST_R3F_DEBUG_OPTION_1_Y;
		text = "Value 1";
	};
	
	class R3F_DEBUG_option_value_2 : R3F_DEBUG_option_value_base
	{
		idc = R3F_DEBUG_ID_option_value_2;
		y = CONST_R3F_DEBUG_OPTION_2_Y;
		text = "Value 2";
	};

	class R3F_DEBUG_option_value_3 : R3F_DEBUG_option_value_base
	{
		idc = R3F_DEBUG_ID_option_value_3;
		y = CONST_R3F_DEBUG_OPTION_3_Y;
		text = "Value 3";
	};
	
	class R3F_DEBUG_option_value_4 : R3F_DEBUG_option_value_base
	{
		idc = R3F_DEBUG_ID_option_value_4;
		y = CONST_R3F_DEBUG_OPTION_4_Y;
		text = "Value 4";
	};
	
	class R3F_DEBUG_option_value_5 : R3F_DEBUG_option_value_base
	{
		idc = R3F_DEBUG_ID_option_value_5;
		y = CONST_R3F_DEBUG_OPTION_5_Y;
		text = "Value 5";
	};
	
	class R3F_DEBUG_option_value_6 : R3F_DEBUG_option_value_base
	{
		idc = R3F_DEBUG_ID_option_value_6;
		y = CONST_R3F_DEBUG_OPTION_6_Y;
		text = "Value 6";
	};
	
	class R3F_DEBUG_option_value_7 : R3F_DEBUG_option_value_base
	{
		idc = R3F_DEBUG_ID_option_value_7;
		y = CONST_R3F_DEBUG_OPTION_7_Y;
		text = "Value 7";
	};
	
	class R3F_DEBUG_option_value_8 : R3F_DEBUG_option_value_base
	{
		idc = R3F_DEBUG_ID_option_value_8;
		y = CONST_R3F_DEBUG_OPTION_8_Y;
		text = "Value 8";
	};
	
	class R3F_DEBUG_option_value_9 : R3F_DEBUG_option_value_base
	{
		idc = R3F_DEBUG_ID_option_value_9;
		y = CONST_R3F_DEBUG_OPTION_9_Y;
		text = "Value 9";
	};
	
	class R3F_DEBUG_option_value_10 : R3F_DEBUG_option_value_base
	{
		idc = R3F_DEBUG_ID_option_value_10;
		y = CONST_R3F_DEBUG_OPTION_10_Y;
		text = "Value 10";
	};

	class R3F_DEBUG_option_value_11 : R3F_DEBUG_option_value_base
	{
		idc = R3F_DEBUG_ID_option_value_11;
		y = CONST_R3F_DEBUG_OPTION_11_Y;
		text = "Value 11";
	};

	class R3F_DEBUG_option_value_12 : R3F_DEBUG_option_value_base
	{
		idc = R3F_DEBUG_ID_option_value_12;
		y = CONST_R3F_DEBUG_OPTION_12_Y;
		text = "Value 12";
	};

	class R3F_DEBUG_option_value_13 : R3F_DEBUG_option_value_base
	{
		idc = R3F_DEBUG_ID_option_value_13;
		y = CONST_R3F_DEBUG_OPTION_13_Y;
		text = "Value 13";
	};

	class R3F_DEBUG_option_value_14 : R3F_DEBUG_option_value_base
	{
		idc = R3F_DEBUG_ID_option_value_14;
		y = CONST_R3F_DEBUG_OPTION_14_Y;
		text = "Value 14";
	};

	class R3F_DEBUG_option_value_15 : R3F_DEBUG_option_value_base
	{
		idc = R3F_DEBUG_ID_option_value_15;
		y = CONST_R3F_DEBUG_OPTION_15_Y;
		text = "Value 15";
	};


	class R3F_DEBUG_Watcher : R3F_DEBUG_RscText
	{
		idc = R3F_DEBUG_ID_Watcher_Bkg;
		x = (safeZoneW + safeZoneX) - 0.400;
		y = safeZoneY;
		w = 0.400;
		h = safeZoneH;
		colorBackground[] = {0.5, 0.5, 0.5, 0.75};
	};

	class R3F_DEBUG_Watcher_Title : R3F_DEBUG_dlg_text_base
	{
		idc = R3F_DEBUG_ID_Watcher_Title;
		x = (safeZoneW + safeZoneX) - 0.400;
		y = safeZoneY ;
		w = 0.400;
		text = $STR_R3F_DEBUG_SPY2;
	};

	class R3F_DEBUG_Watcher_List  : R3F_DEBUG_List
    {
    	style = ST_LEFT + LB_MULTI;
    	idc = R3F_DEBUG_ID_Watcher_List;
    	x = (safeZoneW + safeZoneX) - 0.400;
    	y = safeZoneY + 0.025;
    	w = 0.400;
    	h = safeZoneH - 0.010;
    	onLBSelChanged = "";
    };
};
