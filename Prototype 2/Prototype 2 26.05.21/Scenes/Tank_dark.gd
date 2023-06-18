extends AnimatedSprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.animation = "default"
	self.playing = false
	self.show()
	pass # Replace with function body.



func _process(_delta):
	if Global.hp <= 0:
		if Global.pause == 0:
			self.animation = "blow"
			self.playing = true
	pass


func _on_Tank_dark_animation_finished():
	self.hide()
	pass # Replace with function body.
