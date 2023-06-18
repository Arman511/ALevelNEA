extends Node



var logopen = false
var rege = 0
var logged = false


func cleanup(): # cleans up the file
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
	while num > 20:
		num = num /19
	print(num)
	var count = 0
	var loop = true
	while loop == true:
		if num >= 19:
			num = 0
		count =+ 1
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
	 



