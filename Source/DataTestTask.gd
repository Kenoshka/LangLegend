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

func set_labels(task, topic, answers):
	$TaskText/TaskLabel.text = task
	$TaskTopic/TopicLabel.text = topic
	var array = answers.split("_")
	for word in array:
		var word_scn = word_scene.instantiate()
		word_scn.text = word
		$TaskAnswers/AnswersContainer.add_child(word_scn)

