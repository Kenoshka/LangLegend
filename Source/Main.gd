extends Control

@onready var board_container = %BoardContainer

var paper_scene = preload("res://Source/Paper.tscn")



func _ready():
	modulate.a = 0
	create_tween().tween_property(self, "modulate:a", 1.0, 0.5)
	$Profile/NicknameLabel.text = DataControl.DATA[DataControl.PLAYER_NAME]
	$Profile/ProgressBG/ExpLabel.text = "%s / %s" % [int(int(DataControl.DATA[DataControl.EXP]) % 100), 100]
	$Profile/LevelBG/LevelLabel.text = "%s" % int(int(DataControl.DATA[DataControl.EXP]) / 100)


func _on_settings_button_pressed():
	var tw = create_tween()
	tw.tween_property(self, "modulate:a", 0.0, 0.5)
	await tw.finished
	get_tree().change_scene_to_file("res://Source/Settings.tscn")


func _on_board_button_pressed():
	fill_board()
	$BoardWindow.modulate.a = 0
	$BoardWindow.visible = true
	create_tween().tween_property($BoardWindow, "modulate:a", 1, 0.5).finished



func _on_train_button_pressed():
	pass # Replace with function body.


func fill_board():
	board_add_daily()
	var unactive_paper = paper_scene.instantiate()
	unactive_paper.active = false
	board_container.add_child(unactive_paper)



func _on_container_sort_children():
	var childs = board_container.get_children()
	for i in range(childs.size()):
		childs[i].position.x = randi_range(10, $BoardWindow/BoardScroll.size.x - childs[i].size.x - 30)
		if i == 0:
			childs[i].position.y = randi_range(childs[i].size.x * i, childs[i].size.x * i + 20)
		else:
			var minimum = childs[i-1].position.y + childs[i-1].size.y
			childs[i].position.y = randi_range(minimum, minimum + 20)



func _on_close_button_pressed():
	await create_tween().tween_property($BoardWindow, "modulate:a", 0.0, 0.5).finished
	$BoardWindow.visible = false


func board_add_daily():
	if DataControl.DATA[DataControl.DAILY_USUAL] != Time.get_date_string_from_system():
		var paper_daily = paper_scene.instantiate()
		paper_daily.set_paper(
			FightHandler.DATA[FightHandler.DAILY][FightHandler.INFO.TEXT],
			FightHandler.DATA[FightHandler.DAILY][FightHandler.INFO.ICON]
		)
		board_container.add_child(paper_daily)
	if DataControl.DATA[DataControl.DAILY_BLITZ] != Time.get_date_string_from_system():
		var paper_blitz = paper_scene.instantiate()
		paper_blitz.set_paper(
			FightHandler.DATA[FightHandler.BLITZ][FightHandler.INFO.TEXT],
			FightHandler.DATA[FightHandler.BLITZ][FightHandler.INFO.ICON]
		)
		board_container.add_child(paper_blitz)
