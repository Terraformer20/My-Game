/// @description Post-start turn textbox

switch (currPhase) {
	case battlePhase.startWait: {
		for (var i = 0; i < array_length(global.alliedUnits); i += 1) {
			if (!global.alliedUnits[i].isDead) {
				allyTurn = i;
				break;
			}
		}
		currPhase = battlePhase.playerTurn;
		currPage = battlePage.main;
		targetSelected = 0;
		selectIndex = 0;
		for (var i = 0; i < array_length(optionSelected); i += 1) {
			optionSelected[i] = 0;
		}
	}; break;
	case battlePhase.processWait: {
		if (global.run == true) {
			endBattle();
		}
		currPhase = battlePhase.checkFinish;
	}; break;
	case battlePhase.lose: {
		room_goto(rm_start);
	}; break;
	case battlePhase.winWait: {
		endBattle();
	}; break;
}