extends KinematicBody2D

var angular_velocity = 0.0 setget set_angular_velocity

func set_angular_velocity(value):
	angular_velocity = value

func _ready():
	add_to_group("Bodies")
	
func _physics_process(delta):
	rotation += angular_velocity * delta 

func _on_Collision_trigger_area_entered(area):
	if area.is_in_group("Player"):
		area.get_parent().die()


func _on_Goal_body_entered(body):
	if body.is_in_group("Player"):
		body.get_child(5).start()

func _on_Goal_body_exited(body):
	if body.is_in_group("Player"):
		body.get_child(5).stop()
