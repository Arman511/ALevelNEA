extends Node2D

const Hud = preload("res://Scenes/HUD.tscn")
const Player = preload("res://Scenes/Player.tscn")
const Zombie = preload("res://Scenes/Zombie.tscn")
const BossZombie = preload("res://Scenes/BossZombie.tscn")
const AmmoKit = preload("res://Scenes/AmmoKit.tscn")
const MedKit = preload("res://Scenes/MedKit.tscn")
#gets all paths to nodes it will instance

var launchZ = 0
var launchA = 0
var launchM = 0
var num = 1.0
var count =1.0
export (float) var time = 0
#loads variable that are global

func waitz():
	yield(get_tree().create_timer(1.5), "timeout")
	launchZ = 0
#wait between spawns of zombies

func waitm():
	yield(get_tree().create_timer(20.0), "timeout")
	launchM = 0
#wait between spawns of medkits

func waita():
	yield(get_tree().create_timer(20.0), "timeout")
	launchA = 0
#wait between spawns of ammokits

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
	Global.boss = false
	Global.typeShot = 1
	#resets all game variables
	self.add_child(Player.instance())
	self.add_child(Hud.instance())
	#instances hud and player
	var loop = true
	while loop == true:
		yield(get_tree().create_timer(3.0), "timeout")
		if Global.pause == 0:
			if Global.boss == false:
				Global.ticks = Global.ticks + 0.5
	#increment game ticks every 3 seconds by 0.5		

func _process(_delta):
	if Global.game == 0:
		Global.rege = 2
		Global.logopen = false
		self.queue_free()
	#makes game load menu is Global.game == 0
	#as that means the game has quit
	elif Global.newGame == 1:
		Global.logopen = false
		self.queue_free()
	#makes itself selfterminate then load again
	elif Global.pause == 1:
		pass
	#make nothing happen as game is paused
	else:
		if Global.zombieNum < 3:
			if Global.boss == false:
				self.add_child(Zombie.instance())
				Global.zombieNum =Global.zombieNum  +  1
			#instances zombies if there are less than 3 on screen
		if launchZ == 0:
			if Global.zombieNum < 20:
				if Global.boss == false:
					#var zombie = Zombie.instance()
					#var main = get_tree().current_scene
					#main.add_child(zombie)
					self.add_child(Zombie.instance())
					Global.zombieNum =Global.zombieNum  +  1
					launchZ = 1
					waitz()
				#instances zombie every 1.5s
		if launchM == 0:
			if Global.mKit == 0:
				if Global.boss == false:
					if Global.hp < Global.userInfo.getMaxHP():
						self.add_child(MedKit.instance())
						Global.mKit = 1
						launchM = 1
						waitm()
					#instances medkit every 10s if player has less than max hp
		if launchA == 0:
			if Global.aKit == 0:
				if Global.boss == false:
					if Global.ammo < Global.userInfo.getMaxShell():
						self.add_child(AmmoKit.instance())
						Global.aKit = 1
						launchA = 1
						waita()
					#instances ammokit every 10s if	payer has less than max ammo
		num = Global.ticks/10
		if num == count:
			if Global.boss == false:
				Global.boss = true
				count = count +1.0
				self.add_child(BossZombie.instance())
				Global.ticks = Global.ticks + 0.5
			#if tisks is a multiple of 10 it loads a boss
