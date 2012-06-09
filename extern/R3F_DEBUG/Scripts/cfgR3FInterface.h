/*******************************************************************************

 Copyright (C) 2010 Team ~R3F~

 This program is free software under the terms of the GNU General Public License version 3.
 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.

@authors team-r3f.org
@version 0.01
@date 20101003

*******************************************************************************/
class R3F_DEBUG
{
	class Supervision
	{
		class SetSkill
		{
			description = "[EN]\nSet skill level of IA\n\n[FR]\nRégler le niveau de difficulté des IA";
			file = "extern\R3F_debug\Scripts\FNC_IF_SetSkill.sqf";
		};
		class GodSight
		{
			description = "[EN]\nGod sight. Destroy and/or kill all that you look\n\n[FR]\nVue divine. Tuer et détruire tout ce qui est regardé";
			file = "extern\R3F_debug\Scripts\FNC_IF_GodSight.sqf";
		};
		class InactiveIA
		{
			description = "[EN]\nInactive or active all IA.\n\n[FR]\nDésactiver ou activer tous les IA";
			file = "extern\R3F_debug\Scripts\FNC_IF_InactiveIA.sqf";
		};
		class NeutralPlayer
		{
			description = "[EN]\nNeutral player, nobody will shoot him.\n\n[FR]\nLe joueur est neutre, personne le lui tire dessus";
			file = "extern\R3F_debug\Scripts\FNC_IF_SetNeutralPlayer.sqf";
		};
		class SetInvulnarability
		{
			description = "[EN]\nThe player is invulnerable ou not.\n\n[FR]\nLe joueur est invulnerable ou pas";
			file = "extern\R3F_debug\Scripts\FNC_IF_SetInvulnerability.sqf";
		};
		class GoFaster
		{
			description = "[EN]\nThe player will move faster and faster as the chosen level.\n\n[FR]\nLe joueur se déplacera de plus en plus vite selon le niveau choisi";
			file = "extern\R3F_debug\Scripts\FNC_IF_GoFaster.sqf";
		};
		class InfiniteAmmo
		{
			description = "[EN]\nThe ammo are infinite or not.\n\n[FR]\nMunitions infines, ou pas";
			file = "extern\R3F_debug\Scripts\FNC_IF_InfiniteAmmo.sqf";
		};
		class ShowAllIA
		{
			description = "[EN]\nShow All IA on the map\n\n[FR]\nAfficher tous les IA sur la carte";
			file = "extern\R3F_debug\Scripts\FNC_IF_ShowAllIA.sqf";
		};
		class HideAllIA
		{
			description = "[EN]\nHide All IA on the map\n\n[FR]\ncacher tous les IA sur la carte";
			file = "extern\R3F_debug\Scripts\FNC_IF_HideAllIA.sqf";
		};
		class KillThemAll
		{
			description = "[EN]\nKill them all !!!. Kill all IA on the mission\n\n[FR]\nTuez les tous !!!, Tuez tous les IA de la mission";
			file = "extern\R3F_debug\Scripts\FNC_IF_KillThemAll.sqf";
		};
	};
	class Display
	{
		class ShowAllPanels
		{
			description = "[EN]\nShow the two main panels\n\n[FR]\nMonter les deux panneaux principaux";
			file = "extern\R3F_debug\Scripts\FNC_IF_ShowAllPanels.sqf";
		};
		class HideAllPanels
		{
			description = "[EN]\nHide the two main panels\n\n[FR]\nFermer les deux panneaux principaux";
			file = "extern\R3F_debug\Scripts\FNC_IF_HideAllPanels.sqf";
		};
		class ShowMainPanel
		{
			description = "[EN]\nShow the main panel\n\n[FR]\nMontrer le panneau principal";
			file = "extern\R3F_debug\Scripts\FNC_IF_ShowMainDlg.sqf";
		};
		class HideMainPanel
		{
			description = "[EN]\nHide the main panel\n\n[FR]\nFermer le panneau principal";
			file = "extern\R3F_debug\Scripts\FNC_IF_HideMainDlg.sqf";
		};
		class ShowSpyPanel
		{
			description = "[EN]\nShow the variables spy panel\n\n[FR]\nAfficher l'espion des variables";
			file = "extern\R3F_debug\Scripts\FNC_IF_ShowWatcher.sqf";
		};
		class HideSpyPanel
		{
			description = "[EN]\nHide the variables spy panel\n\n[FR]\nFermer l'espion des variables";
			file = "extern\R3F_debug\Scripts\FNC_IF_HideWatcher.sqf";
		};
	};
	class Scripting
	{
		class ShowDlgScript
		{
			description = "[EN]\nShow the dialog script editor\n\n[FR]\nMonter la fenêtre d'édition de script";
			file = "extern\R3F_debug\Scripts\FNC_IF_ShowDlgScript.sqf";
		};
		class VarSpyAdd
		{
			description = "[EN]\nAdd a variable to the watcher\n\n[FR]\nAjouter une variable à surveiller";
			file = "extern\R3F_debug\Scripts\FNC_IF_VarSpyAdd.sqf";
		};
		class VarSpyDel
		{
			description = "[EN]\nDelete a variable from the watcher\n\n[FR]\nRetire une variable de la liste à surveiller";
			file = "extern\R3F_debug\Scripts\FNC_IF_VarSpyDel.sqf";
		};
	};
};
