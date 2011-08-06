	// -----------------------------------------------
	// Author: =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// warcontext - create a trench behind player
	// -----------------------------------------------

	 private [
		"_trench", 
		"_mydir", 
		"_position", 
		"_player"
	];

	_player = _this select 1;
	_mydir = getdir _player;

	_position =  [(getposatl _player select 0) + (sin _mydir * 2), (getposatl _player select 1) + (cos _mydir * 2), (getposatl _player) select 2];

	if (((position player) distance (getmarkerpos "respawn_west")) < 300) exitwith { 
		[localize "STR_WC_MESSAGEDIGATRENCH", localize "STR_WC_MESSAGETRYTOMOVEOUT", localize "STR_WC_MESSAGECANDIG", 10] spawn WC_fnc_playerhint;
	};


	player playMove "AinvPknlMstpSlayWrflDnon_medic";
	sleep 10;
	if !(alive player) exitwith {};

	_trench = "Fort_envelopeBig" createVehicle _position;
	_trench setposatl _position;
	_trench setdir _mydir;

	true;
