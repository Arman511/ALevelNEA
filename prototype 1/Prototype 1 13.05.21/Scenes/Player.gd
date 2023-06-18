extends KinematicBody2D

const Shell = preload("res://Scenes/Shell.tscn")

export (float) var rotation_speed = 5
var sensativity = int(Global.userData[6])
var rotation_dir = 0
var left = ""
var right = ""
var fire = ""

# gets the correct signals for the player
func _ready():
	if int(Global.userData[14]) == 0:
		left = "ui_right"
		right = "ui_left"
	else:
		right = "ui_a"
		left = "ui_d"

	if int(Global.userData[15]) == 2:
		fire = "ui_r"
	elif int(Global.userData[15]) == 1:
		fire = "ui_space"
	else :
		fire = "ui_f"
	pass # Replace with function body.

#gets the player moving
func _process(delta):
	rotation_speed = 5 * sensativity
	rotation_dir = 0
	if Global.game == 0:
		self.queue_free()
	if Global.pause == 1:
		pass
	elif Input.is_action_pressed(left):
		rotation_dir += 1
	elif Input.is_action_pressed(right):
		rotation_dir -= 1
	elif Input.is_action_pressed(fire):
		if Global.firing == 0:
			if Global.ammo > 0:
				var shell = Shell.instance()
				var main = get_tree().current_scene
				main.add_child(shell)
				shell.global_transform = $Muzzle.global_transform
				Global.firing = 1
				Global.ammo = Global.ammo - 1
	rotation += rotation_dir * rotation_speed * delta
	
