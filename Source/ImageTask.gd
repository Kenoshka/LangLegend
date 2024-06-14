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

var IMAGES = [
	preload("res://Assets/Images/bench.jpg"),
	preload("res://Assets/Images/broom.jpg"),
	preload("res://Assets/Images/bucket.jpg"),
	preload("res://Assets/Images/caterpillar.jpg"),
	preload("res://Assets/Images/chimney.jpg"),
	preload("res://Assets/Images/garlic.jpg"),
	preload("res://Assets/Images/hammer.jpg"),
	preload("res://Assets/Images/ink.jpg"),
	preload("res://Assets/Images/ironning.jpg"),
	preload("res://Assets/Images/laptop.jpg"),
	preload("res://Assets/Images/mine.jpg"),
	preload("res://Assets/Images/parcel.jpg"),
	preload("res://Assets/Images/purse.png"),
	preload("res://Assets/Images/rod.jpg"),
	preload("res://Assets/Images/rook.jpg"),
	preload("res://Assets/Images/rope.jpg"),
	preload("res://Assets/Images/ruler.jpg"),
	preload("res://Assets/Images/satellite.jpg"),
	preload("res://Assets/Images/shell.jpg"),
	preload("res://Assets/Images/spade.jpg"),
	preload("res://Assets/Images/spear.jpg"),
	preload("res://Assets/Images/squirrel.jpg"),
	preload("res://Assets/Images/staircase.png"),
	preload("res://Assets/Images/tent.jpg"),
	preload("res://Assets/Images/tire.jpg"),
	preload("res://Assets/Images/vault.jpg"),
	preload("res://Assets/Images/windmill.jpg"),
	preload("res://Assets/Images/wrench.png"),
]

var IMAGES_PATHS = [
	"res://Assets/Images/bench.jpg",
	"res://Assets/Images/broom.jpg",
	"res://Assets/Images/bucket.jpg",
	"res://Assets/Images/caterpillar.jpg",
	"res://Assets/Images/chimney.jpg",
	"res://Assets/Images/garlic.jpg",
	"res://Assets/Images/hammer.jpg",
	"res://Assets/Images/ink.jpg",
	"res://Assets/Images/ironning.jpg",
	"res://Assets/Images/laptop.jpg",
	"res://Assets/Images/mine.jpg",
	"res://Assets/Images/parcel.jpg",
	"res://Assets/Images/purse.png",
	"res://Assets/Images/rod.jpg",
	"res://Assets/Images/rook.jpg",
	"res://Assets/Images/rope.jpg",
	"res://Assets/Images/ruler.jpg",
	"res://Assets/Images/satellite.jpg",
	"res://Assets/Images/shell.jpg",
	"res://Assets/Images/spade.jpg",
	"res://Assets/Images/spear.jpg",
	"res://Assets/Images/squirrel.jpg",
	"res://Assets/Images/staircase.png",
	"res://Assets/Images/tent.jpg",
	"res://Assets/Images/tire.jpg",
	"res://Assets/Images/vault.jpg",
	"res://Assets/Images/windmill.jpg",
	"res://Assets/Images/wrench.png",
]

func _ready():
	DbHandler.db.query_with_bindings("SELECT * FROM Tasks where TaskId = ?", [TASK_ID])
	var TASK = DbHandler.db.query_result[0]
	ANSWERS = TASK["TaskAnswers"].split("_")
	TRUE_ANSWER = int(TASK["TaskRightAnswer"])
	$VBoxContainer/TaskQuestion.text = TASK["TaskQuestion"]
	var path = "res://Assets/Images/" + TASK["TaskText"]
	var num = -1
	if IMAGES_PATHS.has(path):
		num = IMAGES_PATHS.find(path)
	if num != -1:
		$VBoxContainer/TaskImage.texture = IMAGES[num]
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

