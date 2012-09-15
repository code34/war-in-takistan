/*******************************************************************************************
 Copyright (C) 2010 Team ~R3F~

 This program is free software under the terms of the GNU General Public License version 3.
 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
@authors team-r3f.org
@version 0.07
@date 20100913
********************************************************************************************/


#include "dik_codes.h"
#include "r3f_debug_command_panel_includes.h"
#include "constants_R3F_DEBUG.sqf";

VAR_R3F_DEBUG_ForwardKeys = actionKeys "moveForward";

VAR_R3F_DEBUG_Vehicle 					= objNull;
VAR_R3F_DEBUG_EventDamage 				= -1;
VAR_R3F_DEBUG_EH_InfAmmo 				= -1;
VAR_R3F_DEBUG_ARR_LOG 					= [];
VAR_R3F_EXECUTED_SCRIPT					= [];
VAR_R3F_VelocityRunning					= false;
VAR_R3F_DEBUG_UpdateDisplayColorizeValueChangedHandle 	= 0 spawn {};
VAR_R3F_DEBUG_OptionIndex				= 0;
VAR_R3F_DEBUG_ShowDlg					= true;
VAR_R3F_DEBUG_ShowDlgWatcher				= true;
VAR_R3F_DEBUG_MapMode					= CONST_R3F_DEBUG_MAP4TELEPORT;
VAR_R3F_DEBUG_MapMarker					= nil;
VAR_R3F_DEBUG_MapMarkerPos				= [0,0,0];
VAR_R3F_DEBUG_InCamera					= false;
VAR_R3F_DEBUG_ShowIA					= false;
VAR_R3F_DEBUG_Skill 					= CONST_R3F_DEBUG_SKILL_NORMAL;
VAR_R3F_DEBUG_GodSightState				= 0;
VAR_R3F_DEBUG_Neutrality				= CONST_R3F_DEBUG_NEUTRALITY_OFF;
VAR_R3F_DEBUG_Invulnerability 				= false;
VAR_R3F_DEBUG_Teleportation				= false;
VAR_R3F_DEBUG_SetVelocity				= CONST_R3F_DEBUG_VELOCITY1;
VAR_R3F_DEBUG_InfiniteAmmoState				= CONST_R3F_DEBUG_INFINITEAMMO_OFF;
VAR_R3F_DEBUG_Default_Script				= "";

wcgarbage = [] spawn {
	private ["_lowfps"];
	wclowfps = 1000; 
	while { true } do { 
		_lowfps = diag_fps; 
		if(_lowfps < wclowfps) then { 
			wclowfps = _lowfps ;
		}; 
		sleep 0.01;
	};
};

VAR_R3F_DEBUG_Spy	= [
		"(position player)",
		"diag_fps",
		"wclowfps"
];

CONST_R3F_DEBUG_OptionNamesAndValues =
[
	[localize "STR_R3F_DEBUG_SHOW_AIS",   		[localize "STR_R3F_DEBUG_OFF", localize "STR_R3F_DEBUG_ON"]],
	[localize "STR_R3F_DEBUG_IA_SKILL",    		[localize "STR_R3F_DEBUG_POOR", localize "STR_R3F_DEBUG_NORMAL", localize "STR_R3F_DEBUG_GOOD"]],
	[localize "STR_R3F_DEBUG_GOD_SIGHT", 	  	[localize "STR_R3F_DEBUG_OFF", localize "STR_R3F_DEBUG_ON", localize "STR_R3F_DEBUG_ACTIVEP"]],
	[localize "STR_R3F_DEBUG_DISABLE_AI", 	  	[localize "STR_R3F_DEBUG_OFF", localize "STR_R3F_DEBUG_ON"]],
	[localize "STR_R3F_DEBUG_NEUTRAL", 	  		[localize "STR_R3F_DEBUG_OFF", localize "STR_R3F_DEBUG_ON"]],
	[localize "STR_R3F_DEBUG_INVULNERABILITY", 	[localize "STR_R3F_DEBUG_OFF", localize "STR_R3F_DEBUG_ON"]],
	[localize "STR_R3F_DEBUG_VELOCITY_MULT", 	["x1", "x2", "x4", "x8", "x16", "x32"]],
	[localize "STR_R3F_DEBUG_INFINITE_AMMO", 	[localize "STR_R3F_DEBUG_OFF", localize "STR_R3F_DEBUG_ON"]],
	[localize "STR_R3F_DEBUG_KILL_THEM_ALL",   	[localize "STR_R3F_DEBUG_PROCEED"]],
	[localize "STR_R3F_DEBUG_CREATE_VEHICLE", 	[localize "STR_R3F_DEBUG_PROCEED"]],
	[localize "STR_R3F_DEBUG_TELEPORT", 		[localize "STR_R3F_DEBUG_OFF", localize "STR_R3F_DEBUG_ON"]],
	[localize "STR_R3F_DEBUG_CAMERA", 			[localize "STR_R3F_DEBUG_PROCEED"]],
	[localize "STR_R3F_DEBUG_BIS_HELP",			[localize "STR_R3F_DEBUG_PROCEED"]],
	[localize "STR_R3F_DEBUG_SCRIPT", 			[localize "STR_R3F_DEBUG_PROCEED"]],
	[localize "STR_R3F_DEBUG_SPY", 				[localize "STR_R3F_DEBUG_PROCEED"]]
];

assert ((count CONST_R3F_DEBUG_OptionNamesAndValues) == CONST_R3F_DEBUG_OPTION_COUNT);

VAR_R3F_DEBUG_OptionValueIndices =
[
	0, // ShowIA
	1, // IA's Skill
	0, // God Sight
	0, // Disable AI
	0, // Neutral
	0, // Invulnerability
	0, // Velocity
	0, // Infinite ammo
	0, // Kill them all
	0, // create vehicle
	0, // teleportation
	0, // camera
	0, // Bis_Help
	0, // script command
	0  // variables spy
];

VAR_R3F_DEBUG_Controls =
[
    R3F_DEBUG_ID_main_panel,
    R3F_DEBUG_ID_frame,
    R3F_DEBUG_ID_icon,
    R3F_DEBUG_ID_title,
    R3F_DEBUG_ID_VERSION,
    R3F_DEBUG_ID_option_0,
    R3F_DEBUG_ID_option_1,
    R3F_DEBUG_ID_option_2,
    R3F_DEBUG_ID_option_3,
    R3F_DEBUG_ID_option_4,
    R3F_DEBUG_ID_option_5,
    R3F_DEBUG_ID_option_6,
    R3F_DEBUG_ID_option_7,
    R3F_DEBUG_ID_option_8,
    R3F_DEBUG_ID_option_9,
    R3F_DEBUG_ID_option_10,
    R3F_DEBUG_ID_option_11,
    R3F_DEBUG_ID_option_12,
    R3F_DEBUG_ID_option_13,
    R3F_DEBUG_ID_option_14,
    R3F_DEBUG_ID_option_value_0,
    R3F_DEBUG_ID_option_value_1,
    R3F_DEBUG_ID_option_value_2,
    R3F_DEBUG_ID_option_value_3,
    R3F_DEBUG_ID_option_value_4,
    R3F_DEBUG_ID_option_value_5,
    R3F_DEBUG_ID_option_value_6,
    R3F_DEBUG_ID_option_value_7,
    R3F_DEBUG_ID_option_value_8,
    R3F_DEBUG_ID_option_value_9,
    R3F_DEBUG_ID_option_value_10,
    R3F_DEBUG_ID_option_value_11,
    R3F_DEBUG_ID_option_value_12,
    R3F_DEBUG_ID_option_value_13,
    R3F_DEBUG_ID_option_value_14
    
];

VAR_R3F_DEBUG_Watcher_Controls =
[	
		R3F_DEBUG_ID_Watcher_List,
        R3F_DEBUG_ID_Watcher_Bkg
];

assert ((count VAR_R3F_DEBUG_OptionValueIndices) == CONST_R3F_DEBUG_OPTION_COUNT);


call compile preprocessFile "extern\R3F_DEBUG\Scripts\FNCT_R3F_DEBUG_DoTeleport.sqf";
call compile preprocessFile "extern\R3F_DEBUG\Scripts\FNCT_R3F_DEBUG_KillThemAll.sqf";
call compile preprocessFile "extern\R3F_DEBUG\Scripts\FNCT_R3F_DEBUG_MakeVehicle.sqf";
call compile preprocessFile "extern\R3F_DEBUG\Scripts\FNCT_R3F_DEBUG_DoCamera.sqf";
call compile preprocessFile "extern\R3F_DEBUG\Scripts\FNCT_R3F_DEBUG_SetTeleportation.sqf";
call compile preprocessFile "extern\R3F_DEBUG\Scripts\FNCT_R3F_DEBUG_SetInvulnerability.sqf";
call compile preprocessFile "extern\R3F_DEBUG\Scripts\FNCT_R3F_DEBUG_SetVelocity.sqf";
call compile preprocessFile "extern\R3F_DEBUG\Scripts\FNCT_R3F_DEBUG_InfiniteAmmo.sqf";
call compile preprocessFile "extern\R3F_DEBUG\Scripts\FNCT_R3F_DEBUG_GetNormalizedSpeedInterp.sqf";
call compile preprocessFile "extern\R3F_DEBUG\Scripts\FNCT_R3F_DEBUG_SetNeutrality.sqf";
call compile preprocessFile "extern\R3F_DEBUG\Scripts\FNCT_R3F_DEBUG_InactiveIA.sqf";
call compile preprocessFile "extern\R3F_DEBUG\Scripts\FNCT_R3F_DEBUG_GodSight.sqf";
call compile preprocessFile "extern\R3F_DEBUG\Scripts\FNCT_R3F_DEBUG_SetSkill.sqf";
call compile preprocessFile "extern\R3F_DEBUG\Scripts\FNCT_R3F_DEBUG_Diag_Log.sqf";
call compile preprocessFile "extern\R3F_DEBUG\Scripts\FNCT_R3F_DEBUG_SetShowIA.sqf";
call compile preprocessFile "extern\R3F_DEBUG\Scripts\FNCT_R3F_DEBUG_ShowMap.sqf";
call compile preprocessFile "extern\R3F_DEBUG\Scripts\FNCT_R3F_DEBUG_ShowDlgScript.sqf";
call compile preprocessFile "extern\R3F_DEBUG\Scripts\FNCT_R3F_DEBUG_ShowDlgSpy.sqf";
call compile preprocessFile "extern\R3F_DEBUG\Scripts\FNCT_R3F_DEBUG_Spy.sqf";
call compile preprocessFile "extern\R3F_DEBUG\Scripts\FNCT_R3F_DEBUG_Interface.sqf";

disableSerialization;

FNCT_R3F_DEBUG_ReCoord = {
	private ["_show","_main_dialog","_control"];
	_main_dialog = uiNamespace getVariable "VAR_R3F_DEBUG_main_dialog";
	{
		_control = _main_dialog displayCtrl _x;
		_control ctrlSetPosition [((ctrlPosition _control select 0) * safeZoneW) + safeZoneX, ((ctrlPosition _control select 1) * safeZoneH) + safeZoneY, (ctrlPosition _control select 2) * safeZoneW, (ctrlPosition _control select 3) * safeZoneH];
		_control ctrlCommit 0;
	}
	forEach VAR_R3F_DEBUG_Controls;
};

	
FNCT_R3F_DEBUG_ShowMainDlg = {
	private ["_show","_main_dialog","_control"];
	disableSerialization;
	_show = _this select 0;
	_main_dialog = uiNamespace getVariable "VAR_R3F_DEBUG_main_dialog";
	{
		//if((_x != R3F_DEBUG_ID_icon) && (_x != R3F_DEBUG_ID_title) && (_x != R3F_DEBUG_ID_VERSION)) then {
			_control = _main_dialog displayCtrl _x;
			_control ctrlshow _show;
			_control ctrlCommit 0;
		//};
	}forEach VAR_R3F_DEBUG_Controls;
	/*
	_control = _main_dialog displayCtrl R3F_DEBUG_ID_Watcher_Title;
	_control ctrlshow _show;
	_control ctrlCommit 0;
	*/
};

FNCT_R3F_DEBUG_ShowWatcher = {
	private ["_show","_main_dialog","_control"];
	disableSerialization;
	[] spawn {call FNCT_R3F_DEBUG_Fill_List;};
	[] call FNCT_R3F_DEBUG_Resize_list;
	_show = _this select 0;
	_main_dialog = uiNamespace getVariable "VAR_R3F_DEBUG_main_dialog";
	{
		_control = _main_dialog displayCtrl _x;
		_control ctrlshow _show;
		_control ctrlCommit 0;
		
	}forEach VAR_R3F_DEBUG_Watcher_Controls;

	_control = _main_dialog displayCtrl R3F_DEBUG_ID_Watcher_Title;
	_control ctrlshow _show;
	_control ctrlCommit 0;
};

FNCT_R3F_DEBUG_CallDebugFunction = 
{
	private ["_optionIndex", "_optionValueIndex"];

	if (!VAR_R3F_DEBUG_ShowDlg) exitwith{};
	
	if (VAR_R3F_DEBUG_InCamera)  exitwith{};
	
	_optionIndex = _this select 0;
	_optionValueIndex = _this select 1;
	
	if (_optionIndex == 0) then
	{
		[((_optionValueIndex select _optionIndex)== 1)] spawn FNCT_R3F_DEBUG_SetShowIA;
	};
	
	if (_optionIndex == 1) then
	{
		VAR_R3F_DEBUG_Skill = switch (_optionValueIndex select _optionIndex) do
		{
  			case 0: {CONST_R3F_DEBUG_SKILL_POOR};
  			case 1: {CONST_R3F_DEBUG_SKILL_NORMAL};
  			case 2: {CONST_R3F_DEBUG_SKILL_GOOD};
		};
		[VAR_R3F_DEBUG_Skill] call FNCT_R3F_DEBUG_SetSkill;
	};
	
	if (_optionIndex == 2) then
	{
		[(_optionValueIndex select _optionIndex)] call FNCT_R3F_DEBUG_GodSight;
	};
	
	if (_optionIndex == 3) then
	{
		if((_optionValueIndex select _optionIndex)== 0) then{
			[] call FNCT_R3F_DEBUG_InactiveIA;
		}else{
			[] call FNCT_R3F_DEBUG_ActiveIA;
		};	
	};
	
	if (_optionIndex == 4) then
	{
		[((_optionValueIndex select _optionIndex)== 1)] call FNCT_R3F_DEBUG_SetNeutrality;
	};
	
	if (_optionIndex == 5) then
	{
		[((_optionValueIndex select _optionIndex)== 1)] call FNCT_R3F_DEBUG_SetInvulnerability;
	};
	
	if (_optionIndex == 6) then
	{
		VAR_R3F_DEBUG_SetVelocity = switch (_optionValueIndex select _optionIndex) do
		{
  			case 0: {CONST_R3F_DEBUG_VELOCITY1};
  			case 1: {CONST_R3F_DEBUG_VELOCITY2};
  			case 2: {CONST_R3F_DEBUG_VELOCITY4};
  			case 3: {CONST_R3F_DEBUG_VELOCITY8};
  			case 4: {CONST_R3F_DEBUG_VELOCITY16};
  			case 5: {CONST_R3F_DEBUG_VELOCITY32};
		};
		//[VAR_R3F_DEBUG_SetVelocity] call FNCT_R3F_DEBUG_SetVelocity
	};
	
	if (_optionIndex == 7) then
	{
		[((_optionValueIndex select _optionIndex)== 1)] call FNCT_R3F_DEBUG_InfiniteAmmo;
	};
	
	if (_optionIndex == 8) then
	{
		[] call FNCT_R3F_DEBUG_KillThemAll;
	};
	
	if (_optionIndex == 9) then
	{
		[] call FNCT_R3F_DEBUG_MakeVehicle;
	};
	
	if (_optionIndex == 10) then
	{
		[((_optionValueIndex select _optionIndex)== 1)] spawn FNCT_R3F_DEBUG_SetTeleportation;
	};
	
	if (_optionIndex == 11) then
	{
		if(!VAR_R3F_DEBUG_InCamera) then {
			[CONST_R3F_DEBUG_MAP4CAMERA] spawn FNCT_R3F_DEBUG_ShowMap;
		};
	};
	
	if (_optionIndex == 12) then
	{
		[] call BIS_fnc_help;
	};
	
	if (_optionIndex == 13) then
	{
		[] spawn FNCT_R3F_DEBUG_ShowDlgScript;
	};

	if (_optionIndex == 14) then
	{
		[] spawn FNCT_R3F_DEBUG_ShowDlgSpy;
	};


};

FNCT_R3F_DEBUG_UpdateDisplayColorizeValueChanged =
{
	private ["_optionValue"];

	disableSerialization;
	
	_optionValue = _this select 0;
	sleep 0.25;
	_optionValue ctrlSetBackgroundColor [ CONST_R3F_DEBUG_OPTION_BACKGROUND_COLOR ];
};


FNCT_R3F_DEBUG_UpdateDisplay =
{
	private ["_optionIndex", 
			 "_optionValueIndex",
		     "_optionValueIndices", 
			 "_main_dialog", 
			 "_option", 
			 "_optionValue", 
			 "_i",
			 "_valueChangedEffect"];

	disableSerialization;
	_main_dialog = uiNamespace getVariable "VAR_R3F_DEBUG_main_dialog";	
	_optionIndex = _this select 0;
	_optionValueIndices = _this select 1;
	_valueChangedEffect = _this select 2;

	if (not (isNull _main_dialog)) then
	{
		
		for [{_i = 0}, { _i < CONST_R3F_DEBUG_OPTION_COUNT }, { _i = _i + 1 }] do
		{
			_option = _main_dialog displayCtrl (R3F_DEBUG_ID_option_0 + _i);
			_optionValue = _main_dialog displayCtrl (R3F_DEBUG_ID_option_value_0 + _i);
			
			_optionValueIndex = _optionValueIndices select _i;

			_option ctrlSetText ((CONST_R3F_DEBUG_OptionNamesAndValues select _i) select 0);
			_optionValue ctrlSetText(format ["[%1]", (((CONST_R3F_DEBUG_OptionNamesAndValues select _i) select 1) select _optionValueIndex)]);
			
			if (_i == _optionIndex) then
			{
				_option ctrlSetBackgroundColor [ CONST_R3F_DEBUG_OPTION_SELECTED_BACKGROUND_COLOR ];
				
				if (_valueChangedEffect) then
				{
					if (not (scriptDone VAR_R3F_DEBUG_UpdateDisplayColorizeValueChangedHandle)) then
					{
						terminate VAR_R3F_DEBUG_UpdateDisplayColorizeValueChangedHandle;
					    waitUntil { scriptDone VAR_R3F_DEBUG_UpdateDisplayColorizeValueChangedHandle; };
					};
					_optionValue ctrlSetBackgroundColor [ CONST_R3F_DEBUG_OPTION_VALUE_BLINK_COLOR ];
					VAR_R3F_DEBUG_UpdateDisplayColorizeValueChangedHandle = [ _optionValue ] spawn FNCT_R3F_DEBUG_UpdateDisplayColorizeValueChanged;
				}
				else
				{
					_optionValue ctrlSetBackgroundColor [ CONST_R3F_DEBUG_OPTION_BACKGROUND_COLOR ];
				};
			}
			else
			{
				_option ctrlSetBackgroundColor [ CONST_R3F_DEBUG_OPTION_BACKGROUND_COLOR ];
			};
		};
		
		[] spawn {call FNCT_R3F_DEBUG_Fill_List;};
		[] call FNCT_R3F_DEBUG_Resize_list;
		
	};
};

FNCT_R3F_DEBUG_KeyDown = 
{
	private["_handled", "_ctrl", "_dikCode", "_shift", "_ctrl", "_alt", "_optionValueIndex", "_propertyValueChanged", "_maxValueCount"];
	_ctrl = _this select 0;
	_dikCode = _this select 1;
	_shift = _this select 2;
	_ctrl = _this select 3;
	_alt = _this select 4;
	_handled = false;
	_optionValueIndex = 0;
	_propertyValueChanged = false;
	
	if (_dikCode == DIK_LEFT && VAR_R3F_DEBUG_ShowDlg ) then
	{
		_handled = true;

		_maxValueCount = count ((CONST_R3F_DEBUG_OptionNamesAndValues select VAR_R3F_DEBUG_OptionIndex) select 1);
		_optionValueIndex = VAR_R3F_DEBUG_OptionValueIndices select VAR_R3F_DEBUG_OptionIndex;
		
		if (_optionValueIndex > 0 or _maxValueCount == 1) then
		{
			_propertyValueChanged = true;
		};
		
		if (_optionValueIndex > 0) then
		{
			_optionValueIndex = _optionValueIndex - 1;
			VAR_R3F_DEBUG_OptionValueIndices set [VAR_R3F_DEBUG_OptionIndex, _optionValueIndex];
		};
	}
	else
	{
		if (_dikCode == DIK_RIGHT && VAR_R3F_DEBUG_ShowDlg ) then
		{
			_handled = true;
		
			_maxValueCount = count ((CONST_R3F_DEBUG_OptionNamesAndValues select VAR_R3F_DEBUG_OptionIndex) select 1);
			_optionValueIndex = VAR_R3F_DEBUG_OptionValueIndices select VAR_R3F_DEBUG_OptionIndex;

			if ((_optionValueIndex < (_maxValueCount - 1)) or _maxValueCount == 1) then
			{
				_propertyValueChanged = true;
			};
			
			if (_optionValueIndex < _maxValueCount - 1) then
			{
				_optionValueIndex = _optionValueIndex + 1;
				VAR_R3F_DEBUG_OptionValueIndices set [VAR_R3F_DEBUG_OptionIndex, _optionValueIndex];
				_propertyValueChanged = true;
			};
		}
		else
		{
			if (_dikCode == DIK_UP && VAR_R3F_DEBUG_ShowDlg ) then
			{
				_handled = true;
				
				VAR_R3F_DEBUG_OptionIndex = (VAR_R3F_DEBUG_OptionIndex - 1 + CONST_R3F_DEBUG_OPTION_COUNT) mod CONST_R3F_DEBUG_OPTION_COUNT;
			}
			else
			{
				if (_dikCode == DIK_DOWN && VAR_R3F_DEBUG_ShowDlg ) then
				{
					_handled = true;
					
					VAR_R3F_DEBUG_OptionIndex = (VAR_R3F_DEBUG_OptionIndex + 1) mod CONST_R3F_DEBUG_OPTION_COUNT;
				}else{
						if (_dikCode == DIK_F && _alt) then
						{
							_handled = true;
							
							VAR_R3F_DEBUG_ShowDlg = ! VAR_R3F_DEBUG_ShowDlg;
							[VAR_R3F_DEBUG_ShowDlg] call FNCT_R3F_DEBUG_ShowMainDlg;
						};
						if (_dikCode == DIK_L && _alt) then
						{
							_handled = true;
							
							VAR_R3F_DEBUG_ShowDlgWatcher = ! VAR_R3F_DEBUG_ShowDlgWatcher;
							[VAR_R3F_DEBUG_ShowDlgWatcher] call FNCT_R3F_DEBUG_ShowWatcher;
						};
						if((VAR_R3F_DEBUG_SetVelocity > 1 ) && (_dikCode in VAR_R3F_DEBUG_ForwardKeys) ) then {
							[] call FNCT_R3F_DEBUG_UpdateVelocity2;
							_handled = true;
						};
				};		
			};
		};
	};
	
	if (_handled) then
	{
		[VAR_R3F_DEBUG_OptionIndex, VAR_R3F_DEBUG_OptionValueIndices, _propertyValueChanged] spawn FNCT_R3F_DEBUG_UpdateDisplay;
		
		if (_propertyValueChanged) then
		{
			[VAR_R3F_DEBUG_OptionIndex, VAR_R3F_DEBUG_OptionValueIndices] call FNCT_R3F_DEBUG_CallDebugFunction;
		};
	};
	
	_handled;
};


FNCT_R3F_DEBUG_launch = 
{
	private [ "_display_commandpanel_main", "_idx_keydown_eh", "_main_dialog", "_control" ];

	waitUntil
	{
		sleep 1;
		!isNull (findDisplay 46)
	};
	
	1 cutRsc ["R3F_DEBUG_DLG_commandpanel_main", "PLAIN"];
	
	while { isNull (uiNamespace getVariable "VAR_R3F_DEBUG_main_dialog") } do
	{
		sleep 2;
	};
	
	_display_commandpanel_main = findDisplay 46;
	
	_idx_keydown_eh = _display_commandpanel_main displayAddEventHandler ["KeyDown", "_this call FNCT_R3F_DEBUG_KeyDown;"];
	
	[VAR_R3F_DEBUG_OptionIndex, VAR_R3F_DEBUG_OptionValueIndices, false] call FNCT_R3F_DEBUG_UpdateDisplay;
	
	[] call FNCT_R3F_DEBUG_ReCoord;
	[VAR_R3F_DEBUG_ShowDlg] call FNCT_R3F_DEBUG_ShowMainDlg;
	
	[VAR_R3F_DEBUG_ShowDlgWatcher] call FNCT_R3F_DEBUG_ShowWatcher;

};


[] call FNCT_R3F_DEBUG_launch;




