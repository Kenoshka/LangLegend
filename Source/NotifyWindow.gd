extends Control


func _on_close_button_pressed():
	queue_free()


func set_notify_text(heading, text, pic = null):
	$InfoContainer/Heading.text = heading
	$InfoContainer/Text.text = text
	if pic != null:
		$InfoContainer/NotifyTexture.texture = pic


func _on_info_container_resized():
	$BG.size = $InfoContainer.size + Vector2(60, 60)
	$BG.global_position = $InfoContainer.global_position - Vector2(30, 30)


func _on_info_container_sort_children():
	$BG.size = $InfoContainer.size + Vector2(60, 60)
	$BG.global_position = $InfoContainer.global_position - Vector2(30, 30)
