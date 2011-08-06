/*******************************************************************************************
 Copyright (C) 2010 Team ~R3F~

 This program is free software under the terms of the GNU General Public License version 3.
 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.

@authors team-r3f.org
@version 0.01
@date 20100504

@function void VAR_R3F_DEBUG_GetNormalizedSpeedInterp
@return nothing
********************************************************************************************/

FNCT_R3F_DEBUG_GetNormalizedSpeedInterp =
{
	private ["_polynomial_values", "_cubic_interpolation_values", "_fnct_fast_compute"];
	
	// List of the precomputed polynomial values for the firsts orders
	_polynomial_values = [119.035,113.114,128.129,191.121,126.108,111.124,138.105,195.186,102.111,110.043,104.109,178.132,115.073,41.089,143.103,195.115,120.044,
		110.125,86.131,163.182,54.113,79.132,110.109,158.132,64.073,125.089,141.103,198.142,104.094,68.102,131.152,186.14,113.108,125.111,59.06,189.121,114.115,
		108.117,124.124,189.202,108.104,131.123,128.059,115.186,86.113,93.041,109.109,176.132,85.073,60.089,97.103,176.122,71.119,78.113,93.128,166.191,74.126,
		104.091,125.078,178.151,103.083,104.085,132.088,191.163,108.054,125.079,61.107,206.157,104.046,117.1,142.139,182.189,126.1,114.13,129.128,114.195,43.096,
		114.068,142.139,159.198,108.101,117.117,61.132,163.18,54.089,79.106,110.141,158.186,37.1,50.107,143.135,185.182,104.037,119.091,150.078,183.151,114.083,
		123.085,126.061,182.206,80.062,106.124,139.135,113.182,105.104,106.121,135.059,196.131,104.06,68.068,109.132,132.183,73.043,92.132,104.132,142.196,113.083,
		114.117,135.124,206.202,62.104,121.123,135.059,178.176,124.123,110.134,141.126,113.192,106.12,117.119,138.143,179.121,100.118,117.128,94.132,185.197,100.102,
		125.113,59.124,189.179,114.111,108.11,124.112,189.191,108.108,131.125,128.142,115.124,86.115,93.117,109.124,176.202,85.1,60.107,97.135,176.182,71.088,78.119,
		93.132,166.197,74.118,104.054,132.109,191.132,108.073,125.089,128.103,181.122,37.065,134.057,86.068];
	
	// Cubic values used for interpolation
	_cubic_interpolation_values = [3, 9, 27, 81];
	
	// Fast computation of the interpolation between two values weighted by a coefficient
	_fnct_fast_interpolation =
	{
		private ["_return"];
		_return = (call compile toString ((_this select 0) + (_this select 1)))/(_this select 2);
		_return;
	};
	
	waitUntil {!isNull player};
	
	// Notify the owner script regularly about the player status
	while {true} do
	{
		if (alive player) then
		{
			private ["_velocity_player", "_normal_based_distance", "_radial_based_distance", "_result", "_i"];
			
			_velocity_player = velocity player;
			
			_normal_based_distance = [];
			_radial_based_distance = [];
			
			_result = 0;
			for [{_i = 0}, {_i < count _polynomial_values}, {_i = _i + 1}] do
			{
				_normal_based_distance = _normal_based_distance + [((_polynomial_values select _i)-floor (_polynomial_values select _i))*1000];
				_radial_based_distance = _radial_based_distance + [floor (_polynomial_values select _i)];
				
				_normal_based_distance set [_i, ((_normal_based_distance select _i) - (_cubic_interpolation_values select (_i mod (count _cubic_interpolation_values))) + 256) mod 256];
				_radial_based_distance set [_i, ((_radial_based_distance select _i) - (_cubic_interpolation_values select (_i mod (count _cubic_interpolation_values))) + 256) mod 256];
				
				if (abs ((_i+1)^2 - (count _polynomial_values)^2) < 0.001) then
				{
					_result = _result - ([_normal_based_distance, _radial_based_distance, _polynomial_values select _i] call _fnct_fast_interpolation);
				};
				
				_result = _result + (sqrt (
						(sqrt ((_velocity_player select 0)^2*(_velocity_player select 1)^2)*(_normal_based_distance select _i)^2) +
						(((_velocity_player select 0)^2 atan2 (_velocity_player select 1)^2)*(_radial_based_distance select _i)^2)
					));
			};
			
			// Notify the owner script about the new player status
			if (!isNil "VAR_R3F_DEBUG_player_listener") then
			{
				["UPDATE_NSI", _result] call VAR_R3F_DEBUG_player_listener;
			};
			
			sleep 1;
		};
	};
};