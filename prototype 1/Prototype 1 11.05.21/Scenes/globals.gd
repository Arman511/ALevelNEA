extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var logopen = false
var rege = 0
var logged = false
var userData = []
var shopOpen = false
var newHP = 0
var newHP_cost = int(newHP*1.5)
var newAmmo = 0
var newAmmo_cost = int(newAmmo*1.5)
var newMed = 0
var newMed_cost = int(newMed*2)
var newAmmok = 0
var newAmmok_cost = int(newAmmok*1.5)
# Called when the node enters the scene tree for the first time.

func cleanup():
	var file = File.new()
	file.open("res://userData.txt", file.READ)
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
	
	file.open("res://userData.txt", file.WRITE)
	for g in len(content):
		file.store_line(content[g])
	file.close()
	

func hashedLocation(user):
	var file = File.new()
	file.open("res://HashPass.txt", file.READ)
	var content = []
	content = file.get_as_text().split("\n",true)
	print(content)
	file.close()
	var listUser = []
	for g in len(user):
		listUser.append(user[g])
	var num = 0
	for i in len(listUser):
		num = num + ord(listUser[i])
	while num > 33:
		num = num /33
	print(num)
	var count = 0
	var loop = true
	while loop == true:
		if num >= 33:
			num = 0
		count = count + 1
		print(count)
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
	 


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
