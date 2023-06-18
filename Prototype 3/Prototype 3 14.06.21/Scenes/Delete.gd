extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _ready():
	$Label1.hide()

func _on_Settings_pressed():
	Global.button = true
	yield(get_tree().create_timer(0.14), "timeout")
	Global.rege = 2
	Global.logopen = false
	self.queue_free()

func searchUser(user): # see if given username matches one in file
	var file = File.new()
	file.open("res://userData.dat", file.READ)
	var content = file.get_as_text()
	file.close()
	var users = content.split("\n",true)
	var userline = users[0]
	for i in len(users):
		userline = users[i]
		userline = userline.split(",",true)
		if  userline[0] == user:
			return true
	return false

func incorrectLogin():
	$Label1.show()
	yield(get_tree().create_timer(2.0), "timeout")
	$Label1.hide()
	$Userbox.text = "Username"
	$Passbox.text = "Password"


func _on_Delete_pressed():
	Global.button = true
	yield(get_tree().create_timer(0.14), "timeout")
	var userName = $Userbox.text
	var passWord = $Passbox.text
	var foundUser = searchUser(userName)
	if foundUser == false:
		incorrectLogin()
		pass
	else:
		var foundPass = realPass(userName, passWord)
		if foundPass == -1:
			incorrectLogin()
			pass
		else:
			Global.userData = []
			var file = File.new()
			file.open("res://userData.dat", file.READ)
			var content = file.get_as_text()
			content = content.split("\n",true)
			
			file.close()
			var counter = len(content)-1
			for i in len(content):
				var splitContent = content[i].split(",",true)
				if splitContent[0] == userName:
					
					content[i] = ""
				counter = counter - 1
			
			file.open("res://userData.dat", file.WRITE)
			for g in len(content):
				file.store_line(content[g])
			file.close()
			Global.cleanup()
			
			
			file.open("res://HashPass.dat", file.READ)
			content = []
			content = file.get_as_text().split("\n",true)
			print(content)
			file.close()

			content[foundPass] = "del"
			file.open("res://HashPass.dat", file.WRITE)
			for i in len(content)-1:
				file.store_line(str(content[i]))
			file.close()
			Global.rege = 0
			Global.logopen = false
			self.queue_free()

		
	


func realPass(user ,passw):
	var hashed = passw.sha256_text()

	var listUser = []
	for g in len(user):
		listUser.append(user[g])
	var num = 0
	for i in len(listUser):
		num = num + ord(listUser[i])
	while num > 32:
		num = num /32

	var file = File.new()
	file.open("res://HashPass.dat", file.READ)
	var content = []
	content = file.get_as_text().split("\n",true)
	print(content)
	file.close()

	
	var count = 0
	var loop = true
	while loop == true:
		if num >= 32:
			num = 0
		count = count + 1
		print(count)
		if content[num] == hashed:
			return  num
		elif content[num] == "":
			return -1
		elif content[num] == " ":
			return -1
		elif content[num] == "end":
			num = 0
		if count > 10:
			return -1
		num = num +1

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
