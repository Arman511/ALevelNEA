extends KinematicBody2D


export (int) var speed = -100
var hit = 0
var playing = 0
var velocity = Vector2()
var collision

func ready():
	$CollisionShape2D.scale.x = 2
	$CollisionShape2D.scale.y = 2
	$Bullet.hide()
	$Sprite.hide()
	yield(get_tree().create_timer(0.1), "timeout")
	Global.firing = 0
	
	
	

func _physics_process(delta):
	if Global.game == 0:
		
		self.queue_free()
	if Global.pause == 1:
		if Global.newGame == 1:
			self.queue_free()
		pass

	velocity += transform.y * speed
	if hit == 0:
		collision = move_and_collide(velocity * delta)
	if hit == 0:
		if collision:
			if str(collision.collider.name) == "Zombie":
				hit = 1
	
	if hit == 1:
		if playing == 0:
			
			$Bullet.hide()
			$Sprite.show()
			$CollisionShape2D.scale.x = 4
			$CollisionShape2D.scale.y = 4
			$Sprite.frame = 0
			$Sprite.playing = true
			playing = 1




func _on_Sprite_animation_finished():
	
	Global.firing = 0
	self.queue_free()



func _on_Out_screen_exited():
	Global.firing = 0
	self.queue_free()
