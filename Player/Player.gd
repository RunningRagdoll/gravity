extends RigidBody2D

export(int) var engine_thrust
export(int) var jaw_thrust

var thrust = Vector2()
var rotation_direction = 0
var bouncing_velocity = Vector2()
var max_speed = 5000

signal crash_land
signal reset_level

func get_input():
	if Input.is_action_pressed("ui_up"):
		thrust = Vector2(engine_thrust, 0)
	else:
		thrust = Vector2()
	rotation_direction = 0
	if Input.is_action_pressed("ui_right"):
		rotation_direction += 1
	if Input.is_action_pressed("ui_left"):
		rotation_direction -= 1
	if Input.is_action_just_pressed("ui_accept"):
		emit_signal("reset_level")

func _process(delta):
	get_input()

func _physics_process(delta):
	set_applied_force(thrust.rotated(rotation))
	set_applied_torque(rotation_direction * jaw_thrust)
	if get_linear_velocity().length() > max_speed:
		var new_speed = get_linear_velocity().normalized()
		new_speed *= max_speed
		set_linear_velocity(new_speed)
	
	var collisions = get_colliding_bodies() 
	if collisions.size() > 0:
		var impact_velocity = get_linear_velocity().length()
		if (impact_velocity > 300):
			emit_signal("crash_land")
