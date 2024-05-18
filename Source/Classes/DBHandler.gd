extends Node

var db : SQLite = SQLite.new()

func _ready():
	db.foreign_keys = true
	if FileAccess.file_exists("user://SongsDatabase.db"):
		DirAccess.remove_absolute("user://SongsDatabase.db")
	db.path = "user://SongsDatabase.db"
	db.open_db()
	database_setup()

func database_setup():
	var Types = {
		"TypeId": {
			"data_type": "int",
			"primary_key": true,
			"auto_increment": true
		},
		"TypeName":  {
			"data_type": "text"
		}
	}
	var Difficulty = {
		"DiffId": {
			"data_type": "int",
			"primary_key": true
		}
	}
	var Topic = {
		"TypeId": {
			"data_type": "int",
			"primary_key": true,
			"auto_increment": true
		},
		"TypeName":  {
			"data_type": "text"
		}
	}
	var Tasks = {
		"TaskId": {
			"data_type": "int",
			"primary_key": true,
			"auto_increment": true
		}
	}




	var Singers = {
		"SingerId": {
			"data_type": "int",
			"primary_key": true,
			"auto_increment": true
		},
		"SingerName":  {
			"data_type": "text"
		}
	}
	var Songs = {
		"SongId":{
			"data_type":"int",
			"primary_key": true,
			"auto_increment": true
		},
		"SongSinger":{
			"data_type": "int",
			"foreign_key": "Singers.SingerId"
		},
		"SongName": {
			"data_type":"text",
		},
		"SongText":{
			"data_type": "text"
		}
	}
	db.create_table("Singers", Singers)
	db.create_table("Songs", Songs)

