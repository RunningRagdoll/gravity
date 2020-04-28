extends KinematicBody2D

func _ready():
	add_to_group("Bodies")

func _on_Collision_trigger_area_entered(area):
	area.get_parent().die()
