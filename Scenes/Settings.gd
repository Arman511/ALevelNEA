extends Control

func _ready():
	$Sens.value = Global.userInfo.getSens()
	$Sens/Label.text = "Sensitivity of Turret, Currently: " + str(Global.userInfo.getSens())
	#gets and sets current movement Sensitivity
	if Global.userInfo.getRotate() == 3:
		$Sens.hide()
	else:
		$Sens.show()
	#hides sensitivity editor if using mouse to move
	var num = db2linear(Global.userInfo.getVolume())
	$Vol.value = num
	$Vol/Label.text = "Volume is currently:" + str(int(num*100))
	#gets and sets current volume
	$Hud.add_item("Change on how you see the HUD in Game")
	$Hud.set_item_disabled(0, true)
	$Hud.add_item("Have only the numbers")
	$Hud.add_item("Have only the bar")
	$Hud.add_item("Have both")
	#sets all options to hud type
	$Movement.add_item("Change on how you rotate player")
	$Movement.set_item_disabled(0, true)
	$Movement.add_item("Left and Right arrow keys")
	$Movement.add_item("Using the A and D keys")
	$Movement.add_item("Using the Mouse location")
	#sets all options for movement
	$Fire.add_item("Change on how you fire")
	$Fire.set_item_disabled(0, true)
	$Fire.add_item("The F key")
	$Fire.add_item("The Space bar")
	$Fire.add_item("The R key")
	$Fire.add_item("Using a left click")
	#sets all options to fire shells
	$Colour.add_item("Change Tank colour")
	$Colour.set_item_disabled(0, true)
	$Colour.add_item("Black")
	$Colour.add_item("Grey")
	$Colour.add_item("White")
	$Colour.add_item("Purple")
	$Colour.add_item("Brown")
	$Colour.add_item("Orange")
	$Colour.add_item("Red")
	$Colour.add_item("Green")
	$Colour.add_item("Blue")
	#sets all options to change tank colour
	$Hook.add_item("Change on how you fire hook")
	$Hook.set_item_disabled(0, true)
	$Hook.add_item("The H key")
	$Hook.add_item("Shift key")
	$Hook.add_item("Using the Right click")
	#sets all options to fire hook

func _on_Sens_value_changed(value):
	value = str(value)
	Global.userInfo.setSens(value)
	$Sens/Label.text = "Sensitivity of Turret, Currently: " + str(Global.userInfo.getSens())
	#sets new sensitivity  when it changes

func _on_Vol_value_changed(num):
	$Vol/Label.text = "Volume is currently:" + str(int(num*100))
	num = linear2db(num)
	Global.userInfo.setVolume(num)
	#sets new volume when it changes

func _on_Delete_pressed():
	Global.button = true
	Global.rege = 6
	Global.logopen = false
	self.queue_free()
	#loads delete scene
	
func _on_Reset_pressed():
	$Res.popup()
	#loads rest popup

func _on_Res_confirmed():
	Global.button = true
	Global.userInfo.setCash("0")
	Global.userInfo.setMaxShell("20")
	Global.userInfo.setMaxHP("10")
	Global.userInfo.setkitHP("2")
	Global.userInfo.setkitAmmo("10")
	Global.userInfo.setSens("1")
	Global.userInfo.setVolume("0.501187")
	Global.userInfo.setH1("0")
	Global.userInfo.setH2("0")
	Global.userInfo.setH3("0")
	Global.userInfo.setH4("0")
	Global.userInfo.setH5("0")
	Global.userInfo.setHud("3")
	Global.userInfo.setRotate("1")
	Global.userInfo.setFire("1")
	Global.userInfo.setColour("0")
	Global.userInfo.setHook("1")
	Global.save_changes()
	_on_Menu_pressed()
	#resets al users attributes

func _on_Hud_item_selected(type):
	Global.button = true
	Global.userInfo.setHud(type)
	#chanegs hud type

func _input(event):
	if event.is_action_pressed("ui_accept"):
		_on_Menu_pressed()
	if event.is_action_pressed("ui_cancel"):
		_on_Menu_pressed()
	#loads menu

func _on_Menu_pressed():
	Global.button = true
	Global.save_changes()
	Global.rege = 2
	Global.logopen = false
	self.queue_free()
	#loads menu

func _on_Movement_item_selected(type):
	Global.button = true
	 # how to rotate 1 = left and right arrow 2 = a d keys 3=mouse location
	if type == 3:
		$Sens.hide()
	else:
		$Sens.show()
	Global.userInfo.setRotate(type)
	#changes control for movement

func _on_Fire_item_selected(type):
	Global.button = true
	#how to fire 1 = f 2 =space 3 = r 4=mouse click
	Global.userInfo.setFire(type)
	#changes control for firing of shells

func _on_Fullscreen_pressed():
	OS.window_fullscreen = !OS.window_fullscreen
	#toggles fullscreen

func _on_Colour_item_selected(type):
	type = type - 1
	Global.button = true
	Global.userInfo.setColour(type)
	#sets new colour for tank

func _on_Hook_item_selected(index):
	#how to fire 1 = h, 3 = right, 2= shift
	Global.button = true
	Global.userInfo.setHook(index)
	#sets on how hook is fired