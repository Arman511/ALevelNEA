extends Control
var type = -1
#makes type invalid
#so if it loads now nothing happens

func _ready():
	$Money.text = "Total Cash:" + str(Global.userInfo.getCash())
	#shows total cash of user

func _on_Logout_pressed():
	Global.button = true
	type = 1
	stop()
	#plays button sfx
	#starts dialog box

func _on_Quit_pressed():
	Global.button = true
	type = 0
	stop()
	#plays button sfx
	#starts dialog box

func stop():
	if type == 0:
		$Change.set_text("Press ok to confirm you are closing the game.")
		$Change.popup()
	if type == 1:
		$Change.set_text("Press ok to confirm you are logging out.")
		$Change.popup()
	#loads dialog for the scenarios

func _on_Change_confirmed():
	Global.button = true
	if type == 0:
		get_tree().quit()
	#if dialog is confirmed
	#for type 0 it quits app
	if type == 1:
		Global.logged = false
		Global.rege = 0
		Global.logopen = false
		self.queue_free()
	#if dialog is confirmed
	#for type 1 it logout user

func _on_Shop_pressed():
	Global.button = true
	Global.rege = 3
	Global.logopen = false
	self.queue_free()
	#loads shop scene

func _on_Game_pressed():
	Global.button = true
	Global.rege = 7
	Global.logopen = false
	self.queue_free()
	#loads game scene

func _on_Settings_pressed():
	Global.button = true
	Global.rege = 5
	Global.logopen = false
	self.queue_free()
	#loads settings scene

func _on_Controls_pressed():
	Global.button = true
	Global.rege = 8
	Global.logopen = false
	self.queue_free()
	#loads controls scene
	
func _on_Credits_pressed():
	Global.button = true
	Global.rege = 9
	Global.logopen = false
	self.queue_free()
	#loads credits scene

func _on_Scores_pressed():
	Global.button = true
	Global.rege = 4
	Global.logopen = false
	self.queue_free()
	#loads scores scene

func _on_Lore_pressed():
	Global.button = true
	Global.rege = 10
	Global.logopen = false
	self.queue_free()
	#loads lore scene