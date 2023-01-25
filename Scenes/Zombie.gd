extends KinematicBody2D

var velocity = Vector2()
var collision
var rng = RandomNumberGenerator.new()
var hit = false
var target = Vector2(990, 600)
#gets variable ready

func _ready():
	rng.randomize()
	#makes zombie animation play
	var where = rng.randi_range(0,1) # 0 means on base 1 = on sides
	if where == 1:
		var side =  rng.randi_range(0,1) # 0 means on left 1 = on right
		if side == 0:
			var along =  rng.randi_range(0,1080)
			position.y = along
		else:
			position.x = 1980
			var along =  rng.randi_range(0,1080)
			position.y = along
	else:
		var side =  rng.randi_range(0,1) # 0 means on top 1 = on bottom
		if side == 0:
			var along =  rng.randi_range(0,1980)
			position.x = along
		else:
			position.y = 1080
			var along =  rng.randi_range(0,1980)
			position.x = along
	#sets position of zombie
	$Sprite.modulate = Color(rng.randf_range(0.5,1),rng.randf_range(0.5,1),rng.randf_range(0.5,1))
	#modulates zombies colour

func _physics_process(_delta):
	look_at(target)
	#makes it look at player
	var inc = Global.ticks/5
	#increases speed at number of game ticks
	velocity = position.direction_to(target)*inc
	#plans on where it moves this cycle
	if Global.game == 0:
		self.queue_free()
		#self terminate if game ends
	if Global.hp <= 0:
		self.queue_free()
		#self terminate if game if player dies
	if Global.pause == 1:
		$Sprite.playing= false
		#pauses aniation as game is paused
		if Global.newGame == 1:
			self.queue_free()
			#self terminate if game resets
		pass
	elif position.distance_to(target) > 5:
		collision = move_and_collide(velocity)
		#moves player and finds collisions
	if Global.pause == 0:
		$Sprite.playing= true
		#keeps animation playing
		if collision:
			var item = str(collision.collider.name)
			item = item.replace("@","")
			item = item.replace("1","")
			item = item.replace("2","")
			item = item.replace("3","")
			item = item.replace("4","")
			item = item.replace("5","")
			item = item.replace("6","")
			item = item.replace("7","")
			item = item.replace("8","")
			item = item.replace("9","")
			item = item.replace("0","")
			#removes  any metadata from colliders name
			if hit ==false:
				if item == "Shell":
					hit = true
					Global.score = Global.score + int(Global.ticks)
					Global.cash = Global.cash +1 
					Global.zombieNum = Global.zombieNum-1
					self.hide()
					self.position.x =0
					self.position.y =0
					$SFXDie.play()
					yield(get_tree().create_timer(0.45), "timeout")
					self.queue_free()
					#increases score and cash then 
					#then plays death sfx then self terminates 
				elif item == "Tank":
					hit = true
					Global.hp = Global.hp -1
					Global.zombieNum = Global.zombieNum-1
					self.hide()
					self.position.x =0
					self.position.y =0
					$SFXEat.play()
					yield(get_tree().create_timer(1.3), "timeout")
					self.queue_free()
					#decrease hp by 1 then plays eat sfx then selfterminates