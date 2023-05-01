extends AnimatedSprite2D

@export
var maxSpeed := 1.0
@export
var acceleration := 0.02
@export
var friction := 0.03

var moving := false
var curSpeed := 0.0

@onready
var parallax = $".."

@onready
var camera = $"../Camera2D"

@onready
var clickButton = $"../../UICanvas/UI/GoButton"

var fadeTween
@export
var soundLevel := -10.0
var fadeOutLevel = -100

var inputDisabled := false

func disableInput():
	inputDisabled = true
	
func enableInput():
	inputDisabled = false

func _process(_delta):
	if not inputDisabled and (Input.is_action_pressed("moving") or clickButton.button_pressed):
		if not moving:
			fadeInSound()
		moving = true
	else:
		if moving:
			fadeOutSound()
		moving = false

func fadeInSound():
	if fadeTween:
		fadeTween.kill()
	$CycleSound.play()
	fadeTween = get_tree().create_tween()
	fadeTween.tween_property($CycleSound, "volume_db", soundLevel, 1.0)

func fadeOutSound():
	if fadeTween:
		fadeTween.kill()
	fadeTween = get_tree().create_tween()
	fadeTween.tween_property($CycleSound, "volume_db", fadeOutLevel, 2.0)

func _physics_process(delta):
	if moving:
		curSpeed += acceleration * delta * 60
	else:
		curSpeed -= friction * delta * 60
	curSpeed = clampf(curSpeed, 0.0, maxSpeed)
	if curSpeed > 0:
		play("cycle")
		speed_scale = curSpeed / maxSpeed
	else:
		play("idle")
		speed_scale = 1
	camera.position += Vector2(curSpeed, 0)

func spawnHouse():
	pass
