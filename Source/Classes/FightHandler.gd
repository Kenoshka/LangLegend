extends Node

var sword_icon = preload("res://Assets/UI/PaperIcons/sword.png")
var shield_icon = preload("res://Assets/UI/PaperIcons/shield.png")
var skull_icon = preload("res://Assets/UI/PaperIcons/skull.png")
var fire_icon = preload("res://Assets/UI/PaperIcons/fire.png")

var ICONS = [
	sword_icon,
	shield_icon,
	skull_icon,
	fire_icon
]


var IS_DAILY = true
var IS_TRAIN = false

var TYPE_CHOSEN = USUAL


enum {
	USUAL,
	BLITZ
}

enum INFO {
	TEXT,
	ICON
}

var DATA = {
	USUAL: ["Ежедневное задание", sword_icon],
	BLITZ: ["Блитц 10", fire_icon]
}

var NOTIFY = []
