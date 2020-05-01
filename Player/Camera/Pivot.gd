extends Position2D

onready var parent = get_parent()
var velocity_normal = Vector2()
var velocity_magnitude

func _ready():
	update_pivot_angle()
	
func _physics_process(_delta):
	update_pivot_angle()

func update_pivot_angle():
	velocity_normal = parent.get_linear_velocity().normalized()
	rotation = velocity_normal.angle() - parent.rotation

func _draw():
	draw_line(position, get_node("Camera offset").position, Color('#ffffff'))
