extends Control


func _ready():
	DataControl.load_data()
	print(Time.get_date_string_from_system())


func _on_timer_timeout():
	if DataControl.DATA[DataControl.PROFILE_CREATED] == false:
		get_tree().change_scene_to_file("res://Source/ProfileCreation.tscn")
	else:
		get_tree().change_scene_to_file("res://Source/Main.tscn")
