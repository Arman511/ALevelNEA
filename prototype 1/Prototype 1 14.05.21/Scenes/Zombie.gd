extends KinematicBody2D

export (int) var speed = 100
var velocity = Vector2()
var collision
var hit = 0
var rng = RandomNumberGenerator.new()

#decides the place of starting for zombie
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

#makes it move and disapear if hit
#if hit give score and cash
func _physics_process(delta):
	var target = Vector2(512, 400)
	look_at(target)
	velocity = position.direction_to(target)
	
	if position.distance_to(target) > 5:
		collision = move_and_collide(velocity)
	
	if collision:
		if str(collision.collider.name) == "Shell":
			hit = 1
		if str(collision.collider.name) == "Tank":
			Global.hp = Global.hp -1
			self.queue_free()
	if hit == 1:	
		Global.score = Global.score +1 + int(Global.ticks)
		Global.cash = Global.cash +1 + int(Global.ticks)
		Global.zombieNum = Global.zombieNum-1
		self.queue_free()

	if Global.game == 0:
		Global.rege = 2
		Global.logopen = false
		self.queue_free()
	if Global.pause == 1:
		$Sprite.playing= false
		pass
	
	




