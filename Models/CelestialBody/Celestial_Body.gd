tool
extends KinematicBody2D

func _ready():
	pass
func _physics_process(delta):
	if Engine.editor_hint:
		return

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
