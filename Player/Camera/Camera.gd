extends Camera2D

export(float, 1, 10) var max_zoom = 10
const ZOOM_SPEED = 10
var smoothing = 0
var velocity = Vector2()

var smooth_zoom = 1
var target_zoom = 1
 
export(NodePath) var player_path
onready var player

func _ready():
	set_follow_smoothing(2)
	player = get_node(player_path)
	
func _physics_process(delta):
	velocity = player.get_linear_velocity()
	if velocity.length() > 0:
		smoothing = 0.02 * velocity.length()
	else:
		smoothing = 2
	set_follow_smoothing(smoothing)
	relative_zoom(velocity.length(), delta)
	
func relative_zoom(speed: float, delta):
	target_zoom = max_zoom * (speed / 10000) + 1 # normalize by max speed
	smooth_zoom = lerp(smooth_zoom, target_zoom, ZOOM_SPEED * delta) 
	smooth_zoom = clamp(smooth_zoom, 1, max_zoom)
	set_zoom(Vector2(smooth_zoom, smooth_zoom))
	
