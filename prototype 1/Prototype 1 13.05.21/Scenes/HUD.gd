extends Control


var hudType = int(Global.userData[13])
var scores = []

#reset some variables and hide some labels
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
#get the list ready for sorting
	scores.append(int(Global.userData[8]))
	scores.append(int(Global.userData[9]))
	scores.append(int(Global.userData[10]))
	scores.append(int(Global.userData[11]))
	scores.append(int(Global.userData[12]))
	pass
	
#pauses game
func _on_Pause_pressed():
	$Pause.hide()
	Global.pause = 1
	$Unpause.show()
	$Quit.show()

#unpauses game
func _on_Unpause_pressed():
	$Pause.show()
	Global.pause = 0
	$Unpause.hide()
	$Quit.hide()

#makes the game loop end
func _on_Quit_pressed():
	Global.game = 0
	self.queue_free()

#keepsthe scores live
func _process(_delta):
	$Label.text = " Score: "+str(Global.score)+"\n Coins: " + str(Global.cash)
	if hudType == 0:
		$Hud.text = " HP: " + str(Global.hp) + " of "+Global.userData[3] +"\nAmmo: "+ str(Global.ammo) + " of "+ Global.userData[2]
		$ProHUdHP.hide()
		$ProHUDAmmo.hide()
	elif hudType == 1:
		$Hud.hide()
		$ProHUDHP.set_value(Global.hp)
		$ProHUDAmmo.set_value(Global.ammo)
	else:
		$Hud.text = " HP: " + str(Global.hp) + " of "+Global.userData[3] +"\n Ammo: "+ str(Global.ammo) + " of "+ Global.userData[2]
		$ProHUDHP.set_value(Global.hp)
		$ProHUDAmmo.set_value(Global.ammo)
	if Global.hp == 0:
		if Global.pause == 0:
			Global.pause = 1
			$Pause.hide()
			changes()

#goes back to menu
func _on_Menu_pressed():
	Global.game = 0
	self.queue_free()

#restart game loop
func _on_Restart_pressed():
	Global.newGame = 1
	self.queue_free()

#makes the text box show your scores in order
func changes():
	var change = false
	scores.append(Global.score)
	
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
		$Scores.text = $Scores.text + str(scores[i]) + "\n"
	if change == true:
		Global.userData[8]= str(scores[0])
		Global.userData[9]= str(scores[1])
		Global.userData[10]=str(scores[2])
		Global.userData[11]=str(scores[3])
		Global.userData[12]=str(scores[4])
	Global.save_changes()