extends Control

signal AnswerGiven(is_true)

var TICK = preload("res://Assets/UI/Tick.png")
var CROSS = preload("res://Assets/UI/Cross.png")

var ANSWER_BUTT = preload("res://Source/AnswerButton.tscn")
var ANSWERS = []

var TWEEN_TIME = 1

var TASK_ID = 1
var TRUE_ANSWER = 0

var green = Color(0.216, 0.855, 0.173)
var red = Color(1, 0.17, 0.17)

func _ready():
	DbHandler.db.query_with_bindings("SELECT * FROM Tasks where TaskId = ?", [TASK_ID])
	var TASK = DbHandler.db.query_result[0]
	ANSWERS = TASK["TaskAnswers"].split("_")
	TRUE_ANSWER = int(TASK["TaskRightAnswer"])
	$VBoxContainer/TaskQuestion.text = TASK["TaskQuestion"]
	$VBoxContainer/TaskText.text = TASK["TaskText"]
	for answer in ANSWERS:
		var answer_scene = ANSWER_BUTT.instantiate()
		answer_scene.pressed.connect(On_Answer_Button.bind(answer_scene))
		answer_scene.text = answer
		$VBoxContainer/AnswersContainer.add_child(answer_scene)
	modulate.a = 0
	create_tween().tween_property(self, "modulate:a", 1.0, 0.3)

func On_Answer_Button(button_self):
	$AnswerColor.modulate.a = 0
	$AnswerColor.visible = true
	var is_true = button_self.text == ANSWERS[TRUE_ANSWER]
	match is_true:
		true:
			$AnswerColor.color = green
			$AnswerColor/AnswerTexture.texture = TICK
		false:
			$AnswerColor.color = red
			$AnswerColor/AnswerTexture.texture = CROSS
	var tw = create_tween()
	tw.tween_property($AnswerColor, "modulate:a", 1.0, TWEEN_TIME)
	tw.tween_property($VBoxContainer, "visible", false, 0)
	tw.tween_property(self, "modulate:a", 0, TWEEN_TIME)
	await tw.finished
	AnswerGiven.emit(is_true)
	queue_free()

