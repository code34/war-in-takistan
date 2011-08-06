/****************************************************************************
Copyright (C) 2010 Team ~R3F~
This program is free software under the terms of the GNU General Public License version 3.
You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
@authors team-r3f.org
@version 0.01
@date 20101003
*****************************************************************************/
/*-----------------------------------------------------------------------------
Description :
Show the main panel (commands panel)

Call by :
[] call R3F_DEBUG_fnc_ShowMainPanel;
------------------------------------------------------------------------------*/
/*-----------------------------------------------------------------------------
Description :
Montrer le panneaux principal (panneau de commandes)

Appel par :
[] call R3F_DEBUG_fnc_ShowMainPanel;
------------------------------------------------------------------------------*/

R3F_DEBUG_fnc_ShowMainPanel ={
	VAR_R3F_DEBUG_ShowDlg = true;
	[VAR_R3F_DEBUG_ShowDlg] call FNCT_R3F_DEBUG_ShowMainDlg;
	true;
};
