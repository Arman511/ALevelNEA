extends KinematicBody2D

export (int) var speed = -100
var velocity = Vector2()
var collision
#stes speed and variables 

func _process(delta):
	velocity += transform.y * speed
	collision = move_and_collide(velocity * delta)
	#moves hook
	if collision:
		if str(collision.collider.name) == "MedKit":
			Global.hp = Global.hp + Global.userInfo.getkitHP()
			if Global.hp > Global.userInfo.getMaxHP():
				Global.hp = Global.userInfo.getMaxHP()
			Global.hook = 0
			Global.mKit = 0
			self.queue_free()
			#if it hits medkit is increases hp and self terminates
		if str(collision.collider.name) == "AmmoKit":
			Global.ammo = Global.ammo + Global.userInfo.getkitAmmo()
			if Global.ammo > Global.userInfo.getMaxShell():
				Global.ammo = Global.userInfo.getMaxShell()
			Global.hook = 0
			Global.aKit = 0
			self.queue_free()
			#if it hits ammokit is increases hp and self terminates

func _on_Out_screen_exited():
	Global.hook = 0
	self.queue_free()
	#if it goes out of the screen it self terminates