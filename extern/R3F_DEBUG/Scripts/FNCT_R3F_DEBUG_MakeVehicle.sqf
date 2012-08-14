/*******************************************************************************************
 Copyright (C) 2010 Team ~R3F~

 This program is free software under the terms of the GNU General Public License version 3.
 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.

@authors team-r3f.org
@version 0.01
@date 20100422

@function void FNCT_R3F_DEBUG_MakeVehicle
@params1 (string) Classe du véhicule à créer
@params2 (array) Position de création
@return (object) le véhicule créé
********************************************************************************************/

#include "constants_R3F_DEBUG.sqf";

FNCT_R3F_DEBUG_MakeVehicle = {
   private ["_class","_pos", "_vehicle"];
   if ((count _this)>0) then{
      _class = _this select 0;
      if((count _this)>1) then {
         _pos = _this select 1;
      }else{
         _pos = getPos player;
      };
   }else{
      _class = CONST_R3F_DEBUG_DEFAUT_VEHICLE;
      _pos = getPos player;
   };

   _vehicle = _class createVehicle _pos;
   _vehicle setvehiclevarname "debugvehicle";
	
   if (not (isNull _vehicle)) then {
      if (not (isNull VAR_R3F_DEBUG_Vehicle)) then {
         deleteVehicle VAR_R3F_DEBUG_Vehicle;
      };     
      VAR_R3F_DEBUG_Vehicle = _vehicle;
   };
   _vehicle;
};
