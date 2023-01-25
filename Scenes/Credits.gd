extends Control

func _on_Back_pressed():
	Global.rege = 2
	Global.logopen = false
	Global.button = true
	self.queue_free()
	#loads menu
	
func _input(event):
	if event.is_action_pressed("ui_accept"):
		_on_Back_pressed()
	if event.is_action_pressed("ui_cancel"):
		_on_Back_pressed()
	#loads menu