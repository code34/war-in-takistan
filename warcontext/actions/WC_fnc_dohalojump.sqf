	// -----------------------------------------------
	// Author: code34 nicolas_boiteux@yahoo.fr
	// warcontext - call halo jump 

	private [
		"_position"
	];

	_position = position player;

	wcgarbage = [localize "STR_WC_MENUHALOJUMP", localize "STR_WC_MESSAGECLICKHALOJUMP", localize "STR_WC_MESSAGEHALOJUMPINFORMATION", 10] spawn WC_fnc_playerhint;

	openMap [true, false];

	wchalojumppos = [];

	onMapSingleClick "titleText ['','BLACK IN', 10]; wchalojumppos = _pos; onMapSingleClick''; openMap [false, false];";

	while { (visibleMap) } do {
		sleep 0.5;
	};

	if(count wchalojumppos == 0) then {
		onMapSingleClick'';
		wcgarbage = [localize "STR_WC_MENUHALOJUMP", localize "STR_WC_MESSAGEHALOJUMPNEWONE", localize "STR_WC_MESSAGECANCELHALOJUMPINFORMATION", 10] spawn WC_fnc_playerhint;
	} else {

		_position = [(wchalojumppos select 0), (wchalojumppos select 1), 250];
		_positionplayer = position player;
		wcgarbage = [_position, _positionplayer] spawn {
			private ["_position", "_para"];
			_position = _this select 0;
			_positionplayer = _this select 1;
			{	
				if((!isplayer _x) and (_x distance _positionplayer < 50)) then {
					_para = "ParachuteC" createVehicle _position;
					_para setpos _position;
					_para setdir (getdir player);
					_para setvelocity [random 30, random 30, 10];
					_x moveindriver _para;
					_para lock false;
					sleep 1;
				};
			}foreach (units(group player));
		};

		player setpos [(wchalojumppos select 0), (wchalojumppos select 1), 1000];
		player switchmove "HaloFreeFall_non";
		wcgarbage = [player, 1000] spawn bis_fnc_halo;
		wcgarbage = [player] spawn WC_fnc_altimeter;
	};