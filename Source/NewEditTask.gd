extends Control

var test_nodes

var answer_variant = preload("res://Source/WordVariant.tscn")
var butt_group = ButtonGroup.new()


func _ready():
	if DbHandler.TASK_TO_EDIT != -1:
		set_task_values(DbHandler.TASK_TO_EDIT)
	test_nodes = [
		$ScrollContainer/VBoxContainer/TaskQuestion3,
		$ScrollContainer/VBoxContainer/AnswerEdit,
		$ScrollContainer/VBoxContainer/Answers,
		$ScrollContainer/VBoxContainer/ButtonAdd,
		$ScrollContainer/VBoxContainer/ItemList
	]
	$ScrollContainer/VBoxContainer/ItemList.select(0)

func set_task_values(taks_id):
	await DbHandler.db.query_with_bindings("SELECT * from Tasks where TaskId = ?", [taks_id])
	$ScrollContainer/VBoxContainer/TaskEdit.text = DbHandler.db.query_result[0]["TaskText"]
	if DbHandler.db.query_result[0]["TaskType"] == 1:
		$ScrollContainer/VBoxContainer/IsTest.button_pressed = true
		var answers = DbHandler.db.query_result[0]["TaskAnswers"]
		var array = answers.split("_")
		for word in array:
			var ans_var = answer_variant.instantiate()
			ans_var.text = word
			ans_var.button_group = butt_group
			ans_var.tree_exited.connect(reselect_answer)
			$ScrollContainer/VBoxContainer/Answers.add_child(ans_var)
		var right = int(DbHandler.db.query_result[0]["TaskRightAnswer"])
		$ScrollContainer/VBoxContainer/Answers.get_child(right).button_pressed = true
		var topic = int(DbHandler.db.query_result[0]["TaskTopic"])
		match topic:
			1:
				$ScrollContainer/VBoxContainer/ItemList.select(0)
			2:
				$ScrollContainer/VBoxContainer/ItemList.select(1)
			4:
				$ScrollContainer/VBoxContainer/ItemList.select(2)
	else:
		$ScrollContainer/VBoxContainer/IsTest.button_pressed = false


func _on_check_box_pressed():
	for node in test_nodes:
		node.visible = $ScrollContainer/VBoxContainer/IsTest.button_pressed

func _on_button_add_pressed():
	if $ScrollContainer/VBoxContainer/AnswerEdit.text.length() > 0:
		var answer_scene = answer_variant.instantiate()
		answer_scene.text = $ScrollContainer/VBoxContainer/AnswerEdit.text
		answer_scene.button_group = butt_group
		answer_scene.button_pressed = true
		answer_scene.tree_exited.connect(reselect_answer)
		$ScrollContainer/VBoxContainer/Answers.add_child(answer_scene)
		$ScrollContainer/VBoxContainer/AnswerEdit.text = ""


func reselect_answer():
	var has_pressed = false
	for child in $ScrollContainer/VBoxContainer/Answers.get_children():
		if child.button_pressed:
			has_pressed = true
	if not has_pressed and $ScrollContainer/VBoxContainer/Answers.get_child_count() > 0:
		$ScrollContainer/VBoxContainer/Answers.get_child(0).button_pressed = true


func _on_button_save_pressed():
	var type = 2
	var task_test = ""
	if $ScrollContainer/VBoxContainer/TaskEdit.text != "":
		task_test = $ScrollContainer/VBoxContainer/TaskEdit.text
		if $ScrollContainer/VBoxContainer/IsTest.button_pressed:
			type = 1
			if $ScrollContainer/VBoxContainer/Answers.get_child_count() > 0:
				var answers_string = ""
				var right = 0
				var childs = $ScrollContainer/VBoxContainer/Answers.get_children()
				var topic = 0
				for i in range(childs.size()):
					answers_string += childs[i].text + "_"
					if childs[i].button_pressed:
						right = i
				answers_string = answers_string.erase(answers_string.length() - 1)
				match $ScrollContainer/VBoxContainer/ItemList.get_selected_items()[0]:
					0:
						topic = 1
					1:
						topic = 2
					2:
						topic = 4
				if DbHandler.TASK_TO_EDIT == -1:
					DbHandler.db.insert_row("Tasks", {
					"TaskDiff":0,
					"TaskTopic":topic,
					"TaskType":1,
					"TaskQuestion":"Выберите правильное слово",
					"TaskText":$ScrollContainer/VBoxContainer/TaskEdit.text,
					"TaskAnswers":answers_string,
					"TaskRightAnswer":str(right)}
					)
					get_tree().change_scene_to_file("res://Source/DevMain.tscn")
				else:
					DbHandler.db.query_with_bindings("UPDATE Tasks SET
					TaskTopic = ?,
					TaskType = ?,
					TaskText = ?,
					TaskAnswers = ?,
					TaskRightAnswer = ? WHERE TaskId = ?",
					[topic, type, task_test, answers_string, str(right), DbHandler.TASK_TO_EDIT])
					get_tree().change_scene_to_file("res://Source/DevMain.tscn")
			else:
				$AcceptDialog.dialog_text = "Вы не внесли варианты ответов."
				$AcceptDialog.show()
		else:
			var topic = 3
			if DbHandler.TASK_TO_EDIT == -1:
				DbHandler.db.insert_row("Tasks", {
					"TaskDiff":0,
					"TaskTopic":topic,
					"TaskType":2,
					"TaskQuestion":"Расположите слова в правильном порядке",
					"TaskText":$ScrollContainer/VBoxContainer/TaskEdit.text,
					"TaskAnswers":"",
					"TaskRightAnswer":$ScrollContainer/VBoxContainer/TaskEdit.text}
					)
				get_tree().change_scene_to_file("res://Source/DevMain.tscn")
			else:
				DbHandler.db.query_with_bindings("UPDATE Tasks SET
				TaskTopic = ?,
				TaskType = ?,
				TaskText = ?,
				TaskAnswers = ?,
				TaskRightAnswer = ? WHERE TaskId = ?",
				[topic, type, task_test, "", task_test, DbHandler.TASK_TO_EDIT])
				get_tree().change_scene_to_file("res://Source/DevMain.tscn")
	else:
		$AcceptDialog.dialog_text = "Вы не внесли текст задания."
		$AcceptDialog.show()
