extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	modulate.a = 0
	create_tween().tween_property(self, "modulate:a", 1.0, 0.5)

	$Profile/NicknameLabel.text = DataControl.DATA[DataControl.PLAYER_NAME]
	$Profile/ProgressBG/ExpLabel.text = "%s / %s" % [int(int(DataControl.DATA[DataControl.EXP]) % 100), 100]
	$Profile/LevelBG/LevelLabel.text = "%s" % int(int(DataControl.DATA[DataControl.EXP]) / 100)


func _on_settings_button_pressed():
	pass # Replace with function body.


func _on_board_button_pressed():
	pass # Replace with function body.


func _on_train_button_pressed():
	pass # Replace with function body.
