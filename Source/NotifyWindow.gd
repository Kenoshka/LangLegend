extends Control


func _ready():
	$BG.size = $InfoContainer.size + Vector2(30, 30)
	$BG.global_position = $InfoContainer.global_position - Vector2(15, 15)

func _on_close_button_pressed():
	queue_free()

func set_notify_text(heading, text):
	$InfoContainer/Heading.text = heading
	$InfoContainer/Text.text = text
