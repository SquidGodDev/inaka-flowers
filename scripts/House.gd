extends Sprite2D

var clicked := false

@export
var houseTexture: Texture

var spawnerInstance

func setSpawner(spawner):
	spawnerInstance = spawner

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
		texture = houseTexture
		self_modulate = Color.from_hsv(0, 0, 1, 1)
		spawnerInstance.houseKnocked(self)
