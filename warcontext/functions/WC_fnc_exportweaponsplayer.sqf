	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// export players weapons & ammo into clipboard

	private [
		"_weapons",
		"_magazines",
		"_text",
		"_newtext"
	];

	_weapons = weapons player;
	_magazines = magazines player;

	_text = format["player name: %1; ", name player];

	
	{
		_newtext = format['player addweapon "%1";', _x];
		_text = _text + _newtext;
	}foreach _weapons;

	{
		_newtext = format['player addmagazine "%1";', _x];
		_text = _text + _newtext;
	}foreach _magazines;

	_text = _text + format["player selectweapon '%1';", primaryweapon player];

	copytoclipboard format["%1",_text];
	hintsilent "Weapons were exported in your clipboard";
