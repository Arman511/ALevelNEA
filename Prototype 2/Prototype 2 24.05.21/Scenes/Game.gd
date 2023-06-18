extends Node2D

const Hud = preload("res://Scenes/HUD.tscn")
const Player = preload("res://Scenes/Player.tscn")
const Zombie = preload("res://Scenes/Zombie.tscn")

const AmmoKit = preload("res://Scenes/AmmoKit.tscn")
const MedKit = preload("res://Scenes/MedKit.tscn")

var launchZ = 0
var launchA = 0
var launchM = 0
export (float) var time = 0

#wait between spawns of zombies
func waitz():
	yield(get_tree().create_timer(1.5), "timeout")
	launchZ = 0
#wait between spawns of medkits
func waitm():
	yield(get_tree().create_timer(20.0), "timeout")
	launchM = 0
#wait between spawns of ammokits
func waita():
	yield(get_tree().create_timer(20.0), "timeout")
	launchA = 0
# Called when the node enters the scene tree for the first time.

func _ready():
	get_tree().paused = false
	Global.pause = 0
	Global.game = 1
	Global.newGame = 0
	Global.ticks = 0
	Global.zombieNum = 0
	Global.hook = 0
	Global.aKit = 0
	Global.mKit = 0
	var player = Player.instance()
	var main2 = get_tree().current_scene
	main2.add_child(player)

	var hud = Hud.instance()
	var main = get_tree().current_scene
	main.add_child(hud)

	var loop = true
	while loop == true:
		yield(get_tree().create_timer(3.0), "timeout")
		if Global.pause == 0:
			Global.ticks = Global.ticks + 0.5

func _process(_delta):
	if Global.game == 0:
		Global.rege = 2
		Global.logopen = false
		self.queue_free()

	if Global.newGame == 1:
		Global.logopen = false
		self.queue_free()

	else:
		if Global.zombieNum < 5:
			var zombie = Zombie.instance()
			var main = get_tree().current_scene
			main.add_child(zombie)
			Global.zombieNum =Global.zombieNum  +  1
			
			
		if launchZ == 0:
			if Global.zombieNum < 20:
				var zombie = Zombie.instance()
				var main = get_tree().current_scene
				main.add_child(zombie)
				Global.zombieNum =Global.zombieNum  +  1
				launchZ = 1
				waitz()
		if launchM == 0:
			if Global.mKit == 0:
				if Global.hp < int(Global.userData[3]):
					var med = MedKit.instance()
					var main = get_tree().current_scene
					main.add_child(med)
					Global.mKit = 1
					launchM = 1
					waitm()
		if launchA == 0:
			if Global.aKit == 0:
				if Global.ammo < int(Global.userData[2]):
					var ammo = AmmoKit.instance()
					var main = get_tree().current_scene
					main.add_child(ammo)
					Global.aKit = 1
					launchA = 1
					waita()
