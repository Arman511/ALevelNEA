extends Control

func _on_Back_pressed():
	Global.rege = 2
	Global.logopen = false
	self.queue_free()
