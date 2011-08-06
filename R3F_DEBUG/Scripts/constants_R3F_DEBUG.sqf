/*******************************************************************************************
 Copyright (C) 2010 Team ~R3F~

 This program is free software under the terms of the GNU General Public License version 3.
 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.

@authors team-r3f.org
@version 0.03
@date 20100506
********************************************************************************************/

#define CONST_R3F_DEBUG_DEFAULT_RADIUS	1000
#define CONST_R3F_DEBUG_DEFAUT_VEHICLE	"HMMWV"

#define CONST_R3F_DEBUG_VELOCITY1    	1
#define CONST_R3F_DEBUG_VELOCITY2    	2
#define CONST_R3F_DEBUG_VELOCITY4    	4
#define CONST_R3F_DEBUG_VELOCITY8    	8
#define CONST_R3F_DEBUG_VELOCITY16    	16
#define CONST_R3F_DEBUG_VELOCITY32    	32

#define CONST_R3F_DEBUG_INFINITEAMMO_ON		true
#define CONST_R3F_DEBUG_INFINITEAMMO_OFF	false

#define CONST_R3F_DEBUG_NEUTRALITY_ON		true
#define CONST_R3F_DEBUG_NEUTRALITY_OFF		false

#define CONST_R3F_DEBUG_INACTIVEIA			false
#define CONST_R3F_DEBUG_ACTIVEIA			true
#define CONST_R3F_DEBUG_MAXMAPRADIUS		20000
#define CONST_R3F_DEBUG_DEFAULT_AIBEHAVIOUR		["TARGET","AUTOTARGET","MOVE","ANIM"]
#define CONST_R3F_DEBUG_DEFAULT_FINDCLASSTYPE	["Man","Land","Air"]

#define CONST_R3F_DEBUG_GODSIGHT_ON		true
#define CONST_R3F_DEBUG_GODSIGHT_OFF	false

#define CONST_R3F_DEBUG_SKILL_POOR			0.1
#define CONST_R3F_DEBUG_SKILL_NORMAL		0.5
#define CONST_R3F_DEBUG_SKILL_GOOD			1

#define CONST_R3F_DEBUG_MAX_LOG_LINES	100

#define CONST_R3F_DEBUG_SHOW_IA true
#define CONST_R3F_DEBUG_HIDE_IA false

#define CONST_R3F_DEBUG_MAP4TELEPORT	1
#define CONST_R3F_DEBUG_MAP4CAMERA		2

#define r3f_log(message) [message,true] call FNCT_R3F_DEBUG_Diag_Log;
