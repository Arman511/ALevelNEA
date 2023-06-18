extends Control



func _ready():#reads variable to show your cash
	$Label1.hide()
	$Money.text = "Total Cash:" + str(int(Global.userData[1]))
	 

func _on_Quit_pressed(): # closes game
	$Label1.show()
	yield(get_tree().create_timer(2.0), "timeout")
	get_tree().quit()
#shellMax(20),HPMax(10),hpKitsize(2),ammokitSize(10)

func _on_Shop_pressed(): # opens shop and closes menu
	Global.rege = 3
	Global.logopen = false
	self.queue_free()

func _on_Scores_pressed(): # planned to work
	pass
