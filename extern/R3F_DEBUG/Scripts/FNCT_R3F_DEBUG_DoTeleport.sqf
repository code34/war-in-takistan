/*******************************************************************************************
 Copyright (C) 2010 Team ~R3F~

 This program is free software under the terms of the GNU General Public License version 3.
 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.


@authors team-r3f.org
@version 0.01
@date 20100418

@function void FNCT_R3F_DEBUG_DoTeleport
@param1 (array) Destination position
@return void
********************************************************************************************/

FNCT_R3F_DEBUG_DoTeleport = {
     vehicle player setPos (_this select 0);
};