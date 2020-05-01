extends Control

var scene_path_to_load

func _ready():
	$"Menu/Center row/Buttons/New Game button".grab_focus()
	for button in $"Menu/Center row/Buttons".get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])

func _on_Button_pressed(scene_to_load):
	scene_path_to_load = scene_to_load
	$"Fade in".show()
	$"Fade in".fade_in()


func _on_Fade_in_fade_finished():
	get_tree().change_scene(scene_path_to_load)
