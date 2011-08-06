/*******************************************************************************************
 Copyright (C) 2010 Team ~R3F~

 This program is free software under the terms of the GNU General Public License version 3.
 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.

@authors team-r3f.org
@version 0.01
@date 20100509

No used at this time

@function void FNCT_R3F_DEBUG_Diag_Log
@params1 (string) texte à loguer
@params1 (boolean) faire suivre le text dans le diag_log BIS
@return (void)
********************************************************************************************/

#include "constants_R3F_DEBUG.sqf";

FNCT_R3F_DEBUG_Diag_Log = {
	private ["_void","_x","_len"];
	
	VAR_R3F_DEBUG_ARR_LOG = VAR_R3F_DEBUG_ARR_LOG + [[_this select 0,date]];
	if(count VAR_R3F_DEBUG_ARR_LOG > CONST_R3F_DEBUG_MAX_LOG_LINES) then {
		_void = VAR_R3F_DEBUG_ARR_LOG;
		VAR_R3F_DEBUG_ARR_LOG = [];
		_len = count _void;
		for [{_x=1},{_x<_len},{_x=_x+1}] do{
			VAR_R3F_DEBUG_ARR_LOG = VAR_R3F_DEBUG_ARR_LOG + [_void select _x];
		};
	};

	if( count _this > 1) then {
		if( (_this select 1) ) then {
			diag_log format["%1",_this select 0];
		};
	};
};
