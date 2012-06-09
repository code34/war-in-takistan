	//by Bon_Inf* for my 10th mates. Requires ACE2

	if!(local player) exitWith{};
	
	private ['_playername','_weapons','_magazines','_ruckweapons','_ruckmags'];

	bon_presets_caller = _this select 0;
	
	presets = [];
	#include "presets\presets_grenadier_west.sqf"
	#include "presets\presets_machinegunner_west.sqf"
	#include "presets\presets_antitank_west.sqf"
	#include "presets\presets_rifleman_west.sqf"
	#include "presets\presets_sniper_west.sqf"
	
	_presetdlg = createDialog "PresetDialog";