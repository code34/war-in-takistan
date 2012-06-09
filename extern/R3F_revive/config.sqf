/**
 * Configuration file - English and french translated
 * Fichier de configuration - Traduit en anglais et en français
 */

/**
 * Language selection ("en" for english, "fr" for french, other if you create your own "XX_strings_lang.sqf")
 * Sélection de la langue ("en" pour anglais, "fr" pour français, autre si vous créez votre propre "XX_strings_lang.sqf")
 */
R3F_REV_CFG_langage = "en";

/**
 * Maximal number of revive for a player
 * Nombre maximal de réanimations par joueur
 */
R3F_REV_CFG_nb_reanimations = 6;

/**
 * True to permits the player to respawn at the "respawn_xxx" marker
 * when he has no more revive credits or if there is no medic to revive
 * 
 * Vrai pour que le joueur puisse réapparaitre sur le marqueur "respawn_xxx"
 * lorsqu'il a épuisé ses réanimations ou bien que personne ne peut le réanimer
 */
R3F_REV_CFG_autoriser_reapparaitre_camp = true;

/**
 * True to allow the player who is out of the game (no more revive credits and respawn at camp forbidden) to view the game in camera mode
 * Vrai pour autoriser un joueur hors jeu (plus de réanimation possible et retour au camp non autorisé) à suivre la partie en mode caméra
 */
R3F_REV_CFG_autoriser_camera = true;

/**
 * True to show markers where players are waiting for revive
 * Vrai pour montrer les marqueurs où des joueurs sont en attente de réanimation
 */
R3F_REV_CFG_afficher_marqueur = true;
