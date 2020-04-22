extends RigidBody2D

export var radius = 1
var currentVelocity = Vector2(0.0, 0.0)
const GRAVITATIONAL_CONSTANT: float = 100.0

func _ready():
	# Keep track of all bodies in the scene
	add_to_group("AllBodies")
	# Turn off general gravity integration
	set_use_custom_integrator(true)
	set_can_sleep(false)
	currentVelocity = linear_velocity

func UpdateVelocity(currentVelocity: Vector2, var allBodies: Array, delta):
	#var allBodies = get_tree().get_nodes_in_group("AllBodies")
	for otherBody in allBodies:
		if otherBody != self:
			var squaredDistance = position.distance_squared_to(otherBody.position)
			var forceDirection = (otherBody.position - position).normalized()
			var force = forceDirection * GRAVITATIONAL_CONSTANT * mass * otherBody.mass / squaredDistance
			var acceleration = force / mass
			# For leapfrog integration (kick-drift-kick) form
			# update velocity twice, thus half delta time step
			currentVelocity += acceleration * delta / 2
	return currentVelocity

func UpdatePosition(currentVelocity: Vector2, delta):
	position += currentVelocity * delta



func _integrate_forces(state):
	var allBodies = get_tree().get_nodes_in_group("AllBodies")
	currentVelocity = state.linear_velocity

	currentVelocity = UpdateVelocity(currentVelocity, allBodies, state.step)
	UpdatePosition(currentVelocity, state.step)
	currentVelocity = UpdateVelocity(currentVelocity, allBodies, state.step)
	state.linear_velocity = currentVelocity
