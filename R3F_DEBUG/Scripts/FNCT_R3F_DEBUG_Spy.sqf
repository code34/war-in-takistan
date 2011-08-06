/*******************************************************************************************
 Copyright (C) 2010 Team ~R3F~

 This program is free software under the terms of the GNU General Public License version 3.
 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.

@authors team-r3f.org
@version 0.02
@date 20101020
********************************************************************************************/

#include "r3f_debug_command_panel_includes.h"
#include "constants_R3F_DEBUG.sqf";

FNCT_R3F_DEBUG_Spy_Add = {
	if ( ! ((_this select 0) in VAR_R3F_DEBUG_Spy)) then { 
		VAR_R3F_DEBUG_Spy = VAR_R3F_DEBUG_Spy + [ (_this select 0) ];
	}
};

FNCT_R3F_DEBUG_Spy_Del = {
	if ( ((_this select 0) in VAR_R3F_DEBUG_Spy)) then { 
		VAR_R3F_DEBUG_Spy = VAR_R3F_DEBUG_Spy - [ (_this select 0) ];
	};
};

FNCT_R3F_DEBUG_Fill_List = {
	while{true} do {
    	disableSerialization;
    	_dlg = uiNamespace getVariable "VAR_R3F_DEBUG_main_dialog";
    	if (not (isNull _dlg)) then {
        	_list = _dlg displayCtrl R3F_DEBUG_ID_Watcher_List;
        	
        	lbClear _list;
        
        	{
        		_index = _list lbAdd ( _x); 
        		_list lbSetColor [_index, [0.0745,0.1843,0.0902,1.0000]];
        		_s = call compile format["str %1",_x];
        		//_s = format ["%1", call compile format _x];
        		//_s = format ["str %1", call compile format _x];
        		if(isnil("_s")) then {
        			_s = "nil";
        		};
       			_index = _list lbAdd ( _s); 
        		_list lbSetSelected [_index, true];
        	}foreach VAR_R3F_DEBUG_Spy;
        	sleep 1;
    	};
	};
};

FNCT_R3F_DEBUG_Fill_Spy_List = {
	disableSerialization;
	_dlg = uiNamespace getVariable "R3F_SPY_DLG";
	if (not (isNull _dlg)) then {
    	_list = _dlg displayCtrl R3F_DEBUG_ID_SPY_LIST;
    	
    	lbClear _list;
    
    	{
    		_index = _list lbAdd ( _x); 
    		_list lbSetSelected [_index, true];
    		
    	}foreach VAR_R3F_DEBUG_Spy;
    	sleep 1;
	};
};

FNCT_R3F_DEBUG_Resize_list ={
	disableSerialization;
	_dlg = uiNamespace getVariable "VAR_R3F_DEBUG_main_dialog";
	if (not (isNull _dlg)) then {
        _list = _dlg displayCtrl R3F_DEBUG_ID_Watcher_List;
		_n = count (VAR_R3F_DEBUG_Spy);	
		n = _n + 2;
		_pos = ctrlPosition _list;
		_list ctrlSetPosition [_pos select 0, _pos select 1, _pos select 2, (_n * 0.06)];
		_list ctrlCommit 0;
		
		_ctrl = _dlg displayCtrl R3F_DEBUG_ID_Watcher_Bkg;
		_pos = ctrlPosition _ctrl;
		_ctrl ctrlSetPosition [_pos select 0, _pos select 1, _pos select 2, (_n * 0.06)];
		_ctrl ctrlCommit 0;
	};	
};