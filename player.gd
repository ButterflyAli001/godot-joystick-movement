extends CharacterBody2D
@onready var joystick = $"../UI/Joystick"
@onready var visual = $Polygon2D
@export var speed := 200
@export var accel := 10
func _physics_process(delta):
	var input_dir = joystick.output
	var target_velocity = input_dir * speed
	velocity = velocity.lerp(target_velocity, accel * delta)
	if input_dir.length() > 0.1:
		var target_angle = input_dir.angle()
		visual.rotation = lerp_angle(visual.rotation, target_angle, 10 * delta)
	move_and_slide()
