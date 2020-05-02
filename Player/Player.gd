extends RigidBody2D

export(int) var engine_thrust
export(int) var jaw_thrust

var thrust = Vector2()
var rotation_direction = 0
var bouncing_velocity = Vector2()
var max_speed = 5000

var dead = false
var winning = false

signal crash_land
signal reset_level
signal win

func _ready():
	dead = false
	sleeping = false
	winning = false

func get_input():
	if Input.is_action_pressed("ui_up"):
		thrust = Vector2(engine_thrust, 0)
		if not (dead or winning):
			$"Flame".show()
			if not $"Flame/ExhaustSFX".is_playing():
				$"Flame/ExhaustSFX".play()
	else:
		thrust = Vector2()
		$"Flame".hide()
		$"Flame/ExhaustSFX".stop()
	rotation_direction = 0
	if Input.is_action_pressed("ui_right"):
		rotation_direction += 1
	if Input.is_action_pressed("ui_left"):
		rotation_direction -= 1
	if Input.is_action_just_pressed("ui_accept"):
		emit_signal("reset_level")

func _process(_delta):
	get_input()

func _physics_process(_delta):
	if not (dead or winning):
		set_applied_force(thrust.rotated(rotation))
		set_applied_torque(rotation_direction * jaw_thrust)
		if get_linear_velocity().length() > max_speed:
			var new_speed = get_linear_velocity().normalized()
			new_speed *= max_speed
			set_linear_velocity(new_speed)
		
		var collisions = get_colliding_bodies() 
		if collisions.size() > 0:
			var impact_velocity = get_linear_velocity().length()
			if (impact_velocity > 600):
				die()

func die():
	if not winning:
		emit_signal("crash_land")
		dead = true
		$"Ship front".hide()
		$"Ship back leg".hide()
		$"Explosion".play()
		sleeping = true

func _on_Timer_timeout():
	emit_signal("win")
	winning = true
