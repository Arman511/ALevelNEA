extends Control

func _input(event):
	if event.is_action_pressed("ui_accept"):
		_on_Back_pressed()
	if event.is_action_pressed("ui_cancel"):
		_on_Back_pressed()	
	#loads menu

func _ready():
	$Replay.hide()
	$Skip.show()
	$Fallen.hide()
	$Finished.hide()
	$VideoPlayer.show()
	$VideoPlayer.play()
	#resets videoplayer

func _on_VideoPlayer_finished():
	$VideoPlayer.hide()
	$Skip.hide()
	$Finished.show()
	$Fallen.show()
	$Replay.show()
	#hides videoplayer
	#loads img

func _on_Replay_pressed():
	_ready()
	#replays video

func _on_Replay_mouse_entered():
	$Replay.modulate = Color(0,0,0)
	
func _on_Replay_mouse_exited():
	$Replay.modulate = Color(1,1,1)

func _on_Back_pressed():
	Global.rege = 2
	Global.logopen = false
	Global.button = true
	self.queue_free()
	#loads menu

func _on_Skip_pressed():
	$VideoPlayer.stop()
	_on_VideoPlayer_finished()
	#skips video to img
func _on_Back_mouse_entered():
	$Back.modulate = Color(0,0,0)

func _on_Back_mouse_exited():
	$Back.modulate = Color(1,1,1)

func _on_Skip_mouse_entered():
	$Skip.modulate = Color(0,0,0)

func _on_Skip_mouse_exited():
	$Skip.modulate = Color(1,1,1)
