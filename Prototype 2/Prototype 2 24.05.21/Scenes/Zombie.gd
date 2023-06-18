extends KinematicBody2D



var velocity = Vector2()

var collision

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	$Sprite.playing= true
	var where = rng.randi_range(0,1) # 0 means on base 1 = on height
	if where == 1:
		var side =  rng.randi_range(0,1) # 0 means on left 1 = on right
		if side == 0:
			var along =  rng.randi_range(0,600)
			position.y = along
			
		else:
			position.x = 1024
			var along =  rng.randi_range(0,600)
			position.y = along
			
	else:
		var side =  rng.randi_range(0,1) # 0 means on top 1 = on bottom
		if side == 0:
			var along =  rng.randi_range(0,1024)
			position.x = along
		else:
			position.y = 600
			var along =  rng.randi_range(0,1024)
			position.x = along
	

func _physics_process(_delta):
	
	var target = Vector2(512, 400)
	look_at(target)
	var inc = Global.ticks/5
	velocity = position.direction_to(target)*inc
	
	if Global.game == 0:
		self.queue_free()
	
	if Global.hp <= 0:
		self.queue_free()

	if Global.pause == 1:
		$Sprite.playing= false
		if Global.newGame == 1:
			self.queue_free()
		pass
		
	elif position.distance_to(target) > 5:
		collision = move_and_collide(velocity)
	
	if Global.pause == 0:
		$Sprite.playing= true
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

			
			if item == "Shell":
				Global.score = Global.score +1 + int(Global.ticks)
				Global.cash = Global.cash +1 
				Global.zombieNum = Global.zombieNum-1
				self.queue_free()
			elif item == "Tank":
				Global.hp = Global.hp -1
				Global.zombieNum = Global.zombieNum-1
				self.queue_free()
			elif item != "Zombie":
				print(item)
	

	
	





