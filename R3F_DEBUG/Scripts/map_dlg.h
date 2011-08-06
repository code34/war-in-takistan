/*******************************************************************************************
 Copyright (C) 2010 Team ~R3F~

 This program is free software under the terms of the GNU General Public License version 3.
 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.

@authors team-r3f.org
@version 0.03
@date 20100914
********************************************************************************************/
#include "std_include.h"
#include "r3f_debug_command_panel_includes.h"

class R3F_DEBUG_DLG_ShowMap
{
	idd = R3F_DEBUG_ID_SHOW_MAP;
	
	movingEnable = false;
	controlsBackground[] = {};
	fadein       =  0;
	fadeout      =  0;
	duration     =  10;
	name = "R3F_DEBUG_DLG_ShowMap";
	objects[] = {};
	controls[] = 
	{
		Main_Ctn,
		Main_Title,
		Ctrl_Map,
		Btn_Ok,
		Btn_Close
	};
	
	onLoad="uiNamespace setVariable [""VAR_R3F_DEBUG_DLG_ShowMap"", _this select 0];_void = [0,2] execVM ""R3F_DEBUG\scripts\r3f_map.sqf""";
	onUnload ="[0,2] execVM ""R3F_DEBUG\scripts\r3f_map.sqf"";";
	
	class Main_Ctn : R3F_DEBUG_RscText
	{
		x = "SafezoneX";
		y = "SafezoneY";
		w = "SafezoneW";
		h = "SafezoneH";
		colorBackground[] = {0,0,0,0.75};
	};

	class Main_Title : R3F_DEBUG_RscTitle
	{
		idc = R3F_DEBUG_ID_Title ;
		x = "SafezoneX+0.005";
		y = "SafezoneY+0.020";
		w = "SafezoneW-0.015";
		text = "title";
		colorBackground[] = {CONST_R3F_DEBUG_OPTION_BACKGROUND_COLOR};
	};

	class Ctrl_Map  : R3F_DEBUG_RscMap
    {
    	idc = R3F_DEBUG_ID_Map;
    	x = "SafezoneX+0.240";
    	y = "SafezoneY+0.060";
    	w = "SafezoneW-0.250";
    	h = "SafezoneH-0.015";
    	onMouseButtonClick = "_this execVM ""R3F_DEBUG\scripts\r3f_map.sqf"";";
    };

	class Btn_Ok : R3F_DEBUG_RscBtn
	{
		idc = R3F_DEBUG_ID_MapOk;
		text = "$STR_R3F_DEBUG_BTNOK";
		action = "[0,1] execVM ""R3F_DEBUG\scripts\r3f_map.sqf"";closeDialog 0;";
		x = "safeZoneX+0.015";
		y = "safeZoneY+0.045";
		w = 0.230;
	};

	class Btn_Close : R3F_DEBUG_RscBtn
	{
		text = "$STR_R3F_DEBUG_BTNCANCEL";
		action = "closeDialog 0;";
		
		x = "safeZoneX+0.015";
		y = "safeZoneY+0.090";
		w = 0.230;
	};

};

