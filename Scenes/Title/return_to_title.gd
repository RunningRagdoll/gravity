extends Control

func _ready():
	$"CenterContainer/VBoxContainer/Button".grab_focus()

func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/Title/Title_screen.tscn")

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("ui_select"):
		$Back.play()
