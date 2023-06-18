extends Control

func _ready():
	pass 

func _on_Reg_pressed():
	Global.rege = 1
	Global.logopen = false
	self.queue_free()



	
		