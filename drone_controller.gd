extends RigidBody3D

@export var force = 20
@export var move_force = 1
@export var max_speed = 1
@export var damping:float = 0.3

var velocity = Vector3(0,0,0)

func upward_force(enact:bool) -> Vector3:
	if(enact):
		return Vector3(0,2,0)
	
	return Vector3(0,0,0)
	pass
	
func moveController() -> Vector3:
	var s = Input.get_axis("reverse","forward")
	var f:Vector3 = Vector3.ZERO	
	
	
	
	f = global_basis.z * s * move_force
	
	
	var l = Input.get_axis("left", "right")* 0.01 
	rotation.y -= l;
	
	return f


func calculate():	#calcilates net force based on various inputs
	var f:Vector3 = Vector3.ZERO	
	f += upward_force(Input.is_action_pressed("up"))
	f += moveController()
	
	return f


func _process(delta: float) -> void:
	
	
	force = calculate()	#gets the sum of active forces
	#print(get_children(true))
	for i in ["PropArm","PropArm2","PropArm3","PropArm4"]:
		find_child(i).find_child("Propellors").rotation.y += force.length()
		pass
		
	force += Vector3(0,-0.5,0) #gravity  
	
	var accel = force / mass	#base it off force relative to mass
	
	velocity = (velocity + accel * delta)	#accelaration by delta added to current velocity
	velocity = velocity - (velocity * damping * delta)	#including the damping forces
	velocity = velocity.limit_length(max_speed)
	
	move_and_collide(velocity)
	pass
