extends Control

signal AnswerGiven(is_true)

var TICK = preload("res://Assets/UI/Tick.png")
var CROSS = preload("res://Assets/UI/Cross.png")

var WORD_SCENE = preload("res://Source/OrderWord.tscn")

var WORDS = []

var TWEEN_TIME = 1

var TASK_ID = 140

var TRUE_ANSWER = ""
var GIVEN_ANSWER = ""

var green = Color(0.216, 0.855, 0.173)
var red = Color(1, 0.17, 0.17)

var WORD_CHOSEN = null

func _ready():
	DbHandler.db.query_with_bindings("SELECT * FROM Tasks where TaskId = ?", [TASK_ID])
	var TASK = DbHandler.db.query_result[0]
	TRUE_ANSWER = TASK["TaskRightAnswer"]
	WORDS = TASK["TaskRightAnswer"].split(" ")
	WORDS = Array(WORDS)
	WORDS.shuffle()
	for word in WORDS:
		var word_scn = WORD_SCENE.instantiate()
		word_scn.set_text(word)
		word_scn.WordChosen.connect(word_object_chosen.bind(word_scn))
		$VBoxContainer/WordsOptions.add_child(word_scn)
	modulate.a = 0
	create_tween().tween_property(self, "modulate:a", 1.0, 0.3)


func _on_word_placing_sort_children():
	$ColorRect.size = $VBoxContainer/WordPlacing.size + Vector2(20, 20)
	$ColorRect.global_position = $VBoxContainer/WordPlacing.global_position - Vector2(10, 10)


func word_object_chosen(word_scn):
	WORD_CHOSEN = word_scn


func word_released():
	WORD_CHOSEN = null

func _input(event):
	if event is InputEventMouseButton:
		if event.is_released():
			if WORD_CHOSEN != null:
				if $VBoxContainer/WordPlacing.get_global_rect().has_point(get_global_mouse_position()):
					WORD_CHOSEN.get_parent().remove_child(WORD_CHOSEN)
					$VBoxContainer/WordPlacing.add_child(WORD_CHOSEN)
				elif $VBoxContainer/WordsOptions.get_global_rect().has_point(get_global_mouse_position()):
					WORD_CHOSEN.get_parent().remove_child(WORD_CHOSEN)
					$VBoxContainer/WordsOptions.add_child(WORD_CHOSEN)
				else:
					var parent_container = WORD_CHOSEN.get_parent()
					parent_container.remove_child(WORD_CHOSEN)
					parent_container.add_child(WORD_CHOSEN)
				word_released()


func _on_button_accept_pressed():
	$AnswerColor.modulate.a = 0
	$AnswerColor.visible = true
	var is_true = false
	GIVEN_ANSWER = ""
	for word in $VBoxContainer/WordPlacing.get_children():
		GIVEN_ANSWER += word.get_text() + " "
	GIVEN_ANSWER = GIVEN_ANSWER.erase(GIVEN_ANSWER.length() - 1)
	is_true = GIVEN_ANSWER == TRUE_ANSWER
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

func _on_button_reset_pressed():
	for child in $VBoxContainer/WordPlacing.get_children():
		child.queue_free()
	for child in $VBoxContainer/WordsOptions.get_children():
		child.queue_free()
	for word in WORDS:
		var word_scn = WORD_SCENE.instantiate()
		word_scn.set_text(word)
		word_scn.WordChosen.connect(word_object_chosen.bind(word_scn))
		$VBoxContainer/WordsOptions.add_child(word_scn)
