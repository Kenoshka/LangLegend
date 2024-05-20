extends Control


func _ready():
	randomize()
	DataControl.load_data()


func _on_timer_timeout():
	if DataControl.DATA[DataControl.PROFILE_CREATED] == false:
		get_tree().change_scene_to_file("res://Source/ProfileCreation.tscn")
	else:
		get_tree().change_scene_to_file("res://Source/Main.tscn")
