extends Control

var leader_label_scene = preload("res://LeaderLabels.tscn")


func _on_timer_timeout():
	if DataControl.LEADERBOARD.size() == 0:
		$Loading.text = "Ошибка подключения"
	else:
		$Loading.text = ""
		var size = 0
		for i in range(DataControl.LEADERBOARD.size()):
			var leader_scn = leader_label_scene.instantiate()
			leader_scn.set_leader(i + 1, DataControl.LEADERBOARD[i][0], DataControl.LEADERBOARD[i][2])
			if (
				DataControl.LEADERBOARD[i][0] == DataControl.DATA[DataControl.PLAYER_NAME] and
				DataControl.LEADERBOARD[i][1] == DataControl.DATA[DataControl.START_DATE]
			):
				leader_scn.player_highlight()
			$Leaders.add_child(leader_scn)


func _on_back_button_pressed():
	var tw = create_tween()
	tw.tween_property(self, "modulate:a", 0.0, 0.5)
	await tw.finished
	get_tree().change_scene_to_file("res://Source/Main.tscn")
