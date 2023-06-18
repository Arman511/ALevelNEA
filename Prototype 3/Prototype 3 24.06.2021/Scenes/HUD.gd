extends Control

var hudType = Global.userInfo.getHud()
var scores = []
var getCash = Global.cash
#loads global varaibles

func _ready():
	$ProHUDHP.set_max(Global.userInfo.getMaxHP())
	$ProHUDAmmo.set_max(Global.userInfo.getMaxShell())
	Global.hp = int(Global.userInfo.getMaxHP())
	Global.ammo = int(Global.userInfo.getMaxShell())
	Global.cash = 0
	Global.score = 0
	$Unpause.hide()
	$Quit.hide()
	$Over.hide()
	#sets varaibles for nodes and hides pausing and quiting nodes
	if str(Global.userInfo.getVolume()) != "-1.#INF":
		$Play.play()
	#plays game music
	scores.append(int(Global.userInfo.getH1()))
	scores.append(int(Global.userInfo.getH2()))
	scores.append(int(Global.userInfo.getH3()))
	scores.append(int(Global.userInfo.getH4()))
	scores.append(int(Global.userInfo.getH5()))
	#stores current top 5 scores
	pass
	
func _on_Pause_pressed():
	Global.button = true
	$Pause.hide()
	Global.pause = 1
	$Play.stream_paused = true
	get_tree().paused = true
	$Unpause.show()
	$Quit.show()
	#pauses everything when pause is pressed

func _on_Unpause_pressed():
	Global.button = true
	$Pause.show()
	Global.pause = 0
	$Play.stream_paused = false
	get_tree().paused = false
	$Unpause.hide()
	$Quit.hide()
	#upauses everything when pause is pressed

func _on_Quit_pressed():
	Global.button = true
	Global.game = 0
	Global.pause = 0
	get_tree().paused = false
	#quits game loop

func _process(_delta):
	if Global.cash>0:
		$Data.text = " Score: "+str(Global.score)+"\n Coins: " + str(Global.cash)
	#Sets score and cash
	else:
		$Data.text = " Score: "+str(Global.score)
	#sets score
	if Global.typeShot == 1:
		$TypePic.frame = 0
		$TypeText.text = "Normal"
		#sets img to normal shells
	if Global.typeShot == 2:
		$TypePic.frame = 1
		$TypeText.text = "Incendiary"	
		#sets img to Incendiary shells
	if Global.typeShot == 3:
		$TypePic.frame = 2
		$TypeText.text = "Large"
		#sets img to large shells
	if hudType == 1:
		$Hud.text = " HP: " + str(Global.hp) + " of "+str(Global.userInfo.getMaxHP()) +"\nAmmo: "+ str(Global.ammo) + " of "+ str(Global.userInfo.getMaxShell())
		$ProHUDHP.hide()
		$ProHUDAmmo.hide()
		#sets hud values
	elif hudType == 2:
		$Hud.hide()
		$ProHUDHP.set_value(Global.hp)
		$ProHUDAmmo.set_value(Global.ammo)
		#sets hud values
	else:
		$Hud.text = " HP: " + str(Global.hp) + " of "+str(Global.userInfo.getMaxHP()) +"\n Ammo: "+ str(Global.ammo) + " of "+ str(Global.userInfo.getMaxShell())
		$ProHUDHP.set_value(Global.hp)
		$ProHUDAmmo.set_value(Global.ammo)
		#sets hud values
	if Global.hp <= 0:
		Global.hp = 0
		$Play.playing = false
		if Global.pause == 0:
			$Play.playing = false
			if str(Global.userInfo.getVolume()) != "-1.#INF":
				$Death.play()
			get_tree().paused = true
			$Pause.hide()
			changes()
			Global.pause = 1
			#makes game stop as hp is 0
	else:
		if Global.boss == true:
			$Play.stream_paused = true
			#pauses music as boss is on screen
		else:
			if Global.pause != 1:
				$Play.stream_paused = false
				#unpauses music
			
func _on_Menu_pressed():
	Global.button = true
	Global.game = 0
	get_tree().paused = false
	self.queue_free()
	#loads munu

func _on_Restart_pressed():
	Global.button = true
	Global.newGame = 1
	get_tree().paused = false
	self.queue_free()
	#restarts game loop

func changes():
	if Global.pause == 0:
		Global.pause = 1
		$Over.show()
		var change = false
		scores.append(Global.score)
		Global.userInfo.setCash(Global.userInfo.getCash()+Global.cash)
		Global.cash = 0
		$Over/TotalCash.text = "Total cash is " + str(Global.userInfo.getCash())
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
			Global.userInfo.setH1(str(scores[0]))
			Global.userInfo.setH2(str(scores[1]))
			Global.userInfo.setH3(str(scores[2]))
			Global.userInfo.setH4(str(scores[3]))
			Global.userInfo.setH5(str(scores[4]))
		Global.save_changes()
	#saves changes

func _input(event):
	if event.is_action_pressed("ui_1"):
		Global.typeShot = 1
	if event.is_action_pressed("ui_2"):
		Global.typeShot = 2
	if event.is_action_pressed("ui_3"):
		Global.typeShot = 3
	if event.is_action_pressed("ui_cancel"):
		_on_Pause_pressed()
	#chanegs ammo type

func _on_Play_finished():
	$Play.play()
	pass # Replace with function body.
	#replays music

func _on_Death_finished():
	$End.play()
	#plays death music

func _on_End_finished():
	$End.play()
	#replays death music