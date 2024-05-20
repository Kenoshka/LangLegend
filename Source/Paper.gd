extends Button

var active = true:
	set(val):
		active = val
		if not val:
			modulate.a = 0

func set_paper(text : String, icon = null, extra = ""):
	$PaperLabel.text = text
	$ExtraLabel.text = extra
	if icon == null:
		$IconTexture.texture = FightHandler.ICONS[randi_range(0, FightHandler.ICONS.size() - 1)]
	else:
		$IconTexture.texture = icon
