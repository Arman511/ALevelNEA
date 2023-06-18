extends Control

func _ready():
	var allScores =[]
	$PersonalScores.text = "1. "+Global.userInfo.getH1()+"\n"+"2. "+Global.userInfo.getH2()+"\n"+"3. "+Global.userInfo.getH3()+"\n"+"4. "+Global.userInfo.getH4()+"\n"+"5. "+Global.userInfo.getH5()+"\n"
	#loads all personal scores into list
	var file = File.new()
	file.open("res://userData.dat", file.READ)
	var content = file.get_as_text()
	content = content.split("\n",true)
	file.close()
	#gets all user data
	for i in len(content)-1:
		var line = content[i]
		line = line.split(",", true)
		var add1 = line[0]+". "+line[8]
		var add2 = line[0]+". "+line[9]
		var add3 = line[0]+". "+line[10]
		var add4 = line[0]+". "+line[11]
		var add5 = line[0]+". "+line[12]
		allScores.append(add1)
		allScores.append(add2)
		allScores.append(add3)
		allScores.append(add4)
		allScores.append(add5)
	#splits them to find username and scores
	for i in range(allScores.size()-1, -1, -1):
		for j in range(1,i+1,1):
			var notes = allScores[j].split(". ", true)
			var prevnotes = allScores[j-1].split(". ", true)
			if int(notes[1]) > int(prevnotes[1]):
				var temp = allScores[j-1]
				allScores[j-1] = allScores[j]
				allScores[j] = temp
	#sorts them by number, highest first
	var scoresOrdered = ""
	for i in len(allScores):
		scoresOrdered = scoresOrdered + allScores[i] + "\n"
	$HighScores.text = scoresOrdered
	#loads score into node

func _input(event):
	if event.is_action_pressed("ui_accept"):
		_on_Back_pressed()
	if event.is_action_pressed("ui_cancel"):
		_on_Back_pressed()
	#goes back to menu when enter or esc pressed
	
func _on_Back_pressed():
	Global.button = true
	Global.rege = 2
	Global.logopen = false
	self.queue_free()
