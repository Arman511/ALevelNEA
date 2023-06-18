extends KinematicBody2D

const Shell = preload("res://Scenes/Shell.tscn")
const Hook = preload("res://Scenes/Hook.tscn")
const ShellFire = preload("res://Scenes/ShellFire.tscn")
const ShellLarge = preload("res://Scenes/ShellLarge.tscn")
#loads scenes that instanced from here
export (float) var rotation_speed
#makes the multiplier for rotation_speed
var rotation_dir = 0
#makes variable for rotation of player
var tleft = ""
var tright = ""
#variable that sets keybind for rotation
var tfire = ""
#variable that sets keybind to fire shells
var thook = ""
#variable that seys keybind to fire hook
var mouseLook = false
#variable that tells if user is using mouse to rotate
var target = Vector2()
#sets its location
var collision
#makes a collison box
onready var main = get_tree().current_scene
#gets game scene to instance items to 

func _ready():
	rotation_speed = Global.userInfo.getSens()*5
	$Blue.disabled = true
	$Red.disabled = true
	$Green.disabled = true
	#switches of all collisions boxes off
	$Tank_dark.animation = "default"
	#sets sprite to tanks sprites
	$Tank_dark.frame = Global.userInfo.getColour()
	#sets colour of tank to users selected
	$Scope.frame = Global.userInfo.getColour()
	#sets scope to colour of tank
	$Tank_dark.playing = false
	#makes it not play animation
	$Tank_dark.show()
	#makes tank visable
	$Scope.show()
	#makes scope visable
	if Global.userInfo.getColour() == 0:
		$Green.disabled = false
	elif Global.userInfo.getColour() == 1:
		$Blue.disabled = false
	elif Global.userInfo.getColour() == 2:
		$Blue.disabled = false
	elif Global.userInfo.getColour() == 3:
		$Green.disabled = false
	elif Global.userInfo.getColour() == 4:
		$Red.disabled = false
	elif Global.userInfo.getColour() == 5:
		$Red.disabled = false
	elif Global.userInfo.getColour() == 6:
		$Red.disabled = false
	elif Global.userInfo.getColour() == 7:
		$Green.disabled = false
	elif Global.userInfo.getColour() == 8:
		$Blue.disabled = false
	#different colour have different tank shapes
	#there are 3 tank shapes and this switches on
	#the correct one
	if Global.userInfo.getRotate() == 1:
		tleft = "ui_right"
		tright = "ui_left"
		#sets rotation keybind to left and right arrow keys
	elif Global.userInfo.getRotate() == 2:
		tright = "ui_a"
		tleft = "ui_d"
		#sets rotation keybind to a and d keys
	else:
		mouseLook = true
		#sets movement to mouse position
	if Global.userInfo.getFire() == 3:
		tfire = "ui_r"
		#sets keybind to fire shell to r
	elif Global.userInfo.getFire() == 2:
		tfire = "ui_space"
		#sets keybind to fire shell to space
	elif Global.userInfo.getFire() == 1:
		tfire = "ui_f"
		#sets keybind to fire shell to f
	else:
		tfire = "ui_left_click"
		#sets keybind to fire shell to left click
	if Global.userInfo.getHook() == 1:
		thook = "ui_h"
		#sets keybind to fire hook to h
	elif Global.userInfo.getHook() == 2:
		thook = "ui_shift"
		#sets keybind to fire hook to shift
	else:
		thook = "ui_right_click"
		#sets keybind ot fire hool to right click

func _process(delta):
	rotation_dir = 0
	#sets change to 0
	if Global.hp <= 0:
		if Global.pause == 0:
			$Scope.hide()
			#hides scope when player dies
			$Tank_dark.animation = "blow"
			#sets animation to to blowing up
			$Tank_dark.frame = 0
			#sets animation to start
			$Tank_dark.playing = true
			#makes animation play	
	if mouseLook == false:
		if Input.is_action_pressed(tleft):
			rotation_dir += 1
		if Input.is_action_pressed(tright):
			rotation_dir -= 1
		self.rotation += rotation_dir * rotation_speed * delta
		#rotates player on movement
	else:
		if Global.pause == 0:
			look_at(get_global_mouse_position())
			#makes player look at mouse
			$Scope.position = self.get_local_mouse_position()
			#makes scope position be off the mouse
			Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
			#hides mouse invisable
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)	
			#makes mouse visable 

func _input(event):
	if event.is_action_pressed(tfire):
		if Global.pause == 0:
			if Global.firing == 0:
				if Global.typeShot == 1:
					if Global.ammo > 0:
						Global.firing = 1
						var shell = Shell.instance()
						main.add_child(shell)
						shell.global_transform = $Muzzle.global_transform
						Global.ammo = Global.ammo -1
						$SFXFire.play()
						yield(get_tree().create_timer(0.3), "timeout")
						Global.firing = 0
						#fires normal shell
				elif Global.typeShot == 2:
					if Global.ammo > 1:
						Global.firing = 1
						var shellfire = ShellFire.instance()
						main.add_child(shellfire)
						shellfire.global_transform = $Muzzle.global_transform
						Global.ammo = Global.ammo -2
						$SFXFire.play()
						yield(get_tree().create_timer(1.0), "timeout")
						Global.firing = 0
						#fires incindiery shell
				elif Global.typeShot == 3:
					if Global.ammo > 2:
						Global.firing = 1
						var shelllarge = ShellLarge.instance()
						main.add_child(shelllarge)
						shelllarge.global_transform = $Muzzle.global_transform
						Global.ammo = Global.ammo -3
						$SFXFire.play()
						yield(get_tree().create_timer(0.6), "timeout")
						Global.firing = 0
						#fire large shell
	if event.is_action_pressed(thook):
		if Global.pause == 0:
			if Global.hook == 0:
				Global.hook = 1
				var hook = Hook.instance()
				main.add_child(hook)
				hook.global_transform = $Muzzle.global_transform
				#fires hook

func _on_Tank_dark_animation_finished():
	$Tank_dark.hide()
	#hides tank after explosion
