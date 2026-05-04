extends CharacterBody2D

@onready var joystick = $"../UI/Joystick"
@onready var visual = $Polygon2D
@onready var dash = $"../UI/Dash"

# DASH SETTING
var dash_distance := 16 * 7.0   # 448 px
var dash_time := 0.05            # durasi dash (detik)
var dash_speed := dash_distance / dash_time

# DASH STATE
var is_dashing := false
var dash_timer := 0.0
var dash_direction := Vector2.ZERO

# COOLDOWN
var dash_cooldown := 3.0
var dash_cd_timer := 0.0

var output : Vector2
@export var speed := 200
@export var accel := 10

func _ready():
	dash.dash_pressed.connect(start_dash)
	
func start_dash():
	if dash_cd_timer > 0 or is_dashing:
		return
	var input_dir = joystick.output
	if input_dir.length() == 0:
		return
	dash_direction = input_dir.normalized()
	is_dashing = true
	dash_timer = dash_time
	dash_cd_timer = dash_cooldown

func _physics_process(delta):
	var input_dir = joystick.output
	
	if dash_cd_timer > 0:
		dash_cd_timer -= delta
		
	if is_dashing:
		velocity = dash_direction * dash_speed
		dash_timer -= delta
		
		if dash_timer <= 0:
			is_dashing = false
			
	else:
		var target_velocity = input_dir * speed
		velocity = velocity.lerp(target_velocity, accel * delta)
		
	if input_dir.length() > 0.1:
		var target_angle = input_dir.angle()
		visual.rotation = lerp_angle(visual.rotation, target_angle, 10 * delta)
	move_and_slide()
