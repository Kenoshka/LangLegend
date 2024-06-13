extends ColorRect

var TalkChosen = 0

var PHRASE_COUNT = 0
var PHRASE_LANG = TalksData.ENG

var PHRASE = ""

func _ready():
	TalkChosen = randi_range(0, TalksData.PHRASES.size() - 1)
	show_text()
	modulate.a = 0
	create_tween().tween_property(self, "modulate:a", 1.0, 1)


func buttons_counting():
	if PHRASE_COUNT == TalksData.PHRASES[TalkChosen].size() - 1:
		$BG/NextButton.visible = false
		$BG/PrevButton.visible = true
	if PHRASE_COUNT == 0:
		$BG/NextButton.visible = true
		$BG/PrevButton.visible = false
	else:
		$BG/PrevButton.visible = true


func _on_next_button_pressed():
	PHRASE_COUNT += 1
	buttons_counting()
	show_text()

func _on_prev_button_pressed():
	PHRASE_COUNT -= 1
	$BG/NextButton.visible = true
	buttons_counting()
	show_text()

func _on_translate_button_pressed():
	PHRASE_LANG = TalksData.RUS if PHRASE_LANG == TalksData.ENG else TalksData.ENG
	show_text()

func show_text():
	$BG/VBoxContainer/TextLabel/TranslateButton.disabled = true
	$ShaderTimer.start(1.2)
	$LangTimer.start(0.6)
	$BG/VBoxContainer/TextLabel.material.set_shader_parameter("progress", 0.5)
	var tw = get_tree().create_tween()
	tw.tween_method(set_shad_params, 0.6, 0.0, 0.6)
	tw.tween_method(set_shad_params, 0.0, 0.6, 0.6)


func set_shad_params(value):
	$BG/VBoxContainer/TextLabel.material.set_shader_parameter("progress", value)


func _on_shader_timer_timeout():
	$BG/VBoxContainer/TextLabel/TranslateButton.disabled = false


func _on_lang_timer_timeout():
	$BG/VBoxContainer/TextLabel.text = "-- %s" % TalksData.PHRASES[TalkChosen][PHRASE_COUNT][PHRASE_LANG]


func _on_close_button_pressed():
	DataControl.DATA[DataControl.DIALOGS_READ] += 1
	Medals.check_dialogs_medals()
	modulate.a = 1
	var tw = create_tween()
	tw.tween_property(self, "modulate:a", 0.0, 0.5)
	await tw.finished
	queue_free()
