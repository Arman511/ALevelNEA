extends KinematicBody2D

const Shell = preload("res://Scenes/Shell.tscn")
const Hook = preload("res://Scenes/Hook.tscn")

export (float) var rotation_speed = 1
var sensativity = int(Global.userData[6])
var rotation_dir = 0
var left = ""
var right = ""
var fire = ""
var mouseLook = false


# CGet the correct signals for the player
func _ready():
	
	if int(Global.userData[14]) == 1:
		left = "ui_right"
		right = "ui_left"
	elif int(Global.userData[14]) == 2:
		right = "ui_a"
		left = "ui_d"
	else:
		mouseLook = true

	if int(Global.userData[15]) == 3:
		fire = "ui_r"
	elif int(Global.userData[15]) == 2:
		fire = "ui_space"
	elif int(Global.userData[15]) == 1 :
		fire = "ui_f"
	else:
		fire = "click"


	if int(Global.userData[7]) == 50:
		$SFXFire.volume_db = -25
	elif int(Global.userData[7]) < 50:
		var num = 1.0
		num = int(Global.userData[7]) *0.5
		num = -50 + num 
		$SFXFire.volume_db = num
	elif int(Global.userData[7]) > 50:
		var num = 1.0
		num = (int(Global.userData[7])-50) *0.5
		num = -25 + num 
		$SFXFire.volume_db = num
	pass # Replace with function body.




func _process(delta):
	rotation_speed = 5 * sensativity
	rotation_dir = 0
	if Global.game == 0:
		self.queue_free()
	

	if Global.newGame == 1:
		self.queue_free()

	elif mouseLook == false:
		if Input.is_action_pressed(left):
			rotation_dir += 1
		if Input.is_action_pressed(right):
			rotation_dir -= 1
		self.rotation += rotation_dir * rotation_speed * delta
		
	else:
		var target = get_global_mouse_position()
		look_at(target)
		self.rotation = self.rotation +90
			
	
func _input(event):
	if event.is_action_pressed(fire):
		if Global.pause == 0:
			if Global.firing == 0:
				if Global.ammo > 0:
					Global.firing = 1
					var shell = Shell.instance()
					var main = get_tree().current_scene
					main.add_child(shell)
					shell.global_transform = $Muzzle.global_transform
					Global.ammo = Global.ammo -1
					if int(Global.userData[7]) == 0:
						$SFXFire.stop()
					else:
						$SFXFire.play()
					yield(get_tree().create_timer(0.3), "timeout")
					Global.firing = 0
	if event.is_action_pressed("ui_h"):
		if Global.pause == 0:
			if Global.hook == 0:
				Global.hook = 1
				var hook = Hook.instance()
				var main = get_tree().current_scene
				main.add_child(hook)
				hook.global_transform = $Muzzle.global_transform
	
	
