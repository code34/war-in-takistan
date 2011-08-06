/*******************************************************************************************
 Copyright (C) 2010 Team ~R3F~

 This program is free software under the terms of the GNU General Public License version 3.
 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.

@authors team-r3f.org
@version 0.01
@date 20100906
********************************************************************************************/

class R3FScriptDlg
{
	idd = R3F_DEBUG_ID_SCRIPT_PANEL;
	
	movingEnable = 1;
	controlsBackground[] = {New_Background, New_Background2};
	fadein       =  0;
	fadeout      =  0;
	duration     =  10;
	name = "R3F_SCRIPT_DLG";
	objects[] = {};
	controls[] = 
	{
		Dlg_title,
		Ed_Script,
		Btn_Exec,
		Btn_Terminate,
		Btn_Raz,
		Btn_Close
	};
	
	onLoad="uiNamespace setVariable [""R3F_SCRIPT_DLG"", _this select 0];_test = [""do_init""] execVM ""R3F_DEBUG\Scripts\script_fncts.sqf""";
	onUnload ="_test = [""do_close""] execVM ""R3F_DEBUG\Scripts\script_fncts.sqf""";
	
	class New_BackGround : R3F_DEBUG_RscText
	{
		movingEnable = true;
		idc = R3F_DEBUG_ID_SCRIPT_BKG1;
		x = 0.000;
		y = 0.500;
		w = 1.100;
		h = 0.500;
		colorBackground[] = {0,0,0,0.75};
		moving = true;
	};

	class New_BackGround2 : R3F_DEBUG_RscText
	{
		movingEnable = true;
		idc = R3F_DEBUG_ID_SCRIPT_BKG2;
		x = 0.005;
		y = 0.505;
		w = 1.090;
		h = 0.490;
		colorBackground[] = {1,1,1,0.045};
	};

	class Dlg_title : R3F_DEBUG_RscText
	{
		idc = R3F_DEBUG_ID_SCRIPT_TITLE;
		x = 0.010;
		y = 0.510;
		w = 1.080;
		h = 0.030;
		text = $STR_R3F_DEBUG_SCRIPT_TITLE;
	};
	
	class Ed_Script :  R3F_DEBUG_Editor
	{
		idc = R3F_DEBUG_ID_SCRIPT_EDITOR;		
		x = 0.010;
		y = 0.550;
		w = 1.080;
		h = 0.380;
		sizeEx = 0.03;
		lineSpacing = 1;
	};

	class Btn_Exec : R3F_DEBUG_RscBtn
	{
		idc = R3F_DEBUG_ID_SCRIPT_EXEC;
		text = $STR_R3F_DEBUG_BTNEXEC;
		default = true;
		action = "_test = [""do_exec""] execVM ""R3F_DEBUG\Scripts\script_fncts.sqf"";";
		x = 0.060;
		y = 0.920;
		w = 0.230;
	};

	class Btn_Terminate : R3F_DEBUG_RscBtn
	{
		idc = R3F_DEBUG_ID_SCRIPT_TERMINATE;
		text = $STR_R3F_DEBUG_BTNTERMINATE;
		action = "_test = [""do_terminate""] execVM ""R3F_DEBUG\Scripts\script_fncts.sqf"";";
		x = 0.310;
		y = 0.920;
		w = 0.230;
	};

	class Btn_Raz : R3F_DEBUG_RscBtn
	{
		idc = R3F_DEBUG_ID_SCRIPT_RAZ;
		text = $STR_R3F_DEBUG_BTNRAZ;
		action = "_test = [""do_raz""] execVM ""R3F_DEBUG\Scripts\script_fncts.sqf"";";
		x = 0.560;
		y = 0.920;
		w = 0.230;
	};

	class Btn_Close : R3F_DEBUG_RscBtn
	{
		idc = R3F_DEBUG_ID_SCRIPT_CLOSE;
		text = $STR_R3F_DEBUG_BTNCLOSE;
		action = "_test = [""do_close""] execVM ""R3F_DEBUG\Scripts\script_fncts.sqf"";";
		x = 0.800;
		y = 0.920;
		w = 0.230;
	};

};
