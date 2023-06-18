extends Control

func _ready():
	$Label1.hide()
	$Label2.hide()
	pass

func _on_Log_pressed(): # checks to see if that username exists the tells us if it is false
	var user = $Userbox.text#or not, then tries to find the hashed password in hash table
	var find = searchUser(user)# if it does i plan to make it open the menu next
	if find == false:
		$Label2.show()
		yield(get_tree().create_timer(2.0), "timeout")
		Global.rege = 1
		Global.logopen = false
		self.queue_free()
	var passw = $Passbox.text
	var hashed = passw.sha256_text()
	var listUser = []
	for g in len(user):
		listUser.append(user[g])
	var num = 0
	for i in len(listUser):
		num = num + ord(listUser[i])
	while num > 33:
		num = num /33
	var file = File.new()
	file.open("res://HashPass.txt", file.READ)
	var content = []
	content = file.get_as_text().split("\n",true)
	print(content)
	file.close()
	var count = 0
	var loop = true
	while loop == true:
		if num >= 33:
			num = 0
		count = count + 1
		print(count)
		if content[num] == hashed:
			Global.logged = true
			break
		elif content[num] == "":
			break
		elif content[num] == " ":
			break
		elif content[num] == "end":
			num = 0
		if count > 10:
			return false
		num = num +1
	if Global.logged == true:
		$Label1.show()
		yield(get_tree().create_timer(2.0), "timeout")
		Global.rege = 1
		Global.logopen = false
		self.queue_free()
	else:
		$Label2.show()
		yield(get_tree().create_timer(2.0), "timeout")
		Global.rege = 0
		Global.logopen = false
		self.queue_free()

func searchUser(user): # see if given username matches one in file
	var file = File.new()
	file.open("res://userData.txt", file.READ)
	var content = file.get_as_text()
	file.close()
	var users = content.split("\n",true)
	var userline = users[0]
	for i in len(users):
		userline = users[i]
		userline = userline.split(",",true)
		if  userline[0] == user:
			Global.userData = userline
			return true
		if  userline[0] == "":
			return false
		if  userline[0] == " ":
			return false
	return true

func _on_Reg_pressed(): # opens registration scene
	Global.rege = 1
	Global.logopen = false
	self.queue_free()

