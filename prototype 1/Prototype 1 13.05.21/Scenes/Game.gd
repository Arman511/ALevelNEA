extends Node2D

const Hud = preload("res://Scenes/HUD.tscn")
const Player = preload("res://Scenes/Player.tscn")

func _ready():
#reset the variables
	Global.pause = 0
	Global.game = 1
	Global.newGame = 0
#opens the player
	var player = Player.instance()
	var main2 = get_tree().current_scene
	main2.add_child(player)
#opens the HUD
	var hud = Hud.instance()
	var main = get_tree().current_scene
	main.add_child(hud)

func _process(_delta):
	if Global.game == 0:
		Global.rege = 2
		Global.logopen = false
		self.queue_free()
	if Global.pause == 1:
		pass
	if Global.newGame == 1:
		Global.logopen = false
		self.queue_free()
