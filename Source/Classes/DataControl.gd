extends Node

const FILE_PATH = "user://lang.save"

enum {
	PLAYER_NAME,
	AVATAR,
	TUTORIAL_ENDED,
	START_DATE,
	DAILY,
	DIFFICULTY
}

var DATA = {
	PLAYER_NAME:"123",
	AVATAR:0,
	TUTORIAL_ENDED:false,
	START_DATE:Time.get_date_string_from_system(),
	DAILY: false,
	DIFFICULTY:0
}

func _ready():
	load_data()

func load_data():
	if FileAccess.file_exists(FILE_PATH):
		var file_text = FileAccess.get_file_as_string(FILE_PATH)
		print(file_text)
		var json_parser = JSON.new()
		var err : Error = json_parser.parse(file_text)
		if err == Error.OK:
			var LOADED_DATA = json_parser.data
			for i in LOADED_DATA.keys():
				DATA[int(i)] = LOADED_DATA[i]
		else:
			print(err) # TODO: Обработку ошибок в игре
	else:
		var file = FileAccess.open(FILE_PATH, FileAccess.WRITE)
		var json_parser = JSON.new()
		var data_string = json_parser.stringify(DATA)
		file.store_string(data_string)
		file = null

