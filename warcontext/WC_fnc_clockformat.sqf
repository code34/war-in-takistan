	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext -  clock format
	// -----------------------------------------------

	private ["_hour", "_minute"];

	_hour = _this select 0;
	_minute = _this select 1;

	if(_hour < 10) then { _hour = format ["0%1", _hour];} else {_hour = format["%1", _hour];};
	if(_minute < 10) then { _minute = format ["0%1", _minute];} else {_minute = format["%1", _minute];};
	_clock = format["%1:%2", _hour, _minute];

	_clock;