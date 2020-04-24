tool
extends Node2D

export(float, 0.0, 10000) var radius = 100 setget _set_radius # [pixels]
export(float) var angular_velocity = 0 setget _set_angular_velocity # [rad/s]
export(bool) var random_initial_position = false setget _set_random_initial_position
export(int, 2, 512) var number_of_steps = 128 setget _set_number_of_steps

var angle = 0.0

func orbital_position(r: float, theta: float):
	return Vector2(r * cos(theta), r * sin(theta))

func _ready():
	if random_initial_position:
		angle = randf() * 2 * PI
	get_node("Celestial Body").position = orbital_position(radius, angle)

func _physics_process(delta):
	if Engine.editor_hint:
		return
	rotation += angular_velocity * delta

func _set_angular_velocity(value):
	angular_velocity = value
	update()
	
func _set_radius(value):
	radius = value
	update()
	
func _set_random_initial_position(value):
	random_initial_position = value
	update()

func _set_number_of_steps(value):
	number_of_steps = value
	update()

func _draw():
	if not Engine.editor_hint:
		return
	var points_array = PoolVector2Array()
	for i in range(number_of_steps):
		var angle = (i * 2 * PI) / number_of_steps
		var point = orbital_position(radius, angle)
		points_array.append(point)
	draw_multiline(points_array, Color('#ffffff'), 4.0, true)
