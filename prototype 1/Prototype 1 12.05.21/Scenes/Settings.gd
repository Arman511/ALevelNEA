extends Control

func _ready(): # adds stuff to the drop down box
	$Hud.add_item("Have only the numbers")
	$Hud.add_item("Have only the bar")
	$Hud.add_item("Have both")


func _process(_delta):
	$Sens.value = int(Global.userData[6])
	$Label.text = "Sensativity of Turret, Currently: " + str(Global.userData[6])
	if Global.userData[7] == "0":
		$Sound.text = "Sound is currently: Off, Press to switch"
	else: 
		$Sound.text = "Sound is currently: On, Press to switch"



func _on_Sens_value_changed(value):
	value = str(value)
	Global.userData[6] = value
	

func _on_Sound_pressed():
	if Global.userData[7] == "0":
		Global.userData[7] = "1"
	else:
		Global.userData[7] = "0"


func _on_Delete_pressed():
	Global.rege = 6
	Global.logopen = false
	self.queue_free()

func _on_Reset_pressed():
	Global.userData[1] = "0"
	Global.userData[2]="20"
	Global.userData[3]="10"
	Global.userData[4]="2"
	Global.userData[5]="10"
	Global.userData[6]="1"
	Global.userData[7]="1"
	Global.userData[8]="0"
	Global.userData[9]="0"
	Global.userData[10]="0"
	Global.userData[11]="0"
	Global.userData[12]="0"
	Global.userData[13]="2"
	_on_Menu_pressed()

func _on_Hud_item_selected(type):
	print(type)
	Global.userData[13] = str(type)


func _on_Menu_pressed():
	var file = File.new()
	file.open("res://userData.txt", file.READ)
	var content = file.get_as_text()
	content = content.split("\n",true)
	var replacing = Global.userData[0]+","+Global.userData[1]+","+Global.userData[2]+","+Global.userData[3]+","+Global.userData[4]+","+Global.userData[5]+","+Global.userData[6]+","+Global.userData[7]+","+Global.userData[8]+","+Global.userData[9]+","+Global.userData[10]+","+Global.userData[11]+","+Global.userData[12]+","+Global.userData[13]

	file.close()
	var counter = len(content)-1
	for i in len(content):
		var splitContent = content[i].split(",",true)
		if splitContent[0] == Global.userData[0]:
			
			content[i] = replacing
		counter = counter - 1
	
	file.open("res://userData.txt", file.WRITE)
	for g in len(content):
		file.store_line(content[g])
	file.close()
	Global.cleanup()
	Global.rege = 2
	Global.logopen = false
	self.queue_free()
	print("hi")
	pass # Replace with function body.

