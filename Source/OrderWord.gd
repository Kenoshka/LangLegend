extends MarginContainer

signal WordChosen

func _ready():
	set_process(false)


func set_text(text):
	$WordLabel.text = text

func get_text():
	return $WordLabel.text

func _input(event):
	if event is InputEventMouseButton:
		if (event.is_pressed()
		and event.button_index == MOUSE_BUTTON_LEFT
		and get_global_rect().has_point(get_global_mouse_position())):
			WordChosen.emit()
			set_process(true)
		if (event.is_released()
		and event.button_index == MOUSE_BUTTON_LEFT
		and get_global_rect().has_point(get_global_mouse_position())):
			set_process(false)


func _process(delta):
	global_position = get_global_mouse_position() - size / 2
