extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _on_Back_pressed():
	Global.rege = 2
	Global.logopen = false
	Global.button = true
	yield(get_tree().create_timer(0.14), "timeout")
	self.queue_free()
