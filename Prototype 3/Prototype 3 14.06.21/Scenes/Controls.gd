extends Control


var movement = ""
var shootS = ""
var hook = "When the H key is pressed"

func _ready():
	if int(Global.userData[14]) == 1:
		movement = "When the Left and Right Arrow Keys are pressed"
	elif int(Global.userData[14]) == 2:
		movement = "When the A and D keys are pressed"
	else:
		movement = "Using the global mouse position"
	if int(Global.userData[15]) == 3:
		shootS = "When the R key is pressed"
	elif int(Global.userData[15]) == 2:
		shootS = "When the Space bar is pressed"
	elif int(Global.userData[15]) == 1 :
		shootS = "When the F key is pressed"
	else:
		shootS = "When the mouse is clicked"
	var text = " Movement of player is:"+ movement+ "\n How to shoot the Shell: "+ shootS + "\n How fire the hook: " + hook
	text = text + "\n press 1 in game for normal round, 2 for incendiary round and 3 for Large normal round"
	text = text + "\n normal takes 1 ammo, incendiary takes 2 ammo and large takes 3 ammo"
	$Stuff.text = text
	pass 
func _on_Menu_pressed():
	Global.button = true
	yield(get_tree().create_timer(0.14), "timeout")
	Global.rege = 2
	Global.logopen = false
	self.queue_free()
	pass
