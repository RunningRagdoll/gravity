extends CanvasLayer

signal restart_level
var player_died = false setget _set_player_died, _get_player_died
# Called when the node enters the scene tree for the first time.
func _ready():
	get_child(0).hide()
	
func _set_player_died(value):
	player_died = value

func _get_player_died():
	return player_died

func _on_Player_crash_land():
	get_child(0).show()
	_set_player_died(true)

func _on_Player_reset_level():
	if _get_player_died():
		get_tree().reload_current_scene()
	else:
		pass
