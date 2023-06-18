extends Control

func _ready():
	$Hud.add_item("Change on how you see the HUD in Game")
	$Hud.set_item_disabled(0, true)
	$Hud.add_item("Have only the numbers")
	$Hud.add_item("Have only the bar")
	$Hud.add_item("Have both")

	$Movement.add_item("Change on how you rotate player")
	$Movement.set_item_disabled(0, true)
	$Movement.add_item("Left and Right arrow keys")
	$Movement.add_item("Using the A and D keys")
	$Movement.add_item("Using the Mouse location")

	$Fire.add_item("Change on how you fire")
	$Fire.set_item_disabled(0, true)
	$Fire.add_item("The F key")
	$Fire.add_item("The Space bar")
	$Fire.add_item("The R key")
	$Fire.add_item("Using a mouse click")


func _process(_delta):
	$Sens.value = int(Global.userData[6])
	$Sens/Label.text = "Sensativity of Turret, Currently: " + str(Global.userData[6])
	if Global.userData[7] == "0":
		$Sound.text = "Sound is currently: Off, Press to switch"
	else: 
		$Sound.text = "Sound is currently: On, Press to switch"



func _on_Sens_value_changed(value):
	value = str(value)
	Global.userData[6] = value
	

func _on_Sound_pressed():
	if Global.userData[7] == "0":
		Global.userData[7] = "1"
	else:
		Global.userData[7] = "0"


func _on_Delete_pressed():
	Global.rege = 6
	Global.logopen = false
	self.queue_free()

func _on_Reset_pressed():
	Global.userData[1] ="0"
	Global.userData[2]="20"
	Global.userData[3]="10"
	Global.userData[4]="2"
	Global.userData[5]="10"
	Global.userData[6]="1"
	Global.userData[7]="1"
	Global.userData[8]="0"
	Global.userData[9]="0"
	Global.userData[10]="0"
	Global.userData[11]="0"
	Global.userData[12]="0"
	Global.userData[13]="3"
	Global.userData[14]="1"
	Global.userData[15]="1"
	_on_Menu_pressed()

func _on_Hud_item_selected(type):
	
	Global.userData[13] = str(type)


func _on_Menu_pressed():
	Global.save_changes()
	Global.rege = 2
	Global.logopen = false
	self.queue_free()
	
	pass # Replace with function body.

func _on_Movement_item_selected(type):
	 # how to rotate 1 = left and right arrow 2 = a d keys 3=mouse location
	Global.userData[14] = str(type)

func _on_Fire_item_selected(type):
	#how to fire 1 = f 2 =space 3 = r 4=mouse click
	Global.userData[15] = str(type)
