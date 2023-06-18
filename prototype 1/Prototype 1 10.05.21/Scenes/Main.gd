extends Node2D

const Login = preload("res://Scenes/Login.tscn")
const Registration = preload("res://Scenes/Registration.tscn")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var a = 2
# Called when the node enters the scene tree for the first time.
func _ready():
	Global.cleanup()
	if Global.logged == false:
		Global.logopen = true
		var login = Login.instance()
		var main = get_tree().current_scene
		main.add_child(login)

	pass # Replace with function body.



func _process(_delta):
	
	
	if Global.rege == 0:
		if Global.logopen == false:
			var login = Login.instance()
			var main = get_tree().current_scene
			main.add_child(login)
			Global.logopen = true

	elif Global.rege == 1:
		
		if Global.logopen == false:
			var reges = Registration.instance()
			var main = get_tree().current_scene
			main.add_child(reges)
			Global.logopen = true
	pass
