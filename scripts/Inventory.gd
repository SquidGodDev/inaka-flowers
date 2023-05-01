extends TextureRect

enum FLOWER_TYPE {
	blue,
	red,
	purple,
	yellow
}

@onready
var blueLabel = $BlueCount
var blueCount := 0

@onready
var redLabel = $RedCount
var redCount := 0

@onready
var purpleLabel = $PurpleCount
var purpleCount := 0

@onready
var yellowLabel = $YellowCount
var yellowCount := 0

func addFlower(flowerType):
	match flowerType:
		FLOWER_TYPE.blue:
			blueCount += 1
			if blueCount > 99:
				blueCount = 99
			blueLabel.text = str(blueCount)
		FLOWER_TYPE.red:
			redCount += 1
			if redCount > 99:
				redCount = 99
			redLabel.text = str(redCount)
		FLOWER_TYPE.purple:
			purpleCount += 1
			if purpleCount > 99:
				purpleCount = 99
			purpleLabel.text = str(purpleCount)
		FLOWER_TYPE.yellow:
			yellowCount += 1
			if yellowCount > 99:
				yellowCount = 99
			yellowLabel.text = str(yellowCount)

func hasFlowers():
	return (blueCount != 0) or (redCount != 0) or (purpleCount != 0) or (yellowCount != 0)
	
func giveRandomFlower():
	var availableFlowers = []
	if blueCount != 0:
		availableFlowers.append(FLOWER_TYPE.blue)
	if redCount != 0:
		availableFlowers.append(FLOWER_TYPE.red)
	if purpleCount != 0:
		availableFlowers.append(FLOWER_TYPE.purple)
	if yellowCount != 0:
		availableFlowers.append(FLOWER_TYPE.yellow)
	
	var selectedType = availableFlowers[randi_range(0, availableFlowers.size()-1)]
	match selectedType:
		FLOWER_TYPE.blue:
			blueCount -= 1
			blueLabel.text = str(blueCount)
			$BlueParticle.emitting = true
		FLOWER_TYPE.red:
			redCount -= 1
			redLabel.text = str(redCount)
			$RedParticle.emitting = true
		FLOWER_TYPE.purple:
			purpleCount -= 1
			purpleLabel.text = str(purpleCount)
			$PurpleParticle.emitting = true
		FLOWER_TYPE.yellow:
			yellowCount -= 1
			yellowLabel.text = str(yellowCount)
			$YellowParticle.emitting = true
