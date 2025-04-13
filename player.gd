extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var gravity_direction = 1.0  # 1.0 is down, -1.0 is up
var gravity_value = 980

func _physics_process(delta):
	# Add gravity
	if not is_on_floor() and not is_on_ceiling():
		velocity.y += gravity_value * gravity_direction * delta
	
	# Handle gravity flip
	if Input.is_action_just_pressed("flip_gravity"):
		gravity_direction *= -1
		$Sprite2D.flip_v = !$Sprite2D.flip_v  # Flip sprite vertically
	
	# Handle jump
	if Input.is_action_just_pressed("jump"):
		if (is_on_floor() and gravity_direction > 0) or (is_on_ceiling() and gravity_direction < 0):
			velocity.y = JUMP_VELOCITY * gravity_direction
	
	# Get the input direction
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	# Apply movement
	move_and_slide()
	
	# Handle sprite flipping horizontally based on direction
	if direction > 0:
		$Sprite2D.flip_h = false
	elif direction < 0:
		$Sprite2D.flip_h = true
