extends KinematicBody2D

var velocity = Vector2()
var collision
var rng = RandomNumberGenerator.new()
var hp = Global.score
var yes = true
var target = Vector2(990, 600)
#gets variable ready 

func _ready():
	$ZombieHP.set_max(hp)
	#sets health  on current score.
	
	if str(Global.userInfo.getVolume()) != "-1.#INF":
		$Battle.play()
	#plays boss music
	rng.randomize()
	$Sprite.playing= true
	var where = rng.randi_range(0,1) # 0 means on base 1 = on sides
	if where == 1:
		var side =  rng.randi_range(0,1) # 0 means on left 1 = on right
		if side == 0:
			position.y = rng.randi_range(100,980)
			position.x = 92
		else:
			position.x = 1880
			position.y = rng.randi_range(100,980)
	else:
		var side =  rng.randi_range(0,1) # 0 means on top 1 = on bottom
		if side == 0:
			position.x = rng.randi_range(100,1880)
			position.y = 100
		else:
			position.y = 980
			position.x = rng.randi_range(100,1990)
	#sets position of zombie
	$Sprite.modulate = Color(rng.randf_range(0.5,1),rng.randf_range(0.5,1),rng.randf_range(0.5,1))
	#modulate colour of mob to have slight variations.

func _physics_process(_delta):
	if hp <= 0:
		Global.score = Global.score +30 + int(Global.ticks)
		Global.cash = Global.cash +30 + int(Global.ticks)
		Global.boss = false
		self.queue_free()
	#if it dies it increases score and cash.
	look_at(target)
	velocity = position.direction_to(target)*0.25
	#goes to the target.
	if Global.hp <= 0:
		self.queue_free()
	#if game ends or player dies it self terminates.
	if Global.pause == 1:
		$Sprite.playing= false
		$Battle.stream_paused = true
		pass
	#pasues zmbie if game pauses
	if Global.pause == 0:
		$Battle.stream_paused = false
		$Sprite.playing= true
		#keeps music playing and sprie animated
		collision = move_and_collide(velocity)
		#moves zombie
		$ZombieHP.set_value(hp)
		if collision:
			var item = str(collision.collider.name)
			if item == "Shell":
				if yes == true:
					yes = false
					hp = hp-1
					yield(get_tree().create_timer(0.01), "timeout")
					yes = true
					#if it hits the shell the hp decreases by 1 every 0.01s
			elif item == "Tank":
				Global.hp = Global.hp -100
				self.hide()
				self.position.x =0
				self.position.y =0
				Global.boss = false
				self.queue_free()
				#if it hits the tank decreases hp by 100
func _on_Battle_finished():
		$Battle.play()
		#if battle music has stopped makes it play again
