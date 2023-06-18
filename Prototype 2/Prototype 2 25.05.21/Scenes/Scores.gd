extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var allScores =[]

# Called when the node enters the scene tree for the first time.
func _ready():
	$PersonalScores.text = "1. "+Global.userData[8]+"\n"+"2. "+Global.userData[9]+"\n"+"3. "+Global.userData[10]+"\n"+"4. "+Global.userData[11]+"\n"+"5. "+Global.userData[12]+"\n"
	var file = File.new()
	file.open("res://userData.dat", file.READ)
	var content = file.get_as_text()
	content = content.split("\n",true)
	file.close()
	print(content)
	for i in len(content)-1:
		var line = content[i]
		line = line.split(",", true)
		print(line)
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
	
	for i in range(allScores.size()-1, -1, -1):
		for j in range(1,i+1,1):
			var notes = allScores[j].split(". ", true)
			var prevnotes = allScores[j-1].split(". ", true)
			if int(notes[1]) > int(prevnotes[1]):
				var temp = allScores[j-1]
				allScores[j-1] = allScores[j]
				allScores[j] = temp

	print(allScores)
	var scoresOrdered = ""
	for i in len(allScores):
		scoresOrdered = scoresOrdered + allScores[i] + "\n"
	$HighScores.text = scoresOrdered

func _on_Back_pressed():
	Global.rege = 2
	Global.logopen = false
	self.queue_free()
