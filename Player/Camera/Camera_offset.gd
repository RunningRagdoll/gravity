extends Position2D

var offset = 0.0
export(float) var offset_max = 1000
export(NodePath) var player_path
var player

func _ready():
	position.x  = offset
	player = get_node(player_path)

func _physics_process(delta):
	var speed = player.get_linear_velocity().length()
	var scaled_position =  offset_max * speed / 10000
	position.x = clamp(scaled_position, 0, offset_max)
	
func relative_position():
	return player.get_linear_velocity()
	
