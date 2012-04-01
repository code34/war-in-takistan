	// -----------------------------------------------
	// Author: =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// warcontext -  Client Side logic
	// -----------------------------------------------

	private ["_hour", "_minute", "_currenthour", "_currentminute", "_done", "_original", "_cible", "_cibleclockformat"];

	_hour = wcdate select 3;
	_minute = wcdate select 4;
	_done = false;
	_cibleclockformat = [_hour, _minute] call WC_fnc_clockformat;

	waituntil {vehicle player == player};
	waituntil {isnull wccam};
	wccam = player;

	wcadvancetodate = wcdate;

	setviewdistance 1500;
	wccameffect = PPEffectCreate ["ColorCorrections", 1999];
	wccameffect PPEffectEnable true;
	wccameffect PPEffectAdjust [0.5, 0.7, 0.0, [1.0, 1.0, 1.0, 0.0], [1.0, 1.0, 1.0, 0.0], [1.0, 1.0, 1.0, 1.0]];
	wccameffect PPEffectCommit 0;

	_original = dateToNumber date;
	_cible = dateToNumber wcdate;

	if((_cible - _original < 0.000015) or (_original - _cible > 0.000001)) then {
		setdate wcdate;
		_done = true;
		_currenthour = date select 3;
		_currentminute = date select 4;
		_clock = [_currenthour, _currentminute] call WC_fnc_clockformat;
	};

	while {!_done} do {
		_currenthour = date select 3;
		_currentminute = date select 4;
		_clock = [_currenthour, _currentminute] call WC_fnc_clockformat;
		if!(_hour == _currenthour) then {
			skiptime 0.009;
		}else{
			setdate wcdate;
			_done = true;
			_currenthour = date select 3;
			_currentminute = date select 4;
			_clock = [_currenthour, _currentminute] call WC_fnc_clockformat;
		};
		hintsilent format["Fast time: %1 -> %2 \nPress Tab key to skip fast time", _clock, _cibleclockformat];
		sleep 0.0005;
	}; 

	ppEffectDestroy wccameffect;
	setviewdistance wcviewDist;
	wccam = objNull;
	wcadvancetodate = nil;