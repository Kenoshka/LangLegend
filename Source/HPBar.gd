extends ColorRect

var gray = Color(0.5, 0.5, 0.5)
var green = Color(0, 0.718, 0.016)

func set_status(status):
	if status:
		$InnerColor.color = green
	else:
		$InnerColor.color = gray
