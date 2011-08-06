/*******************************************************************************************
 Copyright (C) 2010 Team ~R3F~

 This program is free software under the terms of the GNU General Public License version 3.
 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.


@authors team-r3f.org
@version 0.01
@date 20100422
@comment : d'apres betep@team-r3f.org

@function void FNCT_R3F_DEBUG_DoCamera
@params1 (Array) la position de la caméra
@return (void)
********************************************************************************************/

FNCT_R3F_DEBUG_DoCamera = {
	private ["_cam","_pos"];
	if((count _this) > 0) then {
		_pos = _this select 0;
	}else{
		_pos = getPos player;
	};
	VAR_R3F_DEBUG_InCamera = true;
	_cam = "Logic" createVehicleLocal _pos;
	_cam setPos [(_pos select 0), (_pos select 1), (_pos select 2) + 30];
	_cam exec "camera.sqs";
	enableEnvironment true;
	titleCut ["", "BLACK OUT"]; 
	titleFadeOut 6;
	titleText [localize "STR_R3F_DEBUG_INFO_CAMERA", "PLAIN DOWN"];
	titleFadeOut 6;
	cutText ["", "BLACK IN"];
	titleFadeOut 6;
	waitUntil {isNull BIS_DEBUG_CAM};
	deleteVehicle _cam;
	VAR_R3F_DEBUG_InCamera = false;
};