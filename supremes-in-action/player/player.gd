extends CharacterBody3D

@export var speed := 6.0
@export var jump_force := 10.0
@export var gravity := 20.0

@onready var anim = $Corpo/walking/AnimationPlayer

func _physics_process(delta):
	var direction := 0.0

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
		anim.play("jump")  # 🎯 animação de pulo

	velocity.z = 0
	move_and_slide()

	# 🔒 trava eixo Z
	var pos = global_transform.origin
	pos.z = 0
	global_transform.origin = pos

	# 🎮 Controle de animações
	if not is_on_floor():
		anim.play("jump")
	elif direction != 0:
		anim.play("walk")
	else:
		anim.play("idle")
