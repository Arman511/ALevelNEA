extends Control

func _ready():
	var movement = ""
	var shootS = ""
	var hook = ""
	if Global.userInfo.getRotate() == 1:
		movement = "When the Left and Right Arrow Keys are pressed."
		if str(Global.userInfo.getVolume()) != "-1.#INF":
			$Lr.play()
	elif Global.userInfo.getRotate() == 2:
		movement = "When the A and D keys are pressed."
		if str(Global.userInfo.getVolume()) != "-1.#INF":
			$Ad.play()
	else:
		movement = "Using the cursur location."
		if str(Global.userInfo.getVolume()) != "-1.#INF":
			$Mouse.play()
	#plays the speech version of what is shown in controls for movement
	if Global.userInfo.getFire() == 3:
		shootS = "When the R key is pressed."
	elif Global.userInfo.getFire() == 2:
		shootS = "When the Space bar is pressed."
	elif Global.userInfo.getFire() == 1 :
		shootS = "When the F key is pressed."
	else:
		shootS = "When the left mouse button is pressed"
	#loads text for how user fires shells
	if Global.userInfo.getHook() == 1:
		hook = "When H key is pressed."
	elif Global.userInfo.getHook() == 2:
		hook = "When the Shift key is pressed."
	else:
		hook = "Using the right mouse button."
	#loads text on how user fires hook
	var text = " Movement of player is: "+ movement
	text = text + "\n How to shoot the Shell: "+ shootS
	text = text + "\n How fire the hook: " + hook
	text = text + "\n Press 1 in game for Normal Shell, takes 1 ammo."
	text = text + "\n Press 2 in game for Incendiary shell, takes 2 ammo." 
	text = text + "\n Press 3 in game for Large normal shell, takes 3 ammo."
	text = text + "\n To toggle full screen press the m key."
	$Stuff.text = text
	#loads rest of info and writes the node

func _Rotate_Finished():
	if Global.userInfo.getFire() == 3:
		$Rk.play()
	elif Global.userInfo.getFire() == 2:
		$Space.play()
	elif Global.userInfo.getFire() == 1 :
		$Fk.play()
	else:
		$ClickL.play()
	#plays on how user fires shells

func _Fire_Finished():
	if Global.userInfo.getHook() == 1:
		$Hk.play()
	elif Global.userInfo.getHook() == 2:
		$Shift.play()
	else:
		$ClickR.play()
	#plays on how user fires hook

func _Hook_Finished():
	$Shell.play()
	#plays on types of shells

func _on_Shell_finished():
	$Screen.play()
	#plays on how to toggle 
	#fullscreen
	
func _on_Menu_pressed():
	Global.button = true
	Global.rege = 2
	Global.logopen = false
	self.queue_free()
	#loads menu

func _input(event):
	if event.is_action_pressed("ui_accept"):
		_on_Menu_pressed()
	if event.is_action_pressed("ui_cancel"):
		_on_Menu_pressed()
		#loads menu
