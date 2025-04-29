extends Camera3D

@export var lookat_target:RigidBody3D
@export var moveto_target:Marker3D

func _process(delta: float) -> void:
	var movement_f =  moveto_target.global_position - global_position
	
	lookat_target(lookat_target.global_position)
	global_position += movement_f
	pass
