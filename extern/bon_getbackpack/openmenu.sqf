if(typename _this == "ARRAY") then{
	if(count _this > 1) then { //probably called from an action
		bon_backpack_caller = _this select 1;
	} else {bon_backpack_caller = player};
} else {
	bon_presets_caller = player;
};


createDialog "getBackpackDialog";

WaitUntil{not dialog};

bon_backpack_caller = nil;