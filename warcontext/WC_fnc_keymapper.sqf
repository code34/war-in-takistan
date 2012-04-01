	// -----------------------------------------------
	// Author: =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// HANDLE KEYBOARD EVENTS

	#include "dik_codes.h"
	
	private ["_handled", "_ctrl", "_dikCode", "_shift", "_ctrl", "_alt", "_optionValueIndex", "_propertyValueChanged", "_maxValueCount"];

	_ctrl	= _this select 0;
	_dikCode= _this select 1;
	_shift	= _this select 2;
	_ctrl	= _this select 3;
	_alt	= _this select 4;
	_handled = false;

	if(_dikCode == DIK_TAB) then {
		if(format["%1", wcanim] != "") then {
			terminate wcanim;
			wccam cameraEffect ["terminate","back"];
			camDestroy wccam;
			wccam = objNull;
			wcanim = "";
			playmusic "";
			titleText ["", "PLAIN"];
			ppEffectDestroy wccameffect;
			"FilmGrain" ppEffectEnable false;
			camUseNVG false;
			false setCamUseTi 1;
		} else {
			if(wcrankactivate) then {
				wcrankactivate = false;
				playmusic "";
				player cameraEffect ["terminate","back"];
			}else{
				wcrankactivate = true;
				playmusic "";
			};
		};
		if!(isnil "wcadvancetodate") then {
			setdate wcadvancetodate;
			wcadvancetodate = nil;
		};
	};

	if(_dikCode in actionKeys "NightVision") then {
		if(format["%1", wcanim] != "") then {
			camUseNVG true;
			true setCamUseTi 0;
		};
	};

	if(_dikCode in actionKeys "CancelAction") then {
		_count = count wcjukebox;
		if(wcindexmusic > _count) then {
			wcindexmusic = 0;
		} else {
			wcindexmusic = wcindexmusic + 1;
		};
		//_music = wcjukebox call BIS_fnc_selectRandom;
		_music = wcjukebox select wcindexmusic;
		playMusic _music;
		player sideChat format["%1 - %2", wcindexmusic, _music];
	};

	// arcade = 1
	if(wckindofgame == 1) then {
		WC_fnc_jumper = {
			private ["_animation", "_vel", "_dir", "_speed"];
			if ((animationState player == "amovpercmrunsraswrfldf") or ( animationState player == "amovpercmevasraswrfldf")) then {
				if( ((getpos player) select 2) < 0.05) then {
					if(wcplayjumpmove == 0) then {
						wcplayjumpmove = wcplayjumpmove + 1;
						_animation = animationstate player;
						_vel = velocity player;
						_dir = direction player;
						if(( abs(_vel select 0) > 1) or ( abs(_vel select 1) > 1)) then {
							_speed = -0.5; 
							player setVelocity [(_vel select 0)+(sin _dir*_speed),(_vel select 1)+ (cos _dir*_speed), 4];	
							sleep 0.7;
							player playmove "amovpercmevasraswrfldf";
							player playmove "amovpercmevasraswrfldf";
							waituntil {(animationState player != "amovpercmevasraswrfldf")};
						} else {
							_speed = 0; 
							player setVelocity [(_vel select 0)+(sin _dir*_speed),(_vel select 1)+ (cos _dir*_speed), 4];	
							sleep 2;
						};
						wcplayjumpmove = 0;
					};
				};
			};
		};
	
		if(_dikCode in actionKeys "User15") then {
			wcgarbage = [] spawn WC_fnc_jumper;
		};
	};

	// cheat mode
	if(wckindofgame == 3) then {
		if(_dikCode == DIK_1) then{
			removeallweapons player;
			_weapon = wclistofweapons select wclistofweaponsindex;
			wclistofweaponsindex = wclistofweaponsindex + 1;
			if(wclistofweaponsindex > count wclistofweapons) then {wclistofweaponsindex = 0;};
			player addweapon _weapon;
			if!(format["%1", primaryweapon player] == "") then {
				player selectWeapon (primaryWeapon player);
			} else {
				player selectWeapon (secondaryWeapon player);
			};
			
			_magazines = [[_weapon]] call WC_fnc_enummagazines;
			{
				player addmagazine _x;
			}foreach _magazines;
			reload player;
		};
	};

	if(_dikCode in actionKeys "TeamSwitch") then{
		player playMove "ActsPercMrunSlowWrflDf_FlipFlopPara";
		_handled = true;
	};

	if(_dikCode == DIK_NUMPAD1) then {
		if(wciedchallenge) then {
			if(iedkey == "1") then {
				wciedcount = wciedcount + 1;
			} else {
				wciedexplosed = true;
			};
			playsound "bip1";
		};
	};

	if(_dikCode == DIK_NUMPAD2) then {
		if(wciedchallenge) then {
			if(iedkey == "2") then {
				wciedcount = wciedcount + 1;
			} else {
				wciedexplosed = true;
			};
			playsound "bip2";
		};
	};
	if(_dikCode == DIK_NUMPAD3) then {
		if(wciedchallenge) then {
			if(iedkey == "3") then {
				wciedcount = wciedcount + 1;
			} else {
				wciedexplosed = true;
			};
			playsound "bip3";
		};
	};
	if(_dikCode == DIK_NUMPAD4) then {
		if(wciedchallenge) then {
			if(iedkey == "4") then {
				wciedcount = wciedcount + 1;
			} else {
				wciedexplosed = true;
			};
			playsound "bip4";
		};
	};
	if(_dikCode == DIK_NUMPAD5) then {
		if(wciedchallenge) then {
			if(iedkey == "5") then {
				wciedcount = wciedcount + 1;
			} else {
				wciedexplosed = true;
			};
			playsound "bip5";
		};
	};
	if(_dikCode == DIK_NUMPAD6) then {
		if(wciedchallenge) then {
			if(iedkey == "6") then {
				wciedcount = wciedcount + 1;
			} else {
				wciedexplosed = true;
			};
			playsound "bip6";
		};
	};
	if(_dikCode == DIK_NUMPAD7) then {
		if(wciedchallenge) then {
			if(iedkey == "7") then {
				wciedcount = wciedcount + 1;
			} else {
				wciedexplosed = true;
			};
			playsound "bip7";
		};
	};

	if(_dikCode == DIK_NUMPAD8) then {
		if(wciedchallenge) then {
			if(iedkey == "8") then {
				wciedcount = wciedcount + 1;
			} else {
				wciedexplosed = true;
			};
			playsound "bip8";
		};
	};
	if(_dikCode == DIK_NUMPAD9) then {
		if(wciedchallenge) then {
			if(iedkey == "9") then {
				wciedcount = wciedcount + 1;
			} else {
				wciedexplosed = true;
			};
			playsound "bip9";
		};
	};
	_handled;