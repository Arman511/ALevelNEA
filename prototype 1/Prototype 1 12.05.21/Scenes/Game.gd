extends Node2D

const Hud = preload("res://Scenes/HUD.tscn")


func _ready():
	Global.game = 1
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
