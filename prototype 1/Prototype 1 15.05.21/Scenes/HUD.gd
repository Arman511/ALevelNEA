extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var hudType = int(Global.userData[13])
var scores = []

# Called when the node enters the scene tree for the first time.

func _ready():
	$ProHUDHP.set_max(int(Global.userData[3]))
	$ProHUDAmmo.set_max(int(Global.userData[2]))
	Global.hp = int(Global.userData[3])
	Global.ammo = int(Global.userData[2])
	Global.cash = 0
	Global.score = 0
	$Unpause.hide()
	$Quit.hide()
	$Over.hide()
	
	scores.append(int(Global.userData[8]))
	scores.append(int(Global.userData[9]))
	scores.append(int(Global.userData[10]))
	scores.append(int(Global.userData[11]))
	scores.append(int(Global.userData[12]))
	pass
	
func _on_Pause_pressed():
	$Pause.hide()
	Global.pause = 1
	$Unpause.show()
	$Quit.show()

func _on_Unpause_pressed():
	$Pause.show()
	Global.pause = 0
	$Unpause.hide()
	$Quit.hide()

func _on_Quit_pressed():
	Global.game = 0
	self.queue_free()

func _process(_delta):
	$Label.text = " Score: "+str(Global.score)+"\n Coins: " + str(Global.cash)
	if hudType == 1:
		$Hud.text = " HP: " + str(Global.hp) + " of "+Global.userData[3] +"\nAmmo: "+ str(Global.ammo) + " of "+ Global.userData[2]
		$ProHUDHP.hide()
		$ProHUDAmmo.hide()
	elif hudType == 2:
		$Hud.hide()
		$ProHUDHP.set_value(Global.hp)
		$ProHUDAmmo.set_value(Global.ammo)
	else:
		$Hud.text = " HP: " + str(Global.hp) + " of "+Global.userData[3] +"\n Ammo: "+ str(Global.ammo) + " of "+ Global.userData[2]
		$ProHUDHP.set_value(Global.hp)
		$ProHUDAmmo.set_value(Global.ammo)
	if Global.hp <= 0:
		Global.hp = 0
		if Global.pause == 0:
			Global.pause = 1
			$Pause.hide()
			changes()


func _on_Menu_pressed():
	Global.game = 0
	self.queue_free()

func _on_Restart_pressed():
	Global.newGame = 1
	self.queue_free()

func changes():
	$Over.show()
	var change = false
	scores.append(Global.score)
	Global.userData[1] = str(int(Global.userData[1])+Global.cash)
	$Over/TotalCash.text = "Total cash is " + str(Global.userData[1])

	for i in range(scores.size()-1, -1, -1):
		for j in range(1,i+1,1):
			var notes = scores[j]
			var prevnotes = scores[j-1]
			if notes > prevnotes:
				var temp = scores[j-1]
				scores[j-1] = scores[j]
				scores[j] = temp 
				change = true
	for i in len(scores):
		$Over/Scores.text = $Over/Scores.text + str(scores[i]) + "\n"
	if change == true:
		Global.userData[8]= str(scores[0])
		Global.userData[9]= str(scores[1])
		Global.userData[10]=str(scores[2])
		Global.userData[11]=str(scores[3])
		Global.userData[12]=str(scores[4])
	Global.save_changes()
	
