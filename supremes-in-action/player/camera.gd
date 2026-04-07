extends Camera3D

@export var offset := Vector3(0, 3, 10)
@export var follow_speed := 5.0

func _process(delta):
	var target_pos = get_parent().global_transform.origin + offset
	
	global_transform.origin = global_transform.origin.lerp(target_pos, follow_speed * delta)
	
	look_at(get_parent().global_transform.origin, Vector3.UP)
