extends Control

var hudType = int(Global.userData[13])

func _ready(): # gets everything ready
	$ProHUDHP.set_max(int(Global.userData[3]))
	$ProHUDAmmo.set_max(int(Global.userData[2]))
	Global.hp = int(Global.userData[3])
	Global.ammo = int(Global.userData[2])
	Global.cash = 0
	Global.score = 0
	$Unpause.hide()
	$Quit.hide()
	pass
	
#allow you to pause
func _on_Pause_pressed():
	$Pause.hide()
	Global.pause = 1
	$Unpause.show()
	$Quit.show()

	#unpause
func _on_Unpause_pressed():
	$Pause.show()
	Global.pause = 0
	$Unpause.hide()
	$Quit.hide()
#allows you to quit
func _on_Quit_pressed():
	Global.game = 0
	self.queue_free()
#the process that keeps the HUD accurate
func _process(_delta):
	$Label.text = " Score: "+str(Global.score)+"\n Coins: " + str(Global.cash)
	if hudType == 0:
		$Hud.text = "HP: " + str(Global.hp) + " of "+Global.userData[3] +"\n Ammo: "+ str(Global.ammo) + " of "+ Global.userData[2]
		$ProHUDHP.hide()
		$ProHUDAmmo.hide()
	elif hudType == 1:
		$Hud.hide()
		$ProHUDHP.set_value(Global.hp)
		$ProHUDAmmo.set_value(Global.ammo)
	else:
		$Hud.text = "HP: " + str(Global.hp) + " of "+Global.userData[3] +"\n Ammo: "+ str(Global.ammo) + " of "+ Global.userData[2]
		$ProHUDHP.set_value(Global.hp)
		$ProHUDAmmo.set_value(Global.ammo)
	
	

	
