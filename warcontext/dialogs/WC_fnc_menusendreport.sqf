	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr, Xeno - domination
	// warcontext - create a mission info dialog box
	// locality : client side

	disableSerialization;

	WC_fnc_transfert = {
		private["_point", "_index", "_friend", "_me", "_player"];
		_point = ceil(sliderPosition 16005);
		if(_point > 0) then {
			_index = lbCurSel 16006;
			_friend = lbData [16006,_index];
			// only a trick to retrieve the player object refering to _friend
			{
				if(side _x == west) then {
					if(name _x == _friend) then {
						_me = name player;
						wcteamplayaddscore = [_friend, _me, _point];
						wcplayeraddscore = [_x, _point];
						["wcteamplayaddscore", "client"] call WC_fnc_publicvariable;
						["wcplayeraddscore", "server"] call WC_fnc_publicvariable;
						wcteamplayscore = wcteamplayscore - _point;
						if(wcteamplayscore < 0) then {
							wcteamplayscore = 0;
						};
					};
				};
			}foreach allunits;
		};
	};
	
	playsound "paper";

	lbClear 16006;
	_count = 0;
	{
		if((isplayer _x) and (name _x != name player)) then {
			_name = name _x;
			_index = lbAdd[16006,Format ["[%1] %2",_count, _name]];
			lbSetData[16006,_index,_name];
			lbSetValue[16006,_index, (_count - 1)];
			_count = _count + 1;
		};
	} forEach allunits;

	if(_count == 0) then {
		_name = name player;
		_index = lbAdd[16006,Format ["[%1] %2",_count, _name]];
		lbSetData[16006,_index,_name];
		lbSetValue[16006,_index, (_count - 1)];
	};

	lbSetCurSel[16006,0];

	while {dialog} do {
		slidersetrange[16005,0, wcteamplayscore];
		ctrlSetText [16004, format[localize "STR_WC_POINTSTOTRANSFERT", ceil(sliderPosition 16005), wcteamplayscore]];
		sleep 0.05;
	};
