extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var animated_sprite = %AnimatedSprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		animated_sprite.stop()
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction == 1:
		velocity.x = direction * SPEED
		animated_sprite.play("run")
		animated_sprite.flip_h = false
	elif direction == -1:
		velocity.x = direction * SPEED
		animated_sprite.play("run")
		animated_sprite.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animated_sprite.play("idle")

	move_and_slide()




func _on_chain_hook(hook_position):
	await get_tree().create_timer(0.2).timeout
	var tween= get_tree().create_tween()
	tween.tween_property(self, "position", hook_position, .3)
