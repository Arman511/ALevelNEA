extends Control



func _ready():
	$Label1.hide()
	$Money.text = "Total Cash:" + str(int(Global.userData[1]))
	 

func _on_Quit_pressed():
	$Label1.show()
	yield(get_tree().create_timer(2.0), "timeout")
	get_tree().quit()
#shellMax(20),HPMax(10),hpKitsize(2),ammokitSize(10)

func _on_Shop_pressed():
	Global.rege = 3
	Global.logopen = false
	self.queue_free()

func _on_Game_pressed():
	Global.rege = 7
	Global.logopen = false
	self.queue_free()

func _on_Settings_pressed():
	Global.rege = 5
	Global.logopen = false
	self.queue_free()

func _on_Controls_pressed():
	Global.rege = 8
	Global.logopen = false
	self.queue_free()

func _on_Scores_pressed():
	Global.rege = 4
	Global.logopen = false
	self.queue_free()
	pass # Replace with function body.
