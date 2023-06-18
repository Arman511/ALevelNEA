extends KinematicBody2D

export (int) var speed = -100
var hit = false
var playing = false
var velocity = Vector2()
var collision
#sets variables

func ready():
	$CollisionShape2D.scale.x = 2
	$CollisionShape2D.scale.y = 2
	$Bullet.show()
	$Sprite.hide()
	#resets everything

func _physics_process(delta):
	velocity += transform.y * speed
	if Global.pause == 1:
		pass
		#makes it stop movement if game is paused
	elif hit == false:
		collision = move_and_collide(velocity * delta)
		if collision:
			if str(collision.collider.name) == "Zombie":
				hit = true
	else:
		if playing == false:
			playing = true
			$Bullet.hide()
			$Sprite.frame = 0
			$Sprite.show()
			$Sprite.playing = true
			#hides bullet and makes explosion animation play

func _on_Sprite_animation_finished():
	self.queue_free()
	#once animation stops it self termineates

func _on_Out_screen_exited():
	self.queue_free()
	#once it outside window it self terminates