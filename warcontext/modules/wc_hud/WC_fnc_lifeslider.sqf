	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext - a part is modified code from WINSE - Valhalla mission
	// -----------------------------------------------

	if (!local player) exitWith {};

	private [
		"_crew",
		"_text",
		"_vehicle",
		"_role",
		"_name",
		"_rank",
		"_teampromote"
	];
	
	disableSerialization;

	#define WCTEXTW		0.80
	#define WCTEXTY		0.06
	#define WCTEXTHEIGHT	0.50
	#define WCTEXTWIDTH	0.30

	// controlName ctrlSetPosition [x, y, w, h] 
	// SafeZoneX returns the value for the left side of screen.
	// SafeZoneY returns the value for the top of the screen.
	// SafeZoneW returns the whole width of the screen.
	// SafeZoneH returns the whole height of the screen. 

	private ["_ctrl", "_currentdisplay", "_control", "_controlpos", "_lastscore"];

	_lastscore = 0;

	uiNamespace setVariable ['wcdisplay', objnull];

	while {true} do {
		if(isnull (uiNamespace getVariable "wcdisplay")) then { cutrsc ["infomessage", "PLAIN"];};
		if(vehicle player != player) then {
			_text = "";
			_crew = crew (vehicle player);
			_vehicle = vehicle player;
			_name= getText (configFile >> "CfgVehicles" >> (typeOf vehicle player) >> "DisplayName");
			_text= _text + format ["<t size='1.35' shadow='true' color='#AAAAFF'>%1</t><br/>", _name];
			{
				if(!(format["%1", name _x] == "") and !(format["%1", name _x] == "Error: No unit")) then {
					_role = assignedVehicleRole _x;
					switch(_x)do {
						case commander _vehicle: {
							_text=_text+format ["<t size='1.5'><img image='pics\i_commander_ca.paa'></t> <t size='1.35' shadow='true' color='#AAAAFF'>%1</t><br/>", name _x];
						};
							
							
						case gunner _vehicle: {
							_text=_text+format ["<t size='1.5'><img image='pics\i_gunner_ca.paa'></t> <t size='1.35' shadow='true' color='#FF8888'>%1</t><br/>", name _x];
						};
							
							
						case driver _vehicle: {		
							_text=_text+format ["<t size='1.5'><img image='pics\i_driver_ca.paa'></t> <t size='1.35' shadow='true' color='#88FF88'>%1</t><br/>", name _x];
						};
							
					
						default	{
							if(format["%1", (_role select 0)] != "Turret") then {
								_text=_text+format ["<t size='1.5'><img image='pics\i_cargo_ca.paa'></t> <t size='1.35' shadow='true' color='#EEEEEE'>%1</t><br/>", name _x];
							} else {
								_text=_text+format ["<t size='1.5'><img image='pics\i_gunner_ca.paa'></t> <t size='1.35' shadow='true' color='#FF8888'>%1</t><br/>", name _x];
							};
						};
					};
				};
			}forEach _crew;
		} else {
			if(wcrankchanged or wcrankactivate) then {
				if(format["%1", wcanim] == "") then {
					_text = "<t size='1.35' shadow='true' color='#EEEEEE'>Team Rank [""TAB""]<br/></t>";
					{	
							_rank = _x;
							{
								if(!(format["%1", name _x] == "") and !(format["%1", name _x] == "Error: No unit")) then {
									if ((rank _x == "Private") and _rank == "Private") then { 
										_text=_text+format ["<t size='1.5'><img image='\CA\warfare2\Images\rank_private.paa'></t> <t size='1.35' shadow='true' color='#EEEEEE'>%1</t><br/>", name _x];
									};
									if ((rank _x == "Corporal") and _rank == "Corporal") then { 
										_text=_text+format ["<t size='1.5'><img image='\CA\warfare2\Images\rank_corporal.paa'></t> <t size='1.35' shadow='true' color='#EEEEEE'>%1</t><br/>", name _x];
									};
									if ((rank _x == "Sergeant")  and _rank == "Sergeant") then { 
										_text=_text+format ["<t size='1.5'><img image='\CA\warfare2\Images\rank_sergeant.paa'></t> <t size='1.35' shadow='true' color='#EEEEEE'>%1</t><br/>", name _x];
									};
									if ((rank _x == "Lieutenant") and _rank == "Lieutenant") then { 
										_text=_text+format ["<t size='1.5'><img image='\CA\warfare2\Images\rank_lieutenant.paa'></t> <t size='1.35' shadow='true' color='#EEEEEE'>%1</t><br/>", name _x];
									};
									if ((rank _x == "Captain") and _rank == "Captain") then { 
										_text=_text+format ["<t size='1.5'><img image='\CA\warfare2\Images\rank_captain.paa'></t> <t size='1.35' shadow='true' color='#EEEEEE'>%1</t><br/>", name _x];
									};
									if ((rank _x == "Major") and _rank == "Major") then { 
										_text=_text+format ["<t size='1.5'><img image='\CA\warfare2\Images\rank_major.paa'></t> <t size='1.35' shadow='true' color='#EEEEEE'>%1</t><br/>", name _x];
									};
									if ((rank _x == "Colonel") and _rank == "Colonel") then { 
										_text=_text+format ["<t size='1.5'><img image='\CA\warfare2\Images\rank_colonel.paa'></t> <t size='1.35' shadow='true' color='#EEEEEE'>%1</t><br/>", name _x];
									};
									sleep 0.001;
								};
							}foreach playableUnits;
					} foreach ["Colonel", "Major", "Captain", "Lieutenant", "Sergeant", "Corporal", "Private"];
					wcrankchanged = false;
				} else {
					_key = format["%1", actionKeysNames ["CancelAction", 2]];
					if(_key == "") then {
						_text = "<t size='1.5'>Press [""TAB""] to pass Video</t><br/><t size='1.5'>Press [""Cancel Action""] to change Music</t>";
					} else {
						_text = format["<t size='1.5'>Press [""TAB""] to pass Video</t><br/><t size='1.5'>Press [%1] to change Music</t>", _key];
					};
				};
			} else {
				_text ="";							
			};
		};
		_ctrl = (uiNamespace getVariable 'wcdisplay') displayCtrl 10101;
		_ctrl ctrlSetStructuredText parseText _text;

		_text = "";
		_ctrl2 = (uiNamespace getVariable 'wcdisplay') displayCtrl 10103;

		_text = _text + format ["Day %1 %2<br/>", wcday];
		if(wcradioalive) then {	
			if(wcalert > 99) then { 
				wcalert = 100;
				_text = _text + format ["<t color='#CC0000'>Detection: %1</t><br/>", format["%1", wcalert] +"%"];
				if!(wcdetected) then {
					if ((getmarkerpos "rescue") distance (position player) < 100) then {
						playsound "alarm1";
					} else {
						if ((getmarkerpos "rescue") distance (position player) < 300) then {
							playsound "alarm2";
						} else {
							if ((getmarkerpos "rescue") distance (position player) < 1000) then {
								playsound "alarm3";
							};
						};
					};
					wcdetected = true;
				};
			} else {
				_text = _text + format ["Detection: %1<br/>", format["%1", (ceil wcalert)] +"%"];
				wcdetected = false;
			};
		} else {
			_text = _text + "Detection: No more radio<br/>";
		};

		_name = currentMagazine player;
		_name = getText (configFile >> "CfgMagazines" >> _name >> "displayNameShort");
		if(_name == "SD") then {
			_text = _text + "Mode: Stealth<br/>";
		} else {
			_text = _text + "Mode: Combat<br/>"
		};

		_text=_text+format ["<t size='0.8'><img image='\CA\warfare2\Images\rank_%1.paa'></t> <t size='1' shadow='true' color='#EEEEEE'>%1</t><br/>", rank player];

		if(wckindofserver != 3) then {
			if((name player) in wcinteam) then {
				_teampromote = localize format["STR_WC_TEAM%1", wcteamlevel];
			} else {
				_teampromote = localize "STR_WC_TEAM0";
			};
			_text = _text + format ["<t size='1.35'>%1 - L%2</t><br/>", _teampromote, wclevel];
			if(wcteamplayscore > 10) then {
				_text = _text + format ["<t color='#CC0000'>%2: %1</t><br/>",  wcteamplayscore, localize "STR_WC_INFOPOINTSTOSHARE"];
			} else {
				_text = _text + format ["%2: %1<br/>", wcteamplayscore, localize "STR_WC_INFOPOINTSTOSHARE"];
			};
		} else {
			_text = _text + format ["No team - Level: %1<br/>", wclevel];
		};

		_ctrl2 ctrlSetStructuredText parseText _text;
		_ctrl ctrlCommit 0;
		_ctrl2 ctrlCommit 0;
		sleep 1;
	};

