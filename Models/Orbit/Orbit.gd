tool
extends Node2D

export(float, 0.0, 10000) var radius = 100 setget _set_radius # [pixels]
export(float, -2.0, 2.0) var angular_velocity = 0 setget _set_angular_velocity # [rad/s]
export(bool) var random_initial_position = false setget _set_random_initial_position
export(int, 2, 512) var number_of_steps = 128 setget _set_number_of_steps
export(Texture) var sprite = load("res://Models/Planet_Debug_256x256.png")
export(bool) var is_goal = false
export(float) var goal_offset = 0.0 setget _set_goal_offset
export(float, -1.0, 1.0) var body_angular_velocity = 0.0
export(float, 0.0, 980) var gravity = 98.0

var angle = 0.0

func orbital_position(r: float, theta: float):
	return Vector2(r * cos(theta), r * sin(theta))

func _ready():
	if random_initial_position:
		angle = randf() * 2 * PI
	$"Celestial Body".position = orbital_position(radius, angle)
	$"Celestial Body/Sprite".set_texture(sprite)
	if is_goal:
		$"Celestial Body/LandingZonePosition".show()
		$"Celestial Body/LandingZonePosition/Goal".set_monitoring(true)
		$"Celestial Body/LandingZonePosition/Goal".set_monitorable(true)
	else:
		$"Celestial Body/LandingZonePosition".hide()
		$"Celestial Body/LandingZonePosition/Goal".set_monitoring(false)
		$"Celestial Body/LandingZonePosition/Goal".set_monitorable(false)
	$"Celestial Body/LandingZonePosition".set_position(Vector2(goal_offset, 0.0))
	$"Celestial Body".set_angular_velocity(body_angular_velocity)
	$"Celestial Body/Gravity Field".set_gravity(gravity)



func _physics_process(delta):
	if Engine.editor_hint:
		return
	rotation += angular_velocity * delta


func _draw():
	if not Engine.editor_hint:
		return
	var points_array = PoolVector2Array()
	for i in range(number_of_steps):
		var angle = (i * 2 * PI) / number_of_steps
		var point = orbital_position(radius, angle)
		points_array.append(point)
	draw_multiline(points_array, Color('#ffffff'), 4.0, true)

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

func _set_goal_offset(value):
	goal_offset = value
	update()
