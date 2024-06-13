extends TextureButton

var MEDAL_ID = 0
var notify_scene = preload("res://Source/NotifyWindow.tscn")


func _ready():
	texture_normal = load(Medals.DATA[MEDAL_ID][1])

func _on_pressed():
	var notify_scn = notify_scene.instantiate()
	notify_scn.set_notify_text("", Medals.DATA[MEDAL_ID][0])
	get_parent().get_parent().get_parent().add_child(notify_scn)

func disable():
	modulate.a = 0.2
