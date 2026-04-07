extends CharacterBody3D

@export var speed := 6.0
@export var jump_force := 10.0
@export var gravity := 20.0

func _physics_process(delta):
	var direction := 0.0

	# Movimento lateral
	if Input.is_action_pressed("ui_right"):
		direction += 1
	if Input.is_action_pressed("ui_left"):
		direction -= 1

	velocity.x = direction * speed

	# Gravidade
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Pulo
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_force

	# 🔒 trava eixo Z (2.5D)
	velocity.z = 0

	move_and_slide()

	# 🔒 força posição no plano Z = 0 (evita bugs físicos)
	var pos = global_transform.origin
	pos.z = 0
	global_transform.origin = pos
