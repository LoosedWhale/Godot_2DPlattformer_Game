extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -250.0
const ATTACK_DELAY = 3

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim = get_node("AnimationPlayer")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("reg_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$JumpSfx.play()
		anim.play("Jump")
	
	# High Jump
	if Input.is_action_just_pressed("high_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY * 1.5
		$JumpSfx.play()
		anim.play("Jump")

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("move_left", "move_right")
	
	if direction == -1:
		get_node("AnimatedSprite2D").flip_h = true
	elif direction == 1:
		get_node("AnimatedSprite2D").flip_h = false
		
	if direction:
		velocity.x = direction * SPEED
		if velocity.y==0:
			anim.play("Run")
		
	elif Input.is_action_just_pressed("dance") and is_on_floor():
		get_node("AnimatedSprite2D").play("AltDeath") #Looks like the player is bobing his head
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED/ 2)
		if velocity.y==0:
			anim.play("Idle")
	if velocity.y > 0:
		anim.play("Fall")

	move_and_slide()

	if Game.playerHP <= 0 or position.y >= 432:
		death()
		
func attack():
	if Input.is_action_just_pressed("attack"):
		get_node("AnimatedSprite2D").play("AttackFist")

func death():
	queue_free()
	get_tree().change_scene_to_file("res://death_xd.tscn")
	Utils.saveGame()
	
