extends Camera3D

@export var lookat_target:RigidBody3D
@export var moveto_target:Marker3D

func _process(delta: float) -> void:
	var movement_f =  moveto_target.global_position - global_position
	
	look_at(lookat_target.global_position)
	
	global_position = lerp(global_position,moveto_target.global_position,0.2)
	#global_position += movement_f
	pass
