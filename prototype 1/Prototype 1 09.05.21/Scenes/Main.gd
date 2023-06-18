extends Node2D

const Login = preload("res://Scenes/Login.tscn")
const Registration = preload("res://Scenes/Registration.tscn")




var a = 2
#launchs the login scene
func _ready():
	if Global.logged == false:
		var login = Login.instance()
		var main = get_tree().current_scene
		main.add_child(login)
		Global.logopen = true
	pass # Replace with function body.


#checks the global variables to see if it needs to launch something 
func _process(_delta):
	if Global.rege == 1:
		if Global.logopen == false:
			var reges = Registration.instance()
			var main = get_tree().current_scene
			main.add_child(reges)
			Global.logopen = true
	if Global.rege == 0:
		if Global.logopen == false:
			var login = Login.instance()
			var main = get_tree().current_scene
			main.add_child(login)
			Global.logopen = true
	pass
