extends Control

var base_radius := 80
var knob_radius := 30

var knob_pos := Vector2.ZERO
var is_dragging := false
var output := Vector2.ZERO

func _ready():
	knob_pos = size / 2
	queue_redraw()

func _draw():
	var center = size / 2
	draw_circle(center, base_radius, Color(0.2, 0.2, 0.2, 0.5))
	draw_circle(knob_pos, knob_radius, Color(1, 1, 1, 0.9))

func _input(event):
	var center = size / 2
	if event is InputEventScreenTouch:
		if event.pressed:
			if event.position.distance_to(global_position + center) <= base_radius:
				is_dragging = true
		else:
			is_dragging = false
			knob_pos = center
			output = Vector2.ZERO
			queue_redraw()

	elif event is InputEventScreenDrag and is_dragging:
		var direction = event.position - (global_position + center)

		if direction.length() > base_radius:
			direction = direction.normalized() * base_radius
		knob_pos = center + direction
		output = direction / base_radius
		queue_redraw()
