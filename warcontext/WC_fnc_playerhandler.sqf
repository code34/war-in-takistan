	// NETCODE
	// Netcode replace addpublicvariableeventhandler by WC eventhandler

	WC_fnc_netcode_wcweather = {
		wcweather = _this select 0;
		600 setRain (wcweather select 0);
		600 setfog (wcweather select 1);
		600 setOvercast (wcweather select 2);
	};

	WC_fnc_netcode_wcdate = {
		wcdate = _this select 0;	
		wcgarbage = [] spawn WC_fnc_fasttime;
	};

	WC_fnc_netcode_wcnewnuclearzone = {
		wcnewnuclearzone = _this select 0;
		wcgarbage = [wcnewnuclearzone] spawn WC_fnc_nuclearnuke;
	};

	WC_fnc_netcode_wcbomb = {
		playsound "bomb";
	};

	WC_fnc_netcode_wciedsound = {
		wciedsound = _this select 0;
		if(wciedsound == name player) then {
			if(vehicle player == player) then {
				playsound "bombdetector";
			};
		};
	};

	WC_fnc_netcode_wcallahsound = {
		wcallahsound = _this select 0;
		if(wcallahsound == name player) then {
			playsound "allah";
		};
	};

	WC_fnc_netcode_wcaddkilled = {
		wcaddkilled = _this select 0;
		if(name wcaddkilled in wcinteam) then {
			_message = format[localize "STR_WC_MESSAGEWASKILLED", name wcaddkilled];
			wcclientlogs = wcclientlogs + [_message];
		};
	};

	WC_fnc_netcode_wctk = {
		wctk = _this select 0;
		hintsilent format[localize "STR_WC_MESSAGEGOTABLAME", wctk];
	};

	WC_fnc_netcode_wcrespawntobase = {
		wcrespawntobase = _this select 0;
		_message =  format[localize "STR_WC_MESSAGERESPAWNTOBASE", wcrespawntobase];
		wcclientlogs = wcclientlogs + [_message];
		hintsilent _message;
	};

	WC_fnc_netcode_wcrespawntotent = {
		wcrespawntotent = _this select 0;
		_message = format[localize "STR_WC_MESSAGERESPAWNTOTENT", wcrespawntotent];
		wcclientlogs = wcclientlogs + [_message];
		hintsilent _message;
	};

	WC_fnc_netcode_wcrespawntohq = {
		wcrespawntohq = _this select 0;
		_message = format[localize "STR_WC_MESSAGERESPAWNTOHQ", wcrespawntohq];
		wcclientlogs = wcclientlogs + [_message];
		hintsilent _message;
	};

	WC_fnc_netcode_wcpromote = {
		wcpromote = _this select 0;
		_name = name (wcpromote select 0);
		_rank = wcpromote select 1;
		(wcpromote select 0) setrank _rank;
		hintsilent format[localize "STR_WC_MESSAGEPLAYERPROMOTED", _name, _rank];
		wcrankchanged = true;
		wcclientlogs = wcclientlogs + ["A soldier got promoted: + 1 point"];
	};

	WC_fnc_netcode_wcdegrade = {
		private  ["_name", "_rank"];
		wcdegrade = _this select 0;
		_name = name (wcdegrade select 0);
		_rank = wcdegrade select 1;
		(wcdegrade select 0) setrank _rank;
		hintsilent format[localize "STR_WC_MESSAGEPLAYERDEGRADED", _name, _rank];
		wcrankchanged = true;
		wcclientlogs = wcclientlogs + [format["%1 got degraded: - 1 point", _name]];
	};

	WC_fnc_netcode_wcranksync = {
		wcranksync = _this select 0;
		{
			(_x select 0) setrank (_x select 1);
		}foreach wcranksync;
	};

	WC_fnc_netcode_wcobjective = {
		wcobjective = _this select 0;
		if ((wcobjective select 0) > wcobjectiveindex) then {
			wcobjectiveindex = wcobjective select 0;
			if(vehicle player == player) then {
			 	wcanim = [(wcobjective select 1)] spawn WC_fnc_camfocus;
			};
		};
	};


	WC_fnc_netcode_wcteamplayaddscore = {
		wcteamplayaddscore = _this select 0;
		if(wckindofserver != 3) then {
			if((wcteamplayaddscore select 0) == name player) then {
				_text = format["%1", (wcteamplayaddscore select 1)];
				_text2 = format["Transfer: %1 points", (wcteamplayaddscore select 2)];
				[_text, _text2] spawn WC_fnc_infotext;
				_message = format["%1 give you : %2 personnal points", (wcteamplayaddscore select 1), (wcteamplayaddscore select 2)];
				wcclientlogs = wcclientlogs + [_message];
			};
		};
	};

	WC_fnc_netcode_wcinteamintegration = {
		wcinteamintegration = _this select 0;
		if(wcinteamintegration == name player) then {
			[localize "STR_WC_MENURECRUITMENT", localize "STR_WC_MENUFOLLOWTHELEADER", localize "STR_WC_MENURECRUITASTEAMMENBER", 10] spawn WC_fnc_playerhint;
			wcclientlogs = wcclientlogs + ["You have been recruited as team member"];
		}; 
	};

	// Recieve points to share
	// More ranked player is, less points he has to distribute
	WC_fnc_netcode_wcteamplayscoretoadd = {
			wcteamplayscoretoadd = _this select 0;
			private ["_rank", "_ratio"];
			if((name player) in wcinteam) then {
				_rank = rank player;
				if(_rank == "Private") then { _ratio = ceil(wcteamplayscoretoadd * 0.4);};
				if(_rank == "Corporal") then { _ratio = ceil(wcteamplayscoretoadd * 0.5);};
				if(_rank == "Sergeant") then { _ratio = ceil(wcteamplayscoretoadd * 0.6);};
				if(_rank == "Lieutenant") then { _ratio = ceil(wcteamplayscoretoadd * 0.7);};
				if(_rank == "Captain") then { _ratio = ceil(wcteamplayscoretoadd * 0.8);};
				if(_rank == "Major") then { _ratio = ceil(wcteamplayscoretoadd * 0.9);};
				if(_rank == "Colonel") then { _ratio = ceil(wcteamplayscoretoadd);};
				wcteamplayscore = wcteamplayscore + _ratio;
			};
			if(wckindofgame == 1) then {
				wcclientlogs = wcclientlogs + ["Mission finished : +5 points teamscore"];
			} else {
				wcclientlogs = wcclientlogs + ["Mission finished : +3 points teamscore"];
			};
	};


	WC_fnc_netcode_wcchoosemission = {
		wcchoosemission = _this select 0;
		if(wcchoosemission) then {
			wcmessageW = [localize "STR_WC_MESSAGEMISSIONCOMMANDEMENT", "Combat operation plan"];
			wcmessageW spawn WC_fnc_infotext;
			if(isnil "wcchoosemissionmenu") then {
				wcchoosemissionmenu = player addAction ["<t color='#dddd00'>"+localize "STR_WC_MENUCHOOSEMISSION"+"</t>", "warcontext\WC_fnc_openmission.sqf",[],6,false];
			};
		} else {
			player removeaction wcchoosemissionmenu;
			wcchoosemissionmenu = nil;
		};
	};

	WC_fnc_netcode_wchintW = {
		wchintW = _this select 0;
		hintsilent wchintW;
	};

	WC_fnc_netcode_wcmessageW = {
		wcmessageW = _this select 0;
		wcmessageW spawn WC_fnc_infotext;
	};

	WC_fnc_netcode_wcbombingavalaible = {
		wcbombingavalaible = _this select 0;
	};

	WC_fnc_netcode_wccivilkilled = {
		wccivilkilled = _this select 0;
	};

	WC_fnc_netcode_wcenemykilled = {
		wcenemykilled = _this select 0;
	};

	WC_fnc_netcode_wcteamscore = {
		wcteamscore = _this select 0;
	};

	WC_fnc_netcode_wcalert = {
		wcalert = _this select 0;
	};

	WC_fnc_netcode_wccfgpatches = {
		wccfgpatches = _this select 0;
	};

	WC_fnc_netcode_wcinteam = {
		wcinteam = _this select 0;
	};

	WC_fnc_netcode_wclistofmissions = {
		wclistofmissions = _this select 0;
	};

	WC_fnc_netcode_wclistofweapons = {
		wclistofweapons = _this select 0;
	};

	WC_fnc_netcode_wcnuclearzone = {
		wcnuclearzone = _this select 0;
	};

	WC_fnc_netcode_wcteleport = {
		wcteleport = _this select 0;
	};

	WC_fnc_netcode_wchostage = {
		wchostage = _this select 0;
	};

	WC_fnc_netcode_wcday = {
		wcday = _this select 0;
	};

	WC_fnc_netcode_wckindofserver = {
		wckindofserver = _this select 0;
	};

	WC_fnc_netcode_wcselectedzone = {
		wcselectedzone = _this select 0;
	};

	WC_fnc_netcode_wcradioalive = {
		wcradioalive = _this select 0;
	};

	WC_fnc_netcode_wcskill = {
		wcskill = _this select 0;
	};

	WC_fnc_netcode_wclevel = {
		wclevel = _this select 0;
	};

	WC_fnc_netcode_wcmissioncount = {
		wcmissioncount = _this select 0;
	};

	WC_fnc_netcode_wclight = {
		wclight = _this select 0;
	};

	WC_fnc_netcode_wcwithlight = {
		wcwithlight = _this select 0;
	};

	WC_fnc_netcode_wclevelmax = {
		wclevelmax = _this select 0;
	};

	WC_fnc_netcode_wcengineerclass = {
		wcengineerclass = _this select 0;
	};

	WC_fnc_netcode_wcmedicclass = {
		wcmedicclass = _this select 0;
	};

	WC_fnc_netcode_wcscorelimitmin = {
		wcscorelimitmin = _this select 0;
	};

	WC_fnc_netcode_wcscorelimitmax = {
		wcscorelimitmax = _this select 0;
	};

	WC_fnc_netcode_wcteamspeak = {
		wcteamspeak = _this select 0;
	};

	WC_fnc_netcode_wckindofgame = {
		wckindofgame = _this select 0;
	};

	WC_fnc_netcode_wcviewdistance = {
		wcviewdistance = _this select 0;
	};

	WC_fnc_netcode_wcwestside = {
		wcwestside = _this select 0;
	};

	WC_fnc_netcode_wcautoloadweapons = {
		wcautoloadweapons = _this select 0;
	};

	WC_fnc_netcode_wcmotd = {
		wcmotd = _this select 0;
	};

	WC_fnc_netcode_wcversion = {
		wcversion = _this select 0;
	};

	WC_fnc_netcode_wcrecruitberanked = {
		wcrecruitberanked = _this select 0;
	};

	WC_fnc_netcode_wcwithcam = {
		wcwithcam = _this select 0;
	};

	WC_fnc_netcode_wcwithonelife = {
		wcwithonelife = _this select 0;
	};

	WC_fnc_netcode_wcwithmarkers = {
		wcwithmarkers = _this select 0;
	};

	WC_fnc_netcode_wceverybodymedic = {
		wceverybodymedic = _this select 0;
	};

	WC_fnc_netcode_wcwithvehicles = {
		wcwithvehicles = _this select 0;
	};

	WC_fnc_netcode_wconelife = {
		wconelife = _this select 0;
	};

	player addEventHandler ['Fired', '
		private ["_name"];
		if!(wcdetected) then {
			if((getmarkerpos "rescue") distance (position player) < 400) then {
				_name = _this select 5;
				_name = getText (configFile >> "CfgMagazines" >> _name >> "displayNameShort");
				if!(_name == "SD") then {
					wcalerttoadd = random (10);
					["wcalerttoadd", "server"] call WC_fnc_publicvariable;
				};
			};
		};
		wcammoused = wcammoused + 1;
	'];

	if(wckindofgame == 1) then {
		player addEventHandler ['HandleDamage', {
			if(vehicle (_this select 0) == (_this select 0)) then {
				(_this select 0) setdamage ( (getdammage(_this select 0)) + ((_this select 2)/10) );
			} else {
				(_this select 0) setdamage ( (getdammage(_this select 0)) + ((_this select 2)/2) );
			};
		}];
	};

	(findDisplay 46) displayAddEventHandler ["KeyDown","_this call WC_fnc_keymapper;"];