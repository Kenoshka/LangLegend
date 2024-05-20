extends Node

const FILE_PATH = "user://lang.save"

enum {
	PLAYER_NAME,
	AVATAR,
	PROFILE_CREATED,
	TUTORIAL_ENDED,
	START_DATE,
	DIFFICULTY,
	EXP,
	DAILY_USUAL,
	DAILY_BLITZ
}

# Возможно добавить счётчик Right_in_row, чтоб при 100 правильных ответах предлагать повысить уровень сложности.

var DATA = {
	PLAYER_NAME:"123",
	AVATAR:0,
	PROFILE_CREATED:false,
	TUTORIAL_ENDED:false,
	START_DATE:Time.get_date_string_from_system(),
	DIFFICULTY:1,
	EXP: 100,
	DAILY_USUAL: "2020-12-12",
	DAILY_BLITZ: "2020-12-12"
}


func load_data():
	if FileAccess.file_exists(FILE_PATH):
		var file_text = FileAccess.get_file_as_string(FILE_PATH)
		var json_parser = JSON.new()
		var err : Error = json_parser.parse(file_text)
		if err == Error.OK:
			var LOADED_DATA = json_parser.data
			for i in LOADED_DATA.keys():
				DATA[int(i)] = LOADED_DATA[i]
			DATA[AVATAR] = int(clamp(DATA[AVATAR], 0, 3))
			DATA[DIFFICULTY] = int(clamp(DATA[DIFFICULTY], 0, 2))
		else:
			print(err) # TODO: Обработку ошибок в игре
	else:
		save_data()

func save_data():
	var file = FileAccess.open(FILE_PATH, FileAccess.WRITE)
	var json_parser = JSON.new()
	var data_string = json_parser.stringify(DATA)
	file.store_string(data_string)
	file = null


func delete_data():
	if FileAccess.file_exists(FILE_PATH):
		DirAccess.remove_absolute(FILE_PATH)
