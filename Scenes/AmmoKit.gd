extends KinematicBody2D

var hit =false
var rng = RandomNumberGenerator.new()
#gets variables ready

func _ready():
	rng.randomize()
	self.position.x = rng.randi_range(100,1880)
	self.position.y = rng.randi_range(100,980)
	#randomly places ammo kit onto the screen
	yield(get_tree().create_timer(10.0), "timeout")
	Global.aKit = 0
	self.queue_free()
	#self termintes scene afeter 10 seconds.

func _process(_delta):
	if Global.hp <= 0:
		self.queue_free()
	#sees if ammokits are supposed to be there
	#self-terminates if false.
	if hit == false:
		if Global.aKit == 0:
			hit = true
			self.hide()
			$Get.play()
			yield(get_tree().create_timer(0.5), "timeout")
			self.queue_free()
	#sees if it has been hit then plays sfx the selfterminates