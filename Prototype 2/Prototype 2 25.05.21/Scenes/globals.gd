extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var logopen = false
var rege = 0
var logged = false
var userData = []
var shopOpen = false
var pause = 0 # if 1 means pause game play, if 0 means let gameplay continue
var game = 0 # 0 means no game, 1 means currenlt playing
var hp = 1
var ammo = 1
var cash = 0
var score = 0
var newGame = 0
var firing = 0
var zombieNum = 0
export (float) var ticks = 0
var hook = 0
var mKit = 0
var aKit = 0



# Called when the node enters the scene tree for the first time.






func cleanup():
	var file = File.new()
	file.open("res://userData.dat", file.READ)
	var content = file.get_as_text()
	content = content.split("\n",true)
	file.close()
	var counter = len(content)-1
	for i in len(content):
		if content[counter] == "":
			content.remove(counter)
		elif content[counter] == " ":
			content.remove(counter)
		counter = counter - 1
	
	file.open("res://userData.dat", file.WRITE)
	for g in len(content):
		file.store_line(content[g])
	file.close()
	
	
	




	

	

func hashedLocation(user):
	var file = File.new()
	file.open("res://HashPass.dat", file.READ)
	var content = []
	content = file.get_as_text().split("\n",true)
	
	file.close()
	var listUser = []
	for g in len(user):
		listUser.append(user[g])
	var num = 0
	for i in len(listUser):
		num = num + ord(listUser[i])
	while num > 32:
		num = num /32
	
	var count = 0
	var loop = true
	while loop == true:
		if num >= 32:
			num = 0
		count = count + 1
		
		if content[num] == "del":
			return num
		elif content[num] == "":
			return num
		elif content[num] == " ":
			return num
		elif content[num] == "end":
			num = 0
		elif count > 10:
			return false
		num = num +1
	 

func save_changes():
	Global.userData[1] = str(int(Global.userData[1])+Global.cash)
	var file = File.new()
	file.open("res://userData.dat", file.READ)
	var content = file.get_as_text()
	content = content.split("\n",true)
	var replacing = Global.userData[0]+","+Global.userData[1]+","+Global.userData[2]+","+Global.userData[3]+","+Global.userData[4]+","+Global.userData[5]+","+Global.userData[6]+","+Global.userData[7]+","+Global.userData[8]+","+Global.userData[9]+","+Global.userData[10]+","+Global.userData[11]+","+Global.userData[12]+","+Global.userData[13]+","+Global.userData[14]+","+Global.userData[15]

	file.close()
	var counter = len(content)-1
	for i in len(content):
		var splitContent = content[i].split(",",true)
		if splitContent[0] == Global.userData[0]:
			
			content[i] = replacing
		counter = counter - 1
	
	file.open("res://userData.dat", file.WRITE)
	for g in len(content):
		file.store_line(content[g])
	file.close()
	cleanup()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
