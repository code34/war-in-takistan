	// -----------------------------------------------
	// Author: =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// warcontext - Description: init
	// -----------------------------------------------

	if (isdedicated) exitWith{};

	_diary = player createDiaryRecord ["Diary", ["Author", "The main mission was developped by =[A*C]= code34"]];
	_diary = player createDiaryRecord ["Diary", ["Tent", "You can build tent. Tent can be used as personnal respawn."]];
	_diary = player createDiaryRecord ["Diary", ["Repair\Unlock\Unflip vehicles", "Only engineers can repair, unflip, unlock vehicles."]];
	_diary = player createDiaryRecord ["Diary", ["Points", "At the end of each mission, the players have to distribute some points to other players to evaluate their contribution to the successfull of the mission. Thoses points affects the players ranking. More the rank of the player is higher, more the game is hardier for him (less revive)"]];
	_diary = player createDiaryRecord ["Diary", ["Players revives", "When you are die, only medics or corpsman can heal you. If nobody come to heal, you have to respawn to base. You can be heal a couple of time, before to have to return to base. Medic can t heal themself, if they do, they will return to base and loose some points. <br/><br/>When a player died, the teamscore is decreased by 1 until a medic revive him. If the player respawn to base, the score is decrease again by 1."]];
	_diary = player createDiaryRecord ["Diary", ["Team rank", "Your team receive a notation during the game. More you game is good and teamplay, more your team will receive a good notation and great rank. If your team rank is too bad the game finish.<br/><br/>
	1- Heroe team<br/>
	2- Elite team<br/>
	3- Experienced team<br/>
	4- Confirmed team<br/>
	7- Noobs team<br/>
	6- Calamity team<br/>
	7- Bastard team<br/>
	8- Asshole team<br/>
	"]];
	_diary = player createDiaryRecord ["Diary", ["Complete an operation", "You have to go to the mission spot, and complete it. When you have sucess, all the friendly troops have to go out of the zone and wait for complete message."]];
	_diary = player createDiaryRecord ["Diary", ["OPERATIONS IRON RAINS", "The war in Takistan lasts for several months. Conflicts are increasingly hard, and rains were replaced during the last months by ammunitions."]];
