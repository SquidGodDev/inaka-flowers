extends Sprite2D

enum FLOWER_TYPE {
	blue,
	red,
	purple,
	yellow
}

@export
var blueTexture: Texture

@export
var redTexture: Texture

@export
var purpleTexture: Texture

@export
var yellowTexture: Texture

var clicked := false
var flowerType: FLOWER_TYPE

func randomizeType():
	flowerType = FLOWER_TYPE.values()[randi_range(0, FLOWER_TYPE.size()-1)] as FLOWER_TYPE
	match flowerType:
		FLOWER_TYPE.blue:
			texture = blueTexture
		FLOWER_TYPE.red:
			texture = redTexture
		FLOWER_TYPE.purple:
			texture = purpleTexture
		FLOWER_TYPE.yellow:
			texture = yellowTexture

func getType():
	return flowerType

func _on_area_2d_mouse_entered():
	if clicked:
		return

	self_modulate = Color.from_hsv(0, 0, .9, 1)

func _on_area_2d_mouse_exited():
	self_modulate = Color.from_hsv(0, 0, 1, 1)

func _on_area_2d_input_event(_viewport, event, _shape_idx):
	if clicked:
		return

	if event is InputEventMouseButton and event.pressed:
		clicked = true
		self_modulate = Color.from_hsv(0, 0, 1, 1)
		get_parent().pickFlower(self)
