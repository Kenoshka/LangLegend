extends Control

var goal_position = Vector2(0, 0)
var start_position = Vector2(0, 200)
var gone_position = Vector2(0, -200)

func _ready():
	modulate.a = 0
	position = start_position

	var tw = create_tween()
	tw.set_parallel()
	tw.tween_property(self, "position", goal_position, 1).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tw.tween_property(self, "modulate:a", 1.0, 1)

	var diff = DataControl.DATA[DataControl.DIFFICULTY]
	match diff:
		0:
			$SettingsContainer/ButtonMedium.button_pressed = true
		1:
			$SettingsContainer/ButtonHard.button_pressed = true



func _on_back_button_pressed():
	await DataControl.save_data()
	var tw = create_tween()
	tw.set_parallel()
	tw.tween_property(self, "modulate:a", 0.0, 0.5)
	tw.tween_property(self, "position", gone_position, 0.5)
	await tw.finished
	get_tree().change_scene_to_file("res://Source/Main.tscn")


func _on_button_reset_pressed():
	$ConfirmationDialog.visible = true


func _on_confirmation_dialog_canceled():
	$ConfirmationDialog.visible = false


func _on_confirmation_dialog_confirmed():
	await DataControl.delete_data()
	get_tree().quit()


func set_diff(diff):
	DataControl.DATA[DataControl.DIFFICULTY] = diff


func _on_button_dev_pressed():
	get_tree().change_scene_to_file("res://Source/DevMain.tscn")
