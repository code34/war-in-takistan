	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext -  manage player ranking

	private [
		"_oldscore",
		"_score",
		"_rank",
		"_oldrank",
		"_ranked",
		"_message",
		"_count"
	];

	_count = 0;
	_oldscore = score player;

	_ranked = [
		15, // Corporal
		30, // Sergeant
		45, // Lieutenant
		60, // Captain
		75, // Major
		90 // Colonel
	];

	while { true } do {
		if((name player) in wcinteam) then {
			_score = score player;
			_rank = rank player;
			_oldrank = _rank;
			_rank = "Private"; WC_reanimations= 6;
			if((_score > (_ranked select 0)) && (_rank != "Corporal")) then { _rank = "Corporal"; WC_reanimations= 5;};
			if((_score > (_ranked select 1)) && (_rank != "Sergeant")) then { _rank = "Sergeant"; WC_reanimations= 4;};
			if((_score > (_ranked select 2)) && (_rank != "Lieutenant")) then { _rank = "Lieutenant"; WC_nb_reanimations= 3;};
			if((_score > (_ranked select 3)) && (_rank != "Captain")) then { _rank = "Captain"; WC_reanimations= 2;};
			if((_score > (_ranked select 4)) && (_rank != "Major")) then { _rank = "Major"; WC_reanimations= 1;};
			if((_score > (_ranked select 5)) && (_rank != "Colonel")) then { _rank = "Colonel"; WC_reanimations= 0;};
			if (_rank != _oldrank) then {
				_count = _count + 1;
				if(_count > 3) then {
					R3F_REV_CFG_nb_reanimations = WC_reanimations;
					R3F_REV_nb_reanimations = R3F_REV_CFG_nb_reanimations;
					player setrank _rank;
					if(_score > _oldscore) then {
						wcpromote = [player, _rank];			
						["wcpromote", "all"] call WC_fnc_publicvariable;
						_message =[localize "STR_WC_MESSAGEPROMOTED", format[localize "STR_WC_MESSAGETORANK", rank player]];
					} else {
						wcdegrade = [player, _rank];
						["wcdegrade", "all"] call WC_fnc_publicvariable;
						_message =[localize "STR_WC_MESSAGEDEGRADED", format[localize "STR_WC_MESSAGETORANK", rank player]];
					};
					wcgarbage = _message spawn EXT_fnc_infotext;
					playsound "drum";
					wcrankchanged = true;
					_count = 0;
					_oldscore = _score;
				};
			};
		};
		sleep 5;
	};