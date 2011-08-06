_presetclass = "Machinegunner East";


// PRESET 1
_presetname = "PKM";


_primaryweapon = "PK";

_secondaryweapon = "";

_items_sidearm = ["NVGoggles","ItemMap","ItemCompass","ItemWatch","ItemRadio","ItemGPS","Binocular_Vector","UZI_SD_EP1"];

_magazines = [["30Rnd_9x19_UZI_SD",8],["100Rnd_762x54_PK",4],["HandGrenade_East",3],["SmokeShell",1]];

_ruckmags = [];

_preset1 = [_presetname,_presetclass,_primaryweapon,_secondaryweapon,_items_sidearm,_magazines,_ruckmags];



// PRESET 2
_presetname = "PKM, belts only";


_primaryweapon = "PK";

_secondaryweapon = "";

_items_sidearm = ["NVGoggles","ItemMap","ItemCompass","ItemWatch","ItemRadio","ItemGPS","Binocular_Vector","UZI_SD_EP1"];

_magazines = [["30Rnd_9x19_UZI_SD",8],["100Rnd_762x54_PK",6]];

_ruckmags = [];

_preset2 = [_presetname,_presetclass,_primaryweapon,_secondaryweapon,_items_sidearm,_magazines,_ruckmags];



// PRESET 3
_presetname = "PKM, Satchel";


_primaryweapon = "PK";

_secondaryweapon = "";

_items_sidearm = ["NVGoggles","ItemMap","ItemCompass","ItemWatch","ItemRadio","ItemGPS","Binocular_Vector","UZI_SD_EP1"];

_magazines = [["30Rnd_9x19_UZI_SD",8],["100Rnd_762x54_PK",3],["HandGrenade_East",3],["SmokeShell",1],["Pipebomb",1]];

_ruckmags = [];

_preset3 = [_presetname,_presetclass,_primaryweapon,_secondaryweapon,_items_sidearm,_magazines,_ruckmags];



// PRESET 4

_presetname = "RPK";


_primaryweapon = "RPK_74";

_secondaryweapon = "";

_items_sidearm = ["NVGoggles","ItemMap","ItemCompass","ItemWatch","ItemRadio","ItemGPS","Binocular_Vector","UZI_SD_EP1"];

_magazines = [["30Rnd_9x19_UZI_SD",8],["HandGrenade_East",1],["SmokeShell",1],["75Rnd_545x39_RPK",5]];
_ruckmags = [];

_preset4 = [_presetname,_presetclass,_primaryweapon,_secondaryweapon,_items_sidearm,_magazines,_ruckmags];



// PRESET 5

_presetname = "RPK, belts only";


_primaryweapon = "RPK_74";

_secondaryweapon = "";

_items_sidearm = ["NVGoggles","ItemMap","ItemCompass","ItemWatch","ItemRadio","ItemGPS","Binocular_Vector","UZI_SD_EP1"];

_magazines = [["30Rnd_9x19_UZI_SD",8],["75Rnd_545x39_RPK",6]];
_ruckmags = [];

_preset5 = [_presetname,_presetclass,_primaryweapon,_secondaryweapon,_items_sidearm,_magazines,_ruckmags];



// PRESET 6
_presetname = "RPK, Satchel";


_primaryweapon = "RPK_74";

_secondaryweapon = "";

_items_sidearm = ["NVGoggles","ItemMap","ItemCompass","ItemWatch","ItemRadio","ItemGPS","Binocular_Vector","UZI_SD_EP1"];

_magazines = [["30Rnd_9x19_UZI_SD",8],["HandGrenade_East",1],["SmokeShell",1],["75Rnd_545x39_RPK",4],["Pipebomb",1]];
_ruckmags = [];

_preset6 = [_presetname,_presetclass,_primaryweapon,_secondaryweapon,_items_sidearm,_magazines,_ruckmags];



presets=presets+[_preset1,_preset2,_preset3,_preset4,_preset5,_preset6];