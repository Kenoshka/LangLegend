extends Control


func set_leader(num, nick, exp):
	$Num.text = str(num)
	$Name.text = str(nick)
	$Exp.text = str(exp)


func player_highlight():
	$IsPlayer.visible = true
