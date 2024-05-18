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


enum {
	USUAL,
	DAILY,
	BLITZ
}

enum INFO {
	TEXT,
	ICON
}

var DATA = {
	DAILY: ["Ежедневное задание", sword_icon],
	BLITZ: ["Блиц", fire_icon]
}
