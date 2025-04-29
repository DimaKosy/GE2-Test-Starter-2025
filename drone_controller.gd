extends RigidBody3D

@export var force = 20
@export var move_force = 10
@export var max_speed = 1
@export var damping:float = 0.3

var velocity = Vector3(0,0,0)

func upward_force(enact:bool) -> Vector3:
	if(enact):
		return Vector3(0,2,0)
	
	return Vector3(0,-1,0)
	pass
	
func moveController() -> Vector3:
	var s = Input.get_axis("reverse","forward")
	var f:Vector3 = Vector3.ZERO	
	
	f = global_basis.z * s * move_force
	
	var l = Input.get_axis("left", "right")
	var xz_dir = global_basis.x
	
	
	xz_dir.y = 0
	f -= xz_dir * l * move_force
	xz_dir = xz_dir.normalized()
	
	return f


func calculate():	#calcilates net force based on various inputs
	var f:Vector3 = Vector3.ZERO	
	f += upward_force(Input.is_action_pressed("up"))
	f += moveController()
	print(Input.is_action_pressed("up"))
	return f


func _process(delta: float) -> void:
	
	
	force = calculate()	#gets the sum of active forces
	var accel = force / mass	#base it off force relative to mass
	velocity = (velocity + accel * delta)	#accelaration by delta added to current velocity
	velocity = velocity - (velocity * damping * delta)	#including the damping forces
	velocity = velocity.limit_length(max_speed)
	
	
	move_and_collide(velocity)
	pass
