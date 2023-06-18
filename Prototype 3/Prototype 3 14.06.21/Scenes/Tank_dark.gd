extends AnimatedSprite

func _ready():
	self.animation = "default"
	self.playing = false
	self.show()
	$Label.show()
	pass 
func _process(_delta):
	if Global.hp <= 0:
		if Global.pause == 0:
			$Label.hide()
			self.animation = "blow"
			self.playing = true
	pass
func _on_Tank_dark_animation_finished():
	self.hide()
	pass 
