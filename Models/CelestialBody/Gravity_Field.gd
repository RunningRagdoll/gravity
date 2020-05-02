extends Area2D

func _ready():
	set_gravity_distance_scale(0.0001)
	set_gravity_is_point(true)
	set_gravity_vector(Vector2.ZERO)
	set_linear_damp(0.0)
	set_angular_damp(0.0)
	space_override = Area2D.SPACE_OVERRIDE_COMBINE
