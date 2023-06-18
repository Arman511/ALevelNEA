extends Control


var allScores =[]

# loads in scores in order
func _ready():
	$PersonalScores.text = "1."+Global.userData[7]+"\n"+"2."+Global.userData[8]+"\n"+"3."+Global.userData[9]+"\n"+"4."+Global.userData[10]+"\n"+"5."+Global.userData[11]+"\n"

	var file = File.new()
	file.open("res://userData.txt", file.READ)
	var content = file.get_as_text()
	file.close()
	var users = content.split("\n",true)
	users.remove(len(users)-1)
	var userline = users[0]
	for i in len(users):
		userline = users[i]
		userline = userline.split(",",true)
		for j in 5:
			name = userline[0]+"."
			var add = []
			add.append(name)
			print(userline[7+j])
			add.append(int(userline[7+j]))
			add.append("\n")
			print("i")
			allScores.append(add)
	
	for i in len(allScores):
		var key = allScores[i][1]
		var j = i-1
		while j >=0:
			while key < allScores[j][1]:
				allScores[j+1] = allScores[j]
				j -= 1
				print("j")
			allScores[j+1] = key
	allScores = allScores.invert()
	allScores = str(allScores)
	allScores.replace("[","")
	allScores.replace("]","")
	print(allScores)

func _on_Back_pressed():
	Global.rege = 2
	Global.logopen = false
	self.queue_free()