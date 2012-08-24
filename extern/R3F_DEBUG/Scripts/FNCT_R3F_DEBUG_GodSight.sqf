/*******************************************************************************************
 Copyright (C) 2010 Team ~R3F~

 This program is free software under the terms of the GNU General Public License version 3.
 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.

@authors team-r3f.org
@version 0.01
@date 20100523

@function void FNCT_R3F_DEBUG_GodSight
@params1 (boolean) on ou off
@return (void)
********************************************************************************************/

#include "constants_R3F_DEBUG.sqf";

FNCT_R3F_DEBUG_doGodSight ={
	private ["_unit", "_check", "_base", "_temp", "_count"];
	
	if (VAR_R3F_DEBUG_GodSightState == 1) then {
		while {VAR_R3F_DEBUG_GodSightState > 0} do {
			_unit = cursorTarget;
			if!(isnull _unit) then {
	
				_check = false;
				_temp = typeof _unit;
				_base = [];
	
				while { !_check } do {
					_base = _base + [_temp];
					_temp = configName(inheritsFrom (configFile >> "CfgVehicles" >> _temp));
					if (_temp == "All") then { _check = true};			
				};
				_base = _base + ["All"];
	
				_temp = "";
				_count = 0;
	
				{
					if(_count > 0) then {
						_temp = _x + ">>" + _temp;
					} else {
						_temp = _x;
					};
					_count = _count + 1;
				}foreach _base;
				
				hintsilent format["%1 is now identified as varname: wcdebugunit", _temp];
				wcdebugunit = _unit;
			};
			sleep 0.2;
		};
	};
	if (VAR_R3F_DEBUG_GodSightState == 2) then {
		[] call BIS_fnc_configviewer;
	};
};

FNCT_R3F_DEBUG_GodSight ={
	if ((count _this)>0) then{
		VAR_R3F_DEBUG_GodSightState = _this select 0;
	}else{
		VAR_R3F_DEBUG_GodSightState = 1;
	};
   
	if (VAR_R3F_DEBUG_GodSightState > 0) then{
		[] spawn FNCT_R3F_DEBUG_doGodSight;
	};
   VAR_R3F_DEBUG_GodSightState;
};

