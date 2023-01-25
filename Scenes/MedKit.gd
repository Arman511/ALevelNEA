extends KinematicBody2D

var hit =0
var rng = RandomNumberGenerator.new()
#gets varaibels ready

func _ready():
	rng.randomize()
	self.position.x = rng.randi_range(100,1880)
	self.position.y = rng.randi_range(100,980)
	#randomly places medkit on screen
	yield(get_tree().create_timer(10.0), "timeout")
	Global.mKit = 0
	self.queue_free()
	#self termintes scene afeter 10 seconds.

func _process(_delta):
	if Global.hp <= 0:
		self.queue_free()
	#sees if medkit shouldn't exist thnen self terminates
	if hit == 0:
		if Global.mKit == 0:
			hit = 1
			self.hide()
			$Get.play()
			yield(get_tree().create_timer(0.76), "timeout")
			self.queue_free()
	#sees if it has been hit then plays sfx the selfterminates