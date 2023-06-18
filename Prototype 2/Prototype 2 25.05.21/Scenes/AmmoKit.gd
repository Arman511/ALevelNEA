extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"



var collision
var hit =0
var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	var whereX = rng.randi_range(100,924)
	var whereY = rng.randi_range(100,500)
	
	self.position.x = whereX
	self.position.y = whereY
	yield(get_tree().create_timer(10.0), "timeout")
	Global.aKit = 0
	self.queue_free()
	

	pass # Replace with function body.



func _process(_delta):
	
	
	if Global.game == 0:
		self.queue_free()
	
	

	
		
	if Global.newGame == 1:
		self.queue_free()
	
	if hit == 0:
		if Global.aKit == 0:
			hit = 1
			self.hide()
			$Get.play()
			yield(get_tree().create_timer(0.5), "timeout")
			self.queue_free()
	
	pass
