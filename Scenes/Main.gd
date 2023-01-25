extends Control

const Login = preload("res://Scenes/Login.tscn")
const Registration = preload("res://Scenes/Registration.tscn")
const Menu = preload("res://Scenes/Menu.tscn")
const Shop = preload("res://Scenes/Shop.tscn")
const Scores = preload("res://Scenes/Scores.tscn")
const Settings = preload("res://Scenes/Settings.tscn")
const Delete = preload("res://Scenes/Delete.tscn")
const Game = preload("res://Scenes/Game.tscn")
const Controls = preload("res://Scenes/Controls.tscn")
const Credits = preload("res://Scenes/Credits.tscn")
const Lore = preload("res://Scenes/Lore.tscn")
var rng = RandomNumberGenerator.new()
#these are the file locations of scenes that are instanced my main

func _ready():
	Global.rege = 0 #resets which scene the main has loads
	backdrop()#loads background
	OS.set_window_title("Zombie Shooter By Arman")
	#changes title of window to it
	$Background.show()
	#makes the background  show
	get_tree().paused = false
	#makes sure the game is not paused
	Global.cleanup()
	#cleans up the userData file
	if Global.logged == false:
		self.add_child(Login.instance())
		Global.logopen = true
	#if someones is not logged in it opens the login scene
	var fileCheck = File.new()
	var doFileExists = fileCheck.file_exists("res://HashPass.dat")
	var remake = []
	if doFileExists == false:
		for i in 34:
			remake.append("")
		remake[33] = "end"
		var file = File.new()
		file.open("res://HashPass.dat", file.WRITE)
		for g in len(remake):
			file.store_line(remake[g])
		file.close()
	#checks if the hashPass file exists and if it doesn't it makes one

func backdrop():
	rng.randomize()
	$Background.frame = rng.randi_range(0,5)
	$Objects/RightTank.frame = rng.randi_range(0,8)
	$Objects/LeftTank.frame = rng.randi_range(0,8)
	$Objects/RightTank/Bullet.frame = rng.randi_range(0,5)
	$Objects/LeftTank/Bullet.frame = rng.randi_range(0,5)
	#randomises the bakcground for variety

func _on_Music_finished():
	if Global.game == 0:
		$Music.play()
	else:
		$Music.stop()
	#if menu music is finished it loops
	#it if the game loop is not loaded

func _process(_delta):
	if Global.logged == true:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), Global.userInfo.getVolume())
	#changes the volume
	if Global.rege != 7:
		$Objects.show()
		#if the game scene is
		#not loaded the objects
		#are shown
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)  
		#makes mouse visible
	var flag = false
	if Global.logged == true:
		if str(Global.userInfo.getVolume()) != "-1.#INF":
			if Global.rege != 0:
				if Global.rege != 1:
					if Global.rege != 7:
						if Global.rege != 8:
							if Global.rege != 10:
								$Music.stream_paused = false
								flag = true
								if $Music.playing == false:
									$Music.play()
	#makes sure mane music plays in scene that have it
	if flag == false:
		$Music.stream_paused = true
	#if music is not to play it pauses it					
	if Global.logopen == false:
		Global.logopen = true
		backdrop()
		if Global.rege == 0:
			self.add_child(Login.instance())
			$Music.stop()
			if OS.window_fullscreen == true:
				OS.window_fullscreen = !OS.window_fullscreen
		#if on login is forces it to not be in fullscreen
		elif Global.rege == 1:
			self.add_child(Registration.instance())
			$Music.stop()
		elif Global.rege == 2:
			self.add_child(Menu.instance())
		elif Global.rege == 3:
			self.add_child(Shop.instance())
		elif Global.rege == 4:
			self.add_child(Scores.instance())
		elif Global.rege == 5:
			self.add_child(Settings.instance())
		elif Global.rege == 6:
			self.add_child(Delete.instance())
		elif Global.rege == 7:
			self.add_child(Game.instance())
			backdrop()
			$Objects.hide()
			get_tree().paused = false	
			#hides objects for game loop
		elif Global.rege == 8:
			self.add_child(Controls.instance())
		elif Global.rege == 9:
			self.add_child(Credits.instance())
		elif Global.rege == 10:
			self.add_child(Lore.instance())	
	#instaces the scenes when needed		
	if Global.button == true:
		Global.button = false
		if Global.rege != 0:
			if Global.rege != 1:
				$SFXButton.play()
	#plays button sfx when buttons are pressed	
	pass

func _input(event):
	if Global.logged == true:
		if Global.rege !=6:
			if event.is_action_pressed("ui_m"):
				OS.window_fullscreen = !OS.window_fullscreen
	#if logged in and m is pressed it toggles fullscreen
