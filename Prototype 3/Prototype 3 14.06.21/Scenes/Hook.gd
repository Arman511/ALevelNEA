extends KinematicBody2D



export (int) var speed = -100

var velocity = Vector2()
var collision


# Called when the node enters the scene tree for the first time.
func _ready():
	self.scale.x = 0.15
	self.scale.y = 0.15
	pass # Replace with function body.



func _process(delta):
	if Global.game == 0:
		self.queue_free()

	if Global.newGame == 1:
		self.queue_free()

	velocity += transform.y * speed
	
	collision = move_and_collide(velocity * delta)
	
	if collision:
		if str(collision.collider.name) == "MedKit":
			Global.hp = Global.hp + int(Global.userData[4])
			if Global.hp > int(Global.userData[3]):
				Global.hp = int(Global.userData[3])
			Global.hook = 0
			Global.mKit = 0
			self.queue_free()
		if str(collision.collider.name) == "AmmoKit":
			Global.ammo = Global.ammo + int(Global.userData[5])
			if Global.ammo > int(Global.userData[2]):
				Global.ammo = int(Global.userData[2])
			Global.hook = 0
			Global.aKit = 0
			self.queue_free()
			
	
func _on_Out_screen_exited():
	Global.hook = 0
	self.queue_free()
