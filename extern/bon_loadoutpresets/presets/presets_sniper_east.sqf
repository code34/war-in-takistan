_presetclass = "Sniper East";




// PRESET 1

_presetname = "KSVK";

_primaryweapon = "ksvk";

_secondaryweapon = "";

_items_sidearm = ["NVGoggles","ItemMap","ItemCompass","ItemWatch","ItemRadio","Laserdesignator","MakarovSD"];

_magazines = [["5Rnd_127x108_KSVK",9],["Laserbatteries",1],["SmokeShellBlue",2],["8Rnd_9x18_Makarov",8]];

_ruckmags = [];

_preset1 = [_presetname,_presetclass,_primaryweapon,_secondaryweapon,_items_sidearm,_magazines,_ruckmags];




// PRESET 2
_presetname = "Dragunov";

_primaryweapon = "SVD";

_secondaryweapon = "US_Patrol_Pack_EP1";

_items_sidearm = ["NVGoggles","ItemMap","ItemCompass","ItemWatch","ItemRadio","Laserdesignator","MakarovSD","ItemGPS"];

_magazines = [["Laserbatteries",1],["SmokeShellBlue",2],["8Rnd_9x18_Makarov",8],["10Rnd_762x54_SVD",9]];

_ruckmags = [["SmokeShell",2],["PipeBomb",1],["10Rnd_762x54_SVD",3],["Laserbatteries",1]];

_preset2 = [_presetname,_presetclass,_primaryweapon,_secondaryweapon,_items_sidearm,_magazines,_ruckmags];


// PRESET 3
_presetname = "Dragunov (camo)";


_primaryweapon = "SVD_des_EP1";

_secondaryweapon = "US_Patrol_Pack_EP1";

_items_sidearm = ["NVGoggles","ItemMap","ItemCompass","ItemWatch","ItemRadio","Laserdesignator","MakarovSD","ItemGPS"];

_magazines = [["Laserbatteries",1],["SmokeShellBlue",2],["8Rnd_9x18_Makarov",8],["10Rnd_762x54_SVD",9]];

_ruckmags = [["SmokeShell",2],["PipeBomb",1],["10Rnd_762x54_SVD",3],["Laserbatteries",1]];

_preset3 = [_presetname,_presetclass,_primaryweapon,_secondaryweapon,_items_sidearm,_magazines,_ruckmags];


// PRESET 4
_presetname = "Dragunov NPSU";


_primaryweapon = "SVD_NSPU_EP1";

_secondaryweapon = "US_Patrol_Pack_EP1";

_items_sidearm = ["NVGoggles","ItemMap","ItemCompass","ItemWatch","ItemRadio","Laserdesignator","MakarovSD","ItemGPS"];

_magazines = [["Laserbatteries",1],["SmokeShellBlue",2],["8Rnd_9x18_Makarov",8],["10Rnd_762x54_SVD",9]];

_ruckmags = [["SmokeShell",2],["PipeBomb",1],["10Rnd_762x54_SVD",3],["Laserbatteries",1]];

_preset4 = [_presetname,_presetclass,_primaryweapon,_secondaryweapon,_items_sidearm,_magazines,_ruckmags];






if(typeOf player in tfor_sniper) then
{
	presets = presets + [_preset1,_preset2,_preset3,_preset4];
};