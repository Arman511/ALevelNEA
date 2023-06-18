extends Control

var hudType = int(Global.userData[13])
var scores = []
var getCash = Global.cash
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
	Global.button = true
	yield(get_tree().create_timer(0.14), "timeout")
	$Pause.hide()
	Global.pause = 1
	get_tree().paused = true
	$Unpause.show()
	$Quit.show()

func _on_Unpause_pressed():
	Global.button = true
	yield(get_tree().create_timer(0.14), "timeout")
	$Pause.show()
	Global.pause = 0
	get_tree().paused = false
	$Unpause.hide()
	$Quit.hide()

func _on_Quit_pressed():
	Global.button = true
	yield(get_tree().create_timer(0.14), "timeout")
	Global.game = 0
	Global.pause = 0
	get_tree().paused = false
	self.queue_free()

func _process(_delta):
	$Label.text = " Score: "+str(Global.score)+"\n Coins: " + str(Global.cash)
	if Global.typeShot == 1:
		$TypePic.frame = 0
		$TypeText.text = "Normal"
	if Global.typeShot == 2:
		$TypePic.frame = 1
		$TypeText.text = "Incendiary"	
	if Global.typeShot == 3:
		$TypePic.frame = 2
		$TypeText.text = "Large"	

	
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
			get_tree().paused = true
			
			$Pause.hide()
			
			changes()
			Global.pause = 1
			
			$Death.play()
			

func _on_Menu_pressed():
	Global.button = true
	yield(get_tree().create_timer(0.14), "timeout")
	Global.game = 0
	get_tree().paused = false
	self.queue_free()

func _on_Restart_pressed():
	Global.button = true
	yield(get_tree().create_timer(0.14), "timeout")
	Global.newGame = 1
	get_tree().paused = false
	self.queue_free()

func changes():
	
	if Global.pause == 0:
		Global.pause = 1
		$Over.show()
		var change = false
		scores.append(Global.score)
		
		Global.userData[1] = str(int(Global.userData[1])+Global.cash)
		Global.cash = 0
		
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
	
func _input(event):
	if event.is_action_pressed("ui_1"):
		Global.typeShot = 1
	if event.is_action_pressed("ui_2"):
		Global.typeShot = 2
	if event.is_action_pressed("ui_3"):
		Global.typeShot = 3
