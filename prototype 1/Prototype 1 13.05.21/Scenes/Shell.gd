extends KinematicBody2D


export (int) var speed = -500
var timer
var hit = 0

func _physics_process(delta):
	position += transform.y * speed * delta
	

func ready():
	yield(get_tree().create_timer(0.1), "timeout")
	Global.firing = 0

func _on_Out_screen_exited():
	Global.firing = 0
	self.queue_free()
