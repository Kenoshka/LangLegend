extends Node

const FILE_PATH = "user://lang.save"

enum {
	PLAYER_NAME,
	AVATAR,
	PROFILE_CREATED,
	TUTORIAL_ENDED,
	START_DATE,
	DAILY_DATE,
	DIFFICULTY,
	EXP
}

var DATA = {
	PLAYER_NAME:"123",
	AVATAR:0,
	PROFILE_CREATED:false,
	TUTORIAL_ENDED:false,
	START_DATE:Time.get_date_string_from_system(),
	DAILY_DATE: "2020-12-12",
	DIFFICULTY:0,
	EXP: 100
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
			DATA[AVATAR] = clamp(DATA[AVATAR], 0, 3)
			DATA[DIFFICULTY] = clamp(DATA[DIFFICULTY], 0, 2)
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
