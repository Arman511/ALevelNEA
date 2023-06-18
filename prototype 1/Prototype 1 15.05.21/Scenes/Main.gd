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

# Declare member variables here. Examples:
# var a = 2
# var b = "text"



# Called when the node enters the scene tree for the first time.
func _ready():
	Global.cleanup()
	
	if Global.logged == false:
		var login = Login.instance()
		var main = get_tree().current_scene
		main.add_child(login)
		Global.logopen = true

	var fileCheck = File.new()
	var doFileExists = fileCheck.file_exists("res://HashPass.dat")
	print(doFileExists)
	var remake = []
	if doFileExists == false:
		for i in 34:
			print(i)
			remake.append("")
		remake[33] = "end"

		var file = File.new()
		file.open("res://HashPass.dat", file.WRITE)
		for g in len(remake):
			file.store_line(remake[g])
		file.close()

	pass # Replace with function body.



	



func _process(_delta):
	if Global.rege == 2: # rege 2 = menu
		if Global.logopen == false:
			var menu = Menu.instance()
			var main = get_tree().current_scene
			main.add_child(menu)
			Global.logopen = true
	if Global.rege == 1: # rege 1 = registrer
		if Global.logopen == false:
			var reges = Registration.instance()
			var main = get_tree().current_scene
			main.add_child(reges)
			Global.logopen = true
	if Global.rege == 0: # rege 0 = Login
		if Global.logopen == false:
			var login = Login.instance()
			var main = get_tree().current_scene
			main.add_child(login)
			Global.logopen = true
	if Global.rege == 3: # rege 3 = shop
		if Global.logopen == false:
			var shop = Shop.instance()
			var main = get_tree().current_scene
			main.add_child(shop)
			Global.logopen = true
	if Global.rege == 4: # rege 4 = scores
		if Global.logopen == false:
			var scores = Scores.instance()
			var main = get_tree().current_scene
			main.add_child(scores)
			Global.logopen = true
	if Global.rege == 5: # rege 5 = settings
		if Global.logopen == false:
			var setting = Settings.instance()
			var main = get_tree().current_scene
			main.add_child(setting)
			Global.logopen = true
	if Global.rege == 6: # rege 6 = account deletion
		if Global.logopen == false:
			var delete = Delete.instance()
			var main = get_tree().current_scene
			main.add_child(delete)
			Global.logopen = true
	if Global.rege == 7: # rege 7= starts game
		if Global.logopen == false:
			var game = Game.instance()
			var main = get_tree().current_scene
			main.add_child(game)
			Global.logopen = true
	if Global.rege == 8: # rege 8= starts controls
		if Global.logopen == false:
			var controls = Controls.instance()
			var main = get_tree().current_scene
			main.add_child(controls)
			Global.logopen = true
	pass

	

	
		
