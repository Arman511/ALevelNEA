extends KinematicBody2D




var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	var whereX = rng.randi_range(100,924)
	var whereY = rng.randi_range(100,500)
	
	self.position.x = whereX
	self.position.y = whereY
	yield(get_tree().create_timer(10.0), "timeout")
	Global.mKit = 0
	self.queue_free()
	

	pass 



func _process(_delta):
	
	
	if Global.game == 0:
		self.queue_free()
	
	

	if Global.pause == 1:
		
		if Global.newGame == 1:
			self.queue_free()
		pass
		
	if Global.mKit == 0:
		self.queue_free()
	
	pass
