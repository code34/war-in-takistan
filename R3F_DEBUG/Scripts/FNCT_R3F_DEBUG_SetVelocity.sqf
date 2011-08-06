/*******************************************************************************************
 Copyright (C) 2010 Team ~R3F~

 This program is free software under the terms of the GNU General Public License version 3.
 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.

@authors team-r3f.org
@version 0.01
@date 20100502

@function void FNCT_R3F_DEBUG_SetVelocity
@params1 (int) Facteur d'accélération
@return (int) le facteur d'accélération actuel
********************************************************************************************/


#include "constants_R3F_DEBUG.sqf";


FNCT_R3F_DEBUG_GetVelocityAsLocalizedString =
{
   private ["_result"];
   switch (VAR_R3F_DEBUG_Velocity) do
   {
   case CONST_R3F_DEBUG_VELOCITY1:
      {
         _result = localize "STR_R3F_DEBUG_VELOCITY1";
      };
   case CONST_R3F_DEBUG_VELOCITY2:
      {
         _result = localize "STR_R3F_DEBUG_VELOCITY2";
      };
   case CONST_R3F_DEBUG_VELOCITY4:
      {
         _result = localize "STR_R3F_DEBUG_VELOCITY4";
      };
   case CONST_R3F_DEBUG_VELOCITY8:
      {
         _result = localize "STR_R3F_DEBUG_VELOCITY8";
      };
   case CONST_R3F_DEBUG_VELOCITY16:
      {   
         _result = localize "STR_R3F_DEBUG_VELOCITY16";
      };
   case CONST_R3F_DEBUG_VELOCITY32: 
      {
         _result = localize "STR_R3F_DEBUG_VELOCITY32";
      };
   };
   
   _result;
};



// Fonction interne, ne pas appeler.
FNCT_R3F_DEBUG_UpdateVelocity =
{
	private ["_playerPosition",
			"_lastPlayerPosition",
			"_playerDirection",
			"_newPlayerPosition"];

	while { true } do
	{
		VAR_R3F_VelocityRunning = true;
		_lastPlayerPosition = getPos player;
		sleep 0.05;
		if(VAR_R3F_DEBUG_Velocity>1) then {
			_playerPosition = getPos player;
          
			// calcul du vecteur direction parcouru
			// on multiplie sa longueur par le coeficient multiplicateur de déplacement en cours.
			_playerDirection = [ ((_playerPosition select 0) - (_lastPlayerPosition select 0)) * VAR_R3F_DEBUG_Velocity,
								((_playerPosition select 1) - (_lastPlayerPosition select 1)) * VAR_R3F_DEBUG_Velocity];
    
			// on effectue le setPos que si necessaire sinon on a des risque de blocage du personnage.
			if (((_playerDirection select 0) != 0) and
				((_playerDirection select 1) != 0)) then
			{
				_newPlayerPosition = [ (_playerPosition select 0) + (_playerDirection select 0),
									(_playerPosition select 1) + (_playerDirection select 1) ];
             
				// on choisi le z de la destination pour coller au sol.
				player setPos [_newPlayerPosition select 0, _newPlayerPosition select 1, 0];
				
			};
		};
	};
	true;
};

FNCT_R3F_DEBUG_UpdateVelocity2 =
{
	private ["_playerPosition",
			"_lastPlayerPosition",
			"_playerDirection",
			"_newPlayerPosition"];

		VAR_R3F_VelocityRunning = true;

		_playerPosition = getPos vehicle player;
		_dir = getdir vehicle player;
		_x = (_playerPosition select 0);
		_y = (_playerPosition select 1);
		
		_x = _x + (cos (90 - _dir)) * VAR_R3F_DEBUG_SetVelocity;
		_y = _y + (sin (90 - _dir)) * VAR_R3F_DEBUG_SetVelocity;
		
		vehicle player setPos [_x, _y, _playerPosition select 2];
	true;
};



// Fonction cliente.
FNCT_R3F_DEBUG_SetVelocity =
{
	if ((count _this)>0) then{
		VAR_R3F_DEBUG_Velocity = _this select 0;
	}else{
		VAR_R3F_DEBUG_Velocity = R3F_DEBUG_VELOCITY1;
	};
	if (!VAR_R3F_VelocityRunning) then {
		[] spawn FNCT_R3F_DEBUG_UpdateVelocity;
	};
	VAR_R3F_DEBUG_Velocity;
};

