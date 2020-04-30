extends CanvasLayer

signal restart_level
var player_died = false setget _set_player_died, _get_player_died
var player_won = false setget _set_player_won, _get_player_won

func _ready():
	get_child(0).hide()
	get_child(1).hide()

func _on_Player_crash_land():
	if not (_get_player_won()):
		get_child(0).show()
		_set_player_died(true)

func _on_Player_reset_level():
	if _get_player_died():
		get_tree().reload_current_scene()
	else:
		pass

func _on_Player_win():
	_set_player_won(true)
	get_child(1).show()
	# To do: send player to Title Screen

func _set_player_died(value):
	player_died = value

func _get_player_died():
	return player_died

func _set_player_won(value):
	player_won = value

func _get_player_won():
	return player_won
