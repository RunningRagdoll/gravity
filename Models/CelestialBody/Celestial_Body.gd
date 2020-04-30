extends KinematicBody2D

func _ready():
	add_to_group("Bodies")

func _on_Collision_trigger_area_entered(area):
	area.get_parent().die()


func _on_Goal_body_entered(body):
	body.get_child(5).start()

func _on_Goal_body_exited(body):
	body.get_child(5).stop()
