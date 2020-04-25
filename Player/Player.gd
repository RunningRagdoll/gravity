extends RigidBody2D

export(int) var engine_thrust
export(int) var jaw_thrust

var thrust = Vector2()
var rotation_direction = 0

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

func _process(delta):
	get_input()

func _physics_process(delta):
	set_applied_force(thrust.rotated(rotation))
	set_applied_torque(rotation_direction * jaw_thrust)
