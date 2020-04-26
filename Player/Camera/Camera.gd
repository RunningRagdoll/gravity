extends Camera2D

var smoothing = 0
var velocity = Vector2()
 
export(NodePath) var player_path
onready var player

var zoom_state = 0
var states = [3, 6]

func _ready():
	set_follow_smoothing(2)
	player = get_node(player_path)
	
func get_input():
	if Input.is_action_just_pressed("ui_select"):
		zoom_state += 1
	return zoom_state

func _process(_delta):
	zoom_state = get_input()
	zoom_state = zoom_state % states.size()
	set_zoom(Vector2(states[zoom_state], states[zoom_state]))

func _physics_process(_delta):
	velocity = player.get_linear_velocity()
	if velocity.length() > 0:
		smoothing = 0.02 * velocity.length()
	else:
		smoothing = 2
	set_follow_smoothing(smoothing)
