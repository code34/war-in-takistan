/*******************************************************************************************
 Copyright (C) 2010 Team ~R3F~

 This program is free software under the terms of the GNU General Public License version 3.
 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.

@authors team-r3f.org
@version 0.03
@date 20100514

@function void FNCT_R3F_DEBUG_SetShowIA
@params1 (boolean) CONST_R3F_DEBUG_SHOW_IA = voir les IA sur la map, CONST_R3F_DEBUG_HIDE_IA ne pas voir les IA sur la map
@return rien
********************************************************************************************/

#include "constants_R3F_DEBUG.sqf";

FNCT_R3F_DEBUG_GetMarkerColor = {
	private ["_unit","_color"];
	_unit = _this select 0;
	if (side _unit == playerSide) then {
		_color = "ColorGreen";
	} else {
		if (side _unit == civilian) then {
			_color = "ColorBlue";
		} else {
			_color = "ColorRed";
		};
	};
	_color;
};

FNCT_R3F_DEBUG_GetMarkerSize = {
	private ["_unit","_size"];
	_unit = _this select 0;
	
	if ((vehicle _unit) isKindOf "Man") then {
		_size = [0.2, 0.2];
	} else {
		if ((vehicle _unit) isKindOf "Land") then {
			_size = [0.2, 0.4];
		} else {
			if ((vehicle _unit) isKindOf "Air") then {
				_size = [0.2, 0.4];
			} else {
				if ((vehicle _unit) isKindOf "Ship") then {
					_size = [0.3, 0.3];
				};
			};
		};
	};
	_size;
};

FNCT_R3F_DEBUG_GetMarkerType = {
	private ["_unit","_type"];
	_unit = _this select 0;
	if ((vehicle _unit) isKindOf "Man") then {
		_type = "hd_arrow";
	} else {
		if ((vehicle _unit) isKindOf "Land") then {
			_type = "mil_arrow";
		} else {
			if ((vehicle _unit) isKindOf "Air") then {
				_type = "mil_arrow2";
			} else {
				if ((vehicle _unit) isKindOf "Ship") then {
					_type = "mil_arrow2";
				};
			};
		};
	};
	_type;
};


FNCT_R3F_DEBUG_GetMarkerText = {
	private ["_unit","_text"];
	_unit = _this select 0;
	if (_unit == leader _unit) then {
		_driver = assignedDriver (vehicle _unit);
		_array_cargo = assignedCargo (vehicle _unit);
		_nbr_cargo = count _array_cargo;
		if ((((units _unit) select (count units _unit) - 1) in _array_cargo) && (_driver in (units _unit))) then {
			_nbr_cargo = 0;
		};
		_text =  format ["%1",_nbr_cargo + count (units (vehicle _unit))];
	};
	_text;
};


FNCT_R3F_DEBUG_CleanAllMarker = {
	{
		deleteMarkerLocal (_x select 1)
	} forEach (_this select 0);
};

FNCT_R3F_DEBUG_CleanArray = {
	private ["_array_temp"];
	_array_temp = [];
	{
		if((isNull(_x select 0)) || (!alive (_x select 0))) then {
			deleteMarkerLocal (_x select 1);
		}else{
			_array_temp = _array_temp + [_x];
		};
	} foreach (_this select 0);
	_array_temp;
};

FNCT_R3F_DEBUG_IsInArray = {
	private ["_ret"];
	_ret = false;
	if(count (_this select 0) > 0) then {
		{
			if ((_this select 1) in _x) then {
				_ret = true;
			};		
		} foreach (_this select 0);
	};
	_ret;
};

FNCT_R3F_DEBUG_SetShowIA = {
	private ["_array_mark","_all_units","_unit","_mark","_marker_exists","_vehicule","_driver","_array_cargo","_nbr_cargo"];
	if ((count _this) > 0) then {
		VAR_R3F_DEBUG_ShowIA = _this select 0;
	} else {
		VAR_R3F_DEBUG_ShowIA = true;
	};
	_array_mark = [];
	while {VAR_R3F_DEBUG_ShowIA} do {
		_all_units = Allunits;
		{
			_unit = _x;
			if (alive _unit) then {
				_mark =  str (vehicle _unit);
				_marker_exists = [_array_mark,_mark] call FNCT_R3F_DEBUG_IsInArray;
				if (!(_marker_exists)) then {
					_mark = createMarkerLocal [_mark,[0,0]];
					_mark setMarkerTypeLocal ([_unit] call FNCT_R3F_DEBUG_GetMarkerType);
					_mark setMarkerColorLocal ([_unit] call FNCT_R3F_DEBUG_GetMarkerColor);
					_mark setMarkerSizeLocal ([_unit] call FNCT_R3F_DEBUG_GetMarkerSize);
					_array_mark = _array_mark + [[_unit,_mark]];
					_vehicule = assignedVehicle _unit;
				};
				if (assignedVehicle _unit != _vehicule) then {
					_mark setMarkerTypeLocal ([_unit] call FNCT_R3F_DEBUG_GetMarkerType);
					_mark setMarkerSizeLocal ([_unit] call FNCT_R3F_DEBUG_GetMarkerSize);
				};
				if (_unit == leader _unit) then {
					_mark setMarkerTextLocal ([_unit] call FNCT_R3F_DEBUG_GetMarkerText);
				};
				_mark setMarkerPosLocal (getPos (vehicle _unit));
				_mark setMarkerDirLocal (getDir (vehicle _unit));
			};
		} foreach _all_units;
		sleep 1;
		_array_mark = [_array_mark] call FNCT_R3F_DEBUG_CleanArray;
	};
	[_array_mark] call FNCT_R3F_DEBUG_CleanAllMarker;
};
