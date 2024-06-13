extends Node

enum {
	REG,
	BLITZ_50,
	BLITZ_200,
	BLITZ_500,
	MONSTERS_10,
	DIALOGS_10
}

var DATA = {
	REG:["Вы зарегистрировались!", "res://Assets/Medals/reg.png"],
	BLITZ_50:["Вы 50 раз ответили правильно в Блитце.", "res://Assets/Medals/blitz_50.png"],
	BLITZ_200:["Вы 200 раз ответили правильно в Блитце.", "res://Assets/Medals/blitz_200.png"],
	BLITZ_500:["Вы 500 раз ответили правильно в Блитце.", "res://Assets/Medals/blitz_500.png"],
	MONSTERS_10:["Вы победили 10 монстров", "res://Assets/Medals/monsters_10.png"],
	DIALOGS_10:["Вы прочли 10 диалогов.", "res://Assets/Medals/dialogs_10.png"]
}


func check_blitz_medals():
	if DataControl.DATA[DataControl.BLITZ_RIGHTS] >= 50 and not DataControl.DATA[DataControl.MEDALS].has(BLITZ_50):
		DataControl.DATA[DataControl.MEDALS].append(BLITZ_50)
	if DataControl.DATA[DataControl.BLITZ_RIGHTS] >= 200 and not DataControl.DATA[DataControl.MEDALS].has(BLITZ_200):
		DataControl.DATA[DataControl.MEDALS].append(BLITZ_200)
	if DataControl.DATA[DataControl.BLITZ_RIGHTS] >= 500 and not DataControl.DATA[DataControl.MEDALS].has(BLITZ_500):
		DataControl.DATA[DataControl.MEDALS].append(BLITZ_500)


func check_monsters_medals():
	if DataControl.DATA[DataControl.MONSTERS_BEATEN] >= 10 and not DataControl.DATA[DataControl.MEDALS].has(MONSTERS_10):
		DataControl.DATA[DataControl.MEDALS].append(MONSTERS_10)


func check_dialogs_medals():
	if DataControl.DATA[DataControl.DIALOGS_READ] >= 10 and not DataControl.DATA[DataControl.MEDALS].has(DIALOGS_10):
		DataControl.DATA[DataControl.MEDALS].append(DIALOGS_10)
