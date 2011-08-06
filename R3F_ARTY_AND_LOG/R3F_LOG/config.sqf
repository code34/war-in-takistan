/**
 * English and French comments
 * Commentaires anglais et français
 * 
 * This file contains the configuration variables of the logistics system.
 * Fichier contenant les variables de configuration du système de logistique.
 * 
 * Important note : All the classes names which inherits from the ones used in configuration variables will be also available.
 * Note importante : Tous les noms de classes dérivant de celles utilisées dans les variables de configuration seront aussi valables.
 */

/*
 * There are two ways to manage new objects with the logistics system. The first is to add these objects in the
 * folowing appropriate lists. The second is to create a new external file in the /addons_config/ directory,
 * according to the same scheme as the existing ones, and to add a #include at the end of this current file.
 * 
 * Deux moyens existent pour gérer de nouveaux objets avec le système logistique. Le premier consiste à ajouter
 * ces objets dans les listes appropriées ci-dessous. Le deuxième est de créer un fichier externe dans le répertoire
 * /addons_config/ selon le même schéma que ceux qui existent déjà, et d'ajouter un #include à la fin de ce présent fichier.
 */

/****** TOW WITH VEHICLE / REMORQUER AVEC VEHICULE ******/

/**
 * List of class names of (ground or air) vehicles which can tow towables objects.
 * Liste des noms de classes des véhicules terrestres pouvant remorquer des objets remorquables.
 */
R3F_LOG_CFG_remorqueurs =
[
	"MtvrReammo_DES_EP1",
	"MTVR",
	"AMT_Dingo2A2_desert",
	"AMT_Dingo2a2_MG_desert",
	"BWMod_LKW5t_Ammo",
	"BWMod_LKW5t_Fuel",
	"BWMod_LKW5t_Repair",
	"BWMod_Fuchs_ISAF",
	"BWMod_Fuchs_Desert",
	"BWMod_Fuchs_ArmoredTurret_Desert",
	"BWMod_Fuchs_ArmoredTurret_ISAF",
	"BWMod_Fuchs_BAT_Desert",
	"BWMod_Fuchs_BAT_ISAF",
	"AMT_Dingo2A2_isaf",
	"AMT_Dingo2a2_MG_Isaf"
];

/**
 * List of class names of towables objects.
 * Liste des noms de classes des objets remorquables.
 */
R3F_LOG_CFG_objets_remorquables =
[
	"StaticCannon",
	"RubberBoat"
];


/****** LIFT WITH VEHICLE / HELIPORTER AVEC VEHICULE ******/

/**
 * List of class names of air vehicles which can lift liftables objects.
 * Liste des noms de classes des véhicules aériens pouvant héliporter des objets héliportables.
 */
R3F_LOG_CFG_heliporteurs =
[
	"CH_47F_EP1"
];

/**
 * List of class names of liftables objects.
 * Liste des noms de classes des objets héliportables.
 */
R3F_LOG_CFG_objets_heliportables =
[
	"HMMWV_M1151_M2_DES_EP1",
	"HMMWV_M998A2_SOV_DES_EP1",
	"HMMWV_M998_crows_MK19_DES_EP1",
	"ATV_US_EP1",
	"LandRover_Special_CZ_EP1"
];


/****** LOAD IN VEHICLE / CHARGER DANS LE VEHICULE ******/

/*
 * This section use a quantification of the volume and/or weight of the objets.
 * The arbitrary referencial used is : an ammo box of type USVehicleBox "weights" 12 units.
 * 
 * Cette section utilise une quantification du volume et/ou poids des objets.
 * Le référentiel arbitraire utilisé est : une caisse de munition de type USVehicleBox "pèse" 12 unités.
 * 
 * Note : the priority of a declaration of capacity to another corresponds to their order in the tables.
 *   For example : the "Truck" class is in the "Car" class (see http://community.bistudio.com/wiki/ArmA_2:_CfgVehicles).
 *   If "Truck" is declared with a capacity of 140 before "Car". And if "Car" is declared after "Truck" with a capacity of 40,
 *   Then all the sub-classes in "Truck" will have a capacity of 140. And all the sub-classes of "Car", excepted the ones
 *   in "Truck", will have a capacity of 40.
 * 
 * Note : la priorité d'une déclaration de capacité sur une autre correspond à leur ordre dans les tableaux.
 *   Par exemple : la classe "Truck" appartient à la classe "Car" (voir http://community.bistudio.com/wiki/ArmA_2:_CfgVehicles).
 *   Si "Truck" est déclaré avec une capacité de 140 avant "Car". Et que "Car" est déclaré après "Truck" avec une capacité de 40,
 *   Alors toutes les sous-classes appartenant à "Truck" auront une capacité de 140. Et toutes les sous-classes appartenant
 *   à "Car", exceptées celles de "Truck", auront une capacité de 40.
 */

/**
 * List of class names of (ground or air) vehicles which can transport transportables objects.
 * The second element of the arrays is the load capacity (in relation with the capacity cost of the objects).
 * 
 * Liste des noms de classes des véhicules (terrestres ou aériens) pouvant transporter des objets transportables.
 * Le deuxième élément des tableaux est la capacité de chargement (en relation avec le coût de capacité des objets).
 */
R3F_LOG_CFG_transporteurs =
[
	["M113_UN_EP1", 16],
	["BAF_Jackal2_L2A1_D", 10],
	["BAF_Jackal2_GMG_D", 10],
	["MH6J_EP1", 6],
	["ArmoredSUV_PMC", 8],
	["ACE_Truck5tMGOpen", 50],
	["ACE_MTVRReammo_DES_EP1", 50],
 	["M2A3_EP1", 10],
	["M2A2_EP1", 10],
	["UH60M_EP1", 15],
	["hilux1_civil_1_open", 10],
	["HMMWV_Base", 12],
	["LandRover_Special_CZ_EP1", 12],
	["SUV_UN_EP1", 12],
	["HMMWV_M998A2_SOV_DES_EP1", 12],
	["M1126_ICV_mk19_EP1", 40],
	["Ikarus", 80],
	["Lada_base", 6],
	["SkodaBase", 6],
	["TowingTractor", 5],
	["tractor", 2],
	["Motorcycle", 1],
	["KamazRefuel", 5],
	["Kamaz_Base", 60],
	["MtvrRefuel", 5],
	["MTVR", 40],
	["GRAD_Base", 2],
	["UralRefuel_Base", 5],
	["Ural_Base", 60],
	["Ural_ZU23_Base", 30],
	["V3S_Civ", 25],
	["UAZ_Base", 10],
	["VWGolf", 6],
	["BRDM2_Base", 25],
	["BTR90_Base", 25],
	["GAZ_Vodnik_HMG", 25],
	["LAV25_Base", 25],
	["AAV", 10],
	["BMP2_Base", 8],
	["BMP3", 8],
	["Mi17_base", 100],
	["Mi24_Base", 40],
	["UH1Y", 15],
	["C130J", 150],
	["MV22", 90],
	["RHIB", 12],
	["RubberBoat", 5],
	["Fishing_Boat", 18],
	["Smallboat_1", 6],
	["BWMod_UH1D", 15],
	["modem_NH90", 45],
	["AMT_Dingo2a2_MG_desert", 15],
	["AMT_Dingo2A2_desert", 15],
	["BWMod_Fuchs_Desert", 25],
	["BWMod_Fuchs_ArmoredTurret_Desert", 25],
	["BWMod_Fuchs_BAT_Desert", 25],
	["BWMod_Marder_1A5_Desert", 25],
	["BWMod_LKW5t_Ammo", 40],
	["AMT_wolf_isaf", 6],
	["AMT_Dingo2A2_isaf", 15],
	["AMT_Dingo2a2_MG_Isaf", 15],
	["BWMod_Fuchs_ISAF", 25],
	["BWMod_Fuchs_ArmoredTurret_ISAF", 25],
	["BWMod_Marder_1A5_ISAF", 25],
	["BWMod_LKW5t_Fuel", 40],
	["BWMod_LKW5t_Repair", 40]
];

/**
 * List of class names of transportables objects.
 * The second element of the arrays is the cost capacity (in relation with the capacity of the vehicles).
 * 
 * Liste des noms de classes des objets transportables.
 * Le deuxième élément des tableaux est le coût de capacité (en relation avec la capacité des véhicules).
 */
R3F_LOG_CFG_objets_transportables =
[
	["SatPhone", 2], // Needed for the R3F_ARTY module (arty HQ) (nécessaire pour le module R3F_ARTY (PC d'arti))
	["StaticAAWeapon", 15],
	["StaticATWeapon", 10],
	["StaticGrenadeLauncher", 5],
	["StaticMGWeapon", 5],
	["StaticMortar", 6],
	["StaticSEARCHLight", 2],
	["TKOrdnanceBox_EP1", 5],
	["Barrels", 6],
	["Wooden_barrels", 6],
	["BarrelBase", 2],
	["Fuel_can", 1],
	["BWMod_AM24", 5],
	["BWMod_AM24_Palette", 10],
	["ACE_JerryCan_Dummy_15", 1]

];

/****** MOVABLE-BY-PLAYER OBJECTS / OBJETS DEPLACABLES PAR LE JOUEUR ******/

/**
 * List of class names of objects moveables by player.
 * Liste des noms de classes des objets transportables par le joueur.
 */
R3F_LOG_CFG_objets_deplacables =
[
	"TKOrdnanceBox_EP1",
	"SatPhone", 
	"BarrelBase",
	"Fuel_can",
	"BWMod_AM24",
	"ACE_JerryCan_Dummy_15"
];

/*
 * List of files adding objects in the arrays of logistics configuration (e.g. R3F_LOG_CFG_remorqueurs)
 * Add an include to the new file here if you want to use the logistics with a new addon.
 * 
 * Liste des fichiers ajoutant des objets dans les tableaux de fonctionnalités logistiques (ex : R3F_LOG_CFG_remorqueurs)
 * Ajoutez une inclusion vers votre nouveau fichier ici si vous souhaitez utilisez la logistique avec un nouvel addon.
 */
// #include "addons_config\ACE_OA_objects.sqf"
// #include "addons_config\BAF_objects.sqf"
// #include "addons_config\arma2_CO_objects.sqf"