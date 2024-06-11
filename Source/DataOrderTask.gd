extends Control

var TASK_ID = null

var word_scene = preload("res://Source/DevWord.tscn")

func _on_button_pressed():
	if TASK_ID != null:
		$ConfirmationDialog.visible = true


func _on_confirmation_dialog_canceled():
	$ConfirmationDialog.visible = false


func _on_confirmation_dialog_confirmed():
	await DbHandler.remove_task(TASK_ID)
	queue_free()


func set_labels(task, topic):
	$TaskText/TaskLabel.text = task
	$TaskTopic/TopicLabel.text = topic



func _on_edit_button_pressed():
	DbHandler.TASK_TO_EDIT = TASK_ID
	get_tree().change_scene_to_file("res://Source/NewEditTask.tscn")
