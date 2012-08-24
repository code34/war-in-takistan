	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext - create a new date after currently date

	private [
		"_year",
		"_month",
		"_day",
		"_hour",
		"_minute"	
	];

	_year = (date select 0);
	_month = (date select 1);
	_day = (date select 2);
	_hour = floor(random 23);
	_minute = floor(random 59);

	if(_hour < (date select 3)) then { 
		if(_day < 31) then {
			_day = (date select 2) + 1;
		} else {
			_day = 1;
			_month = _month + 1;
		};
	} else {
		_day = (date select 2);
	};

	_time = [_year, _month, _day, _hour, _minute];

	_time;