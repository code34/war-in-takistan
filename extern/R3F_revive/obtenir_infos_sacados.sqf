	/**
	 * Obtenir le contenu d'un sac à dos dans un tableau au format spécifique
	 * 
	 * @param 0 l'unité pour laquelle consulter le sac à dos
	 * 
	 * @return les informations du sac à dos au format suivant :
	 *     si l'unité n'a pas de sac à dos : [], sinon
	 *     [
	 *         "nom de classe du sac à dos",
	 *         [liste des armes, quantité associées à chaque arme],
	 *         [liste des chargeurs, quantité associées à chaque chargeur]
	 *     ]
	 * 
	 * Copyright (C) 2010 madbull ~R3F~
	 * 
	 * This program is free software under the terms of the GNU General Public License version 3.
	 * You should have received a copy of the GNU General Public License
	 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
	 */
	
	private ["_result", "_backpack"];
	
	_backpack = unitBackpack (_this select 0);	
	if (isNull _backpack) then {
		_result = [];
	} else {
		_result = [typeOf _backpack, getWeaponCargo _backpack, getMagazineCargo _backpack];
	};
	
	_result;