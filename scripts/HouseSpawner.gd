extends Node2D

var houseNode = preload("res://scenes/House.tscn")

@onready
var camera := $"../Camera2D"

@onready
var inventory = $"../../UICanvas/UI/Inventory"

@onready
var character = $"../Character"

var questionParticles = preload("res://scenes/QuestionParticles.tscn")
var heartParticles = preload("res://scenes/HeartParticles.tscn")

@onready
var knockSound = $"../../KnockSound"
@onready
var doorOpenSound = $"../../DoorOpenSound"
@onready
var happySound = $"../../HappySound"

@onready
var baseX := position.x

@export
var houseSpawnGapMin := 1000.0
var houseSpawnGapMax := 1500.0
var curHouseSpawnPos := 1000.0

var houseSpawnChecked := false

func _process(_delta):
	var cameraPos: float = camera.position.x
	position = Vector2(-cameraPos, 0)
	if not houseSpawnChecked:
		if cameraPos >= curHouseSpawnPos:
			spawnHouse()
			houseSpawnChecked = true
	else:
		if cameraPos >= curHouseSpawnPos + 100:
			houseSpawnChecked = false
			curHouseSpawnPos += randi_range(houseSpawnGapMin, houseSpawnGapMax)

func spawnHouse():
	if get_child_count() > 0:
		var curHouse = get_child(0)
		curHouse.queue_free()
	var houseInstance: Sprite2D = houseNode.instantiate()
	houseInstance.setSpawner(self)
	houseInstance.position = Vector2(-position.x + 100 , 24)
	add_child(houseInstance)

func houseKnocked(house):
	knockSound.play()
	character.disableInput()
	await get_tree().create_timer(0.5).timeout
	var questionInstance = questionParticles.instantiate()
	questionInstance.position = Vector2(10, 0)
	questionInstance.emitting = true
	house.add_child(questionInstance)
	
	if not inventory.hasFlowers():
		character.enableInput()
		return
	
	doorOpenSound.play()
	await get_tree().create_timer(1.5).timeout
	
	
	character.enableInput()
	var heartInstance = heartParticles.instantiate()
	heartInstance.position = Vector2(10, 0)
	heartInstance.emitting = true
	house.add_child(heartInstance)
	
	inventory.giveRandomFlower()
	happySound.play()

