/*******************************************************************************************
 Copyright (C) 2010 Team ~R3F~

 This program is free software under the terms of the GNU General Public License version 3.
 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.

@authors team-r3f.org
@version 0.03
@date 20100506

@function void FNCT_R3F_DEBUG_InactiveIA
@params1 (array) behaviour type ["TARGET","AUTOTARGET","MOVE","ANIM"]
@return rien

@function void FNCT_R3F_DEBUG_ActiveIA
@params1 (array) behaviour type ["TARGET","AUTOTARGET","MOVE","ANIM"]
@return rien
********************************************************************************************/

#include "constants_R3F_DEBUG.sqf";

FNCT_R3F_DEBUG_SetIAMode = {
	private ["_mode","_params","_pos_center","_array_ai","_unit"];
	_mode = _this select 0;
    _params = _this select 1;
    _array_ai = allunits;
    {	
    	if ((playerSide != side _x) && (side _x != Civilian)) then {	
    		_unit = _x;	
    		{
    			if( _mode ) then {
    				_unit enableAI _x;
    			}else{
    				_unit disableAI _x;
    			};
    		}foreach _params;
    	};
    }foreach _array_ai;		
};

FNCT_R3F_DEBUG_InactiveIA = {
	private ["_params"];
    if( count _this > 0) then {
    	_params = _this;
    }else{
    	_params = CONST_R3F_DEBUG_DEFAULT_AIBEHAVIOUR;
    };
    [CONST_R3F_DEBUG_INACTIVEIA, _params] call FNCT_R3F_DEBUG_SetIAMode;
};

FNCT_R3F_DEBUG_ActiveIA = {
	private ["_params"];
    if( count _this > 0) then {
    	_params = _this;
    }else{
    	_params = CONST_R3F_DEBUG_DEFAULT_AIBEHAVIOUR;
    };
    [CONST_R3F_DEBUG_ACTIVEIA, _params] call FNCT_R3F_DEBUG_SetIAMode;
};
