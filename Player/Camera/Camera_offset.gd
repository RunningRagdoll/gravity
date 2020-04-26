extends Position2D

var offset = 0.0
export(float) var offset_max = 1000
export(NodePath) var player_path
var player
var target_position = 0
var smooth_position = 0
const SMOOTH_SPEED = 100

func _ready():
	position.x  = offset
	player = get_node(player_path)

func _physics_process(delta):
	var speed = player.get_linear_velocity().length()
	target_position =  offset_max * speed / 5000
	#position.x = clamp(scaled_position, 0, offset_max)
	position.x = lerp(position.x, target_position, SMOOTH_SPEED * delta)
	
func relative_position():
	return player.get_linear_velocity()
	
