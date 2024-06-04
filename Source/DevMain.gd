extends Control

var DataTestTask = preload("res://Source/DataTestTask.tscn")

func _ready():
	DbHandler.db.query("SELECT * FROM Tasks T join Topics on T.TaskTopic = Topics.TopicId")
	for task in DbHandler.db.query_result:
		var data_scn = DataTestTask.instantiate()
		data_scn.set_labels(task["TaskText"], task["TopicName"], task["TaskAnswers"])
		data_scn.TASK_ID = task["TaskId"]
		$ScrollContainer/VBoxContainer.add_child(data_scn)


func _on_button_exit_pressed():
	get_tree().change_scene_to_file("res://Source/StartScene.tscn")


func _on_button_default_pressed():
	await DbHandler.db.import_from_json("user://EnglishDatabaseExport")
	get_tree().change_scene_to_file("res://Source/StartScene.tscn")
