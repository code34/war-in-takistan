﻿/*******************************************************************************************
 Copyright (C) 2010 Team ~R3F~

 This program is free software under the terms of the GNU General Public License version 3.
 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.

@authors team-r3f.org
@version 0.01
@date 20100528
********************************************************************************************/

FNCT_R3F_DEBUG_ShowMap = {
	VAR_R3F_DEBUG_MapMode = _this select 0;

	_ok = createDialog "R3F_DEBUG_DLG_ShowMap";
	waitUntil { !dialog };
	
};
