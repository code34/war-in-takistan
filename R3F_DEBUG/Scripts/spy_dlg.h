/*******************************************************************************************
 Copyright (C) 2010 Team ~R3F~

 This program is free software under the terms of the GNU General Public License version 3.
 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.

@authors team-r3f.org
@version 0.01
@date 20100909
********************************************************************************************/

class R3FSpyDlg
{
	idd = R3F_DEBUG_ID_SPY_PANEL;
	
	movingEnable = 1;
	controlsBackground[] = {New_Background, New_Background2};
	fadein       =  0;
	fadeout      =  0;
	duration     =  10;
	name = "R3F_SCRIPT_DLG";
	objects[] = {};
	controls[] = 
	{
		Spy_title,
		spy_list,
		Spy_edit_title,
		Spy_edit,
		Btn_Exec,
		Btn_Raz,
		Spy_hint,
		Btn_Close
	};
	
	onLoad="uiNamespace setVariable [""R3F_SPY_DLG"", _this select 0];_test = [""do_init""] execVM ""R3F_DEBUG\Scripts\spy_fncts.sqf""";
	onUnload ="";
	
	class New_BackGround : R3F_DEBUG_RscText
	{
		movingEnable = true;
		idc = R3F_DEBUG_ID_SPY_BKG1;
		x = 0.200;
		y = 0.200;
		w = 0.600;
		h = 0.600;
		colorBackground[] = {0,0,0,0.75};
	};

	class New_BackGround2 : R3F_DEBUG_RscText
	{
		movingEnable = true;
		idc = R3F_DEBUG_ID_SPY_BKG2;
		x = 0.205;
		y = 0.205;
		w = 0.590;
		h = 0.590;
		colorBackground[] = {1,1,1,0.045};
	};

	class Spy_title : R3F_DEBUG_RscText
	{
		idc = R3F_DEBUG_ID_SPY_TITLE;
		x = 0.205;
		y = 0.205;
		w = 0.590;
		h = 0.020;
		text = $STR_R3F_DEBUG_SPY;
	};
	
	class Spy_list :  R3F_DEBUG_List
	{
		idc = R3F_DEBUG_ID_SPY_LIST;
		style = ST_LEFT;
    	x = 0.205;
    	y = 0.230;
    	w = 0.335;
    	h = 0.560;
    	onLBSelChanged = "_test = [""do_select""] execVM ""R3F_DEBUG\Scripts\spy_fncts.sqf"";";
	};

	class Spy_edit_title : R3F_DEBUG_RscText
	{
		idc = R3F_DEBUG_ID_SPY_EDIT_TITLE;
		x = 0.550;
		y = 0.230;
		w = 0.590;
		h = 0.020;
		text = $STR_R3F_DEBUG_TITLE_EDIT;
		colorBackground[] = Color_NoColor;
		color[] = Color_Orange;
		colorText[] = Color_Orange;
	};

	class Spy_edit :  R3F_DEBUG_Edit
	{
		idc = R3F_DEBUG_ID_SPY_EDIT;
		x = 0.550;
		y = 0.260;
		w = 0.240;
		h = 0.040;
		sizeEx = 0.03;	
	};

	class Btn_Exec : R3F_DEBUG_RscBtn
	{
		idc = R3F_DEBUG_ID_SPY_BTNADD;
		text = $STR_R3F_SPY_BTNADD;
		default = true;
		action = "_test = [""do_add""] execVM ""R3F_DEBUG\Scripts\spy_fncts.sqf"";";
		x = 0.555;
		y = 0.290;
	};

	class Btn_Raz : R3F_DEBUG_RscBtn
	{
		idc = R3F_DEBUG_ID_SPY_BTNDEL;
		text = $STR_R3F_SPY_BTNDEL;
		action = "_test = [""do_del""] execVM ""R3F_DEBUG\Scripts\spy_fncts.sqf"";";
		x = 0.555;
		y = 0.340;
	};
	
	
	class Spy_hint : R3F_DEBUG_StructuredText
	{
		idc = R3F_DEBUG_ID_SPY_HINT;
		state = ST_LEFT + ST_MULTI;
		x = 0.550;
		y = 0.430;
		w = 0.240;
		h = 0.300;
		text = $STR_R3F_DEBUG_HINT;
		colorBackground[] = {0.8000,0.7020,0.6000,0.3961};
	};
	

	class Btn_Close : R3F_DEBUG_RscBtn
	{
		idc = R3F_DEBUG_ID_SPY_CLOSE;
		text = $STR_R3F_DEBUG_BTNCLOSE;
		action = "_test = [""do_close""] execVM ""R3F_DEBUG\Scripts\spy_fncts.sqf"";";
		x = 0.555;
		y = 0.720;
	};

};
