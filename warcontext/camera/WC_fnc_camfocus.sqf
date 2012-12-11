	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext - camera focus on object - mission text

	private [
		"_alt",
		"_obj",
		"_object", 
		"_objective", 
		"_newx", 
		"_newy", 
		"_x", 
		"_y", 
		"_xsign",
		"_ysign",
		"_sleep",
		"_missiontext",
		"_distance",
		"_exit",
		"_size"
	];

	_object = _this select 0;
	_size = round(sizeof (typeof  _object));

	_exit 	= false;

	waituntil {isnull wccam};

	#ifdef _MISSIONVOIDS_
		_sound = format["missionvoid%1", wcobjective select 2];
		playsound _sound;
	#else
		_music = wcjukebox call BIS_fnc_selectRandom;
		playMusic _music;
	#endif

	switch (wcwithcam) do {
		case 1:{
			_exit = true;			
		};

		case 2: {
			_distance = 10;
		};
		
		case 3: {
			_distance = 100;
		};

		case 4: {
			_distance = 100;
		};
	};

	if(_exit) exitwith {};

	if!(wccamgoalwithcolor) then {
		wccameffect = PPEffectCreate ["ColorCorrections", 1999];
		wccameffect PPEffectEnable true;
		wccameffect PPEffectAdjust [0.5, 0.7, 0.0, [1.0, 1.0, 1.0, 0.0], [1.0, 1.0, 1.0, 0.0], [1.0, 1.0, 1.0, 1.0]];
		wccameffect PPEffectCommit 0;
	};

	_sleep = 0;

	if (isnil "_object") then {
		_object = anim;
		_missiontext = [localize "STR_WC_MESSAGEMISSIONCOMMANDEMENT", localize "STR_WC_MESSAGNEXTSTEP"];
	} else {
		_missiontext = wcobjective select 4;
	};

	if (!alive _object) then {
		_object = anim;
		_missiontext = [localize "STR_WC_MESSAGEMISSIONCOMMANDEMENT", localize "STR_WC_MESSAGNEXTSTEP"];
	};

	waituntil {isnull wccam};
	waituntil {preloadCamera position _object};

	wccam = "camera" camCreate [0,0,1000];
	wccam cameraEffect ["internal","back"];
	ShowCinemaBorder true;

	switch (wcwithcam) do {
		case 1:{
			_exit = true;			
		};

		case 2: {
			wccam camsettarget _object;
			_object setCameraInterest 50;
			wccam camsetrelpos [-2, -2, 2];
			wccam CamCommit 0;
			_distance = 10;
		};
		
		case 3: {
			wccam camsettarget _object;
			_object setCameraInterest 50;
			wccam camsetrelpos [-50, -50, 15];
			wccam CamCommit 0;
			_distance = 200;
		};

		case 4: {
			wccam camsettarget _object;
			_object setCameraInterest 50;
			wccam camsetrelpos [-2, -2, 500];
			wccam CamCommit 0;
			_distance = 200;
		};
	};

	"FilmGrain" ppEffectEnable true;

	// print mission text
	wcgarbage = _missiontext spawn EXT_fnc_infotext;

	while { (format["%1", wcanim] != "" and _sleep < 60)} do {

		_x = 2 + random _distance + _size;
		_y = 2 + random _distance + _size;
		if(random 1 > 0.5) then { _xsign = 1; } else { _xsign = -1;};
		if(random 1 > 0.5) then { _ysign = 1; } else { _ysign = -1;};	

		if(_distance == 10) then { 
			_alt = (1 + (random 2) + ((getposatl _object) select 2));
		}else{
			_alt = 2 + (random 20);
		};
		if(wcwithcam == 4) then {
			_alt = 300 + random(200);
		};

		_newx = ((getpos _object) select 0) + (_x * _xsign);
		_newy = ((getpos _object) select 1) + (_y * _ysign);

		if(!wccamgoalanimate) then {
			wccam camsetpos [_newx,_newy, _alt];
			wccam CamCommit 0;			
		} else {
			wccam camsetrelpos [(_x * _xsign), (_y * _ysign), (_alt)];
			wccam CamCommit 10;
		};

		"FilmGrain" ppEffectAdjust[random 0.2, 5, 3.42, 10, 8.5, false];
		"FilmGrain" ppEffectCommit 0; 
		sleep 5;
		"FilmGrain" ppEffectAdjust[1, 1, 3.42, 10, 8.5, false]; 
		"FilmGrain" ppEffectCommit 0.2;
		sleep random 0.2;
		_sleep = _sleep + 5;
	};
	"FilmGrain" ppEffectEnable false;

	ppEffectDestroy wccameffect;
	wccam cameraEffect ["terminate","back"];
	camDestroy wccam;
	wccam = objNull;
	camUseNVG false;