extends Node2D

var flowerNode = preload("res://scenes/Flower.tscn")

@onready
var camera := $"../Camera2D"

@onready
var baseX := position.x

@onready
var inventory = $"../../UICanvas/UI/Inventory"

var flowerSpawnGapMin := 500
var flowerSpawnGapMax := 1000
var curFlowerSpawnPos := 300

var clusterMin := 1
var clusterMax := 4
var clusterGapMin := 4
var clusterGapMax := 8

var flowerSpawnChecked := false

func _process(_delta):
	var cameraPos: float = camera.position.x
	position = Vector2(-cameraPos, 0)
	if not flowerSpawnChecked:
		if cameraPos >= curFlowerSpawnPos:
			spawnFlower()
			flowerSpawnChecked = true
	else:
		if cameraPos >= curFlowerSpawnPos + 10:
			flowerSpawnChecked = false
			curFlowerSpawnPos += randi_range(flowerSpawnGapMin, flowerSpawnGapMax)

func spawnFlower():
	var basePosition = -position.x + 100
	for i in randi_range(clusterMin, clusterMax):
		var flowerInstance: Sprite2D = flowerNode.instantiate()
		flowerInstance.randomizeType()
		flowerInstance.position = Vector2(basePosition, randi_range(49, 53))
		add_child(flowerInstance)
		basePosition += randi_range(clusterGapMin, clusterGapMax)

func pickFlower(flower: Sprite2D):
	inventory.addFlower(flower.getType())
	flower.queue_free()
	$HarvestSound.play()
