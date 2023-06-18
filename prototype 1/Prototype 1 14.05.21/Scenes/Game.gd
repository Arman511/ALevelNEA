extends Node2D

const Hud = preload("res://Scenes/HUD.tscn")
const Player = preload("res://Scenes/Player.tscn")
const Zombie = preload("res://Scenes/Zombie.tscn")

var launch = 0
export (float) var time = 0

#so that there is a wait betwenn spawns of zombies
func wait():
	yield(get_tree().create_timer(1.5), "timeout")
	launch = 0


func _ready():
	Global.pause = 0
	Global.game = 1
	Global.newGame = 0
	Global.ticks = 0
	var player = Player.instance()
	var main2 = get_tree().current_scene
	main2.add_child(player)

	var hud = Hud.instance()
	var main = get_tree().current_scene
	main.add_child(hud)

	var loop = true
	while loop == true:
		yield(get_tree().create_timer(2.0), "timeout")
		Global.ticks = Global.ticks + 0.5

func _process(_delta):
	print(Global.ticks)
	if Global.game == 0:
		Global.rege = 2
		Global.logopen = false
		self.queue_free()
	if Global.pause == 1:
		pass
	
	if Global.newGame == 1:
		Global.logopen = false
		self.queue_free()
	if Global.game == 1:
		if Global.pause == 0:
			if launch == 0:
				#launches zombies
				if Global.zombieNum < 20:
					var zombie = Zombie.instance()
					var main = get_tree().current_scene
					main.add_child(zombie)
					Global.zombieNum =Global.zombieNum  +  1
					launch = 1
					wait()
