extends Control

var goal_position = Vector2(0, 40)
var start_position = Vector2(0, 200)
var gone_position = Vector2(0, -200)

var nickname = ""
var character = 0
var diff = 0

func _ready():
	$Nick.position = start_position
	$Nick.modulate.a = 0


	$Char.position = start_position
	$Char.modulate.a = 0


	$Diff.position = start_position
	$Diff.modulate.a = 0

	$Fin.modulate.a = 0

	var tw = create_tween().parallel()
	tw.set_parallel()
	tw.tween_property($Nick, "position", goal_position, 1).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tw.tween_property($Nick, "modulate:a", 1.0, 1)



func _on_nick_edit_text_changed(new_text):
	$Nick/NextButton.visible = $Nick/NickBox/NickEdit.text.length() > 0

func _on_next_button_pressed():
	nickname = $Nick/NickBox/NickEdit.text
	var tw = create_tween().parallel()
	tw.set_parallel()
	tw.tween_property($Nick, "position", gone_position, 1).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tw.tween_property($Nick, "modulate:a", 0.0, 0.5)

	$Char.visible = true
	var tw_two = create_tween().parallel()
	tw_two.set_parallel()
	tw_two.tween_property($Char, "position", goal_position, 1).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tw_two.tween_property($Char, "modulate:a", 1.0, 1)
	await tw_two.finished
	for butt in $Char/CharBox/GridContainer.get_children():
		butt.disabled = false


func char_chosen(char_num):
	character = char_num
	var tw = create_tween().parallel()
	tw.set_parallel()
	tw.tween_property($Char, "position", gone_position, 1).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tw.tween_property($Char, "modulate:a", 0.0, 0.5)

	$Diff.visible = true
	var tw_two = create_tween().parallel()
	tw_two.set_parallel()
	tw_two.tween_property($Diff, "position", goal_position, 1).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tw_two.tween_property($Diff, "modulate:a", 1.0, 1)
	for butt in $Diff/DiffBox/GridContainer.get_children():
		butt.disabled = false

func diff_chosen(diff_num):
	diff = diff_num
	var tw = create_tween().parallel()
	tw.set_parallel()
	tw.tween_property($Diff, "position", gone_position, 1).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tw.tween_property($Diff, "modulate:a", 0.0, 0.5)

	$Fin.visible = true
	var tw_two = create_tween()
	tw_two.tween_property($Fin, "modulate:a", 1.0, 1)
	$LabelTimer.start(2)

	DataControl.DATA[DataControl.PLAYER_NAME] = nickname
	DataControl.DATA[DataControl.AVATAR] = character
	DataControl.DATA[DataControl.DIFFICULTY] = diff
	DataControl.DATA[DataControl.PROFILE_CREATED] = true
	DataControl.save_data()


func _on_label_timer_timeout():
	var tw = create_tween()
	tw.tween_property($Fin, "modulate:a", 0.0, 1)
	$NextSceneTimer.start(1)


func _on_next_scene_timer_timeout():
	get_tree().change_scene_to_file("res://Source/Main.tscn")
