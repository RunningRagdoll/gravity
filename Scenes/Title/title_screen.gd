extends Control

var scene_path_to_load

func _ready():
	$"Menu/Center row/Buttons/New Game button".grab_focus()
	for button in $"Menu/Center row/Buttons".get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])
	if not Music.is_playing():
		Music.play()
	if Music2.is_playing():
		Music3.stop()
	if Music3.is_playing():
		Music3.stop()

func _on_Button_pressed(scene_to_load):
	scene_path_to_load = scene_to_load
	$"Fade in".show()
	$"Fade in".fade_in()
	if not $"Select".is_playing():
		$Select.play()

func _on_Fade_in_fade_finished():
	get_tree().change_scene(scene_path_to_load)

func _process(_delta):
	if (Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("ui_down")):
		$Switch.play()
