extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var movement = ""
var shootS = ""
var hook = "When the H key is pressed"


# Called when the node enters the scene tree for the first time.
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

	$Stuff.text = " Movement of player is:"+ movement+ "\n How to shoot the Shell: "+ shootS + "\n How fire the hook: " + hook
	pass # Replace with function body.


func _on_Menu_pressed():
	Global.rege = 2
	Global.logopen = false
	self.queue_free()
	pass