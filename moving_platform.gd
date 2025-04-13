extends AnimatableBody2D

@export var start_position: Vector2 = Vector2.ZERO
@export var end_position: Vector2 = Vector2(0, 100)  # Move 100 pixels down by default
@export var travel_time: float = 3.0  # Time to move from start to end
@export var wait_time: float = 1.0  # Time to wait at each end

var elapsed_time: float = 0
var moving_to_end: bool = true
var waiting: bool = false
var wait_timer: float = 0

func _ready():
	# Set the initial position
	start_position = global_position
	end_position = start_position + end_position  # Make end_position relative to start

func _physics_process(delta):
	if waiting:
		# Handle waiting at endpoints
		wait_timer += delta
		if wait_timer >= wait_time:
			waiting = false
			wait_timer = 0
			moving_to_end = !moving_to_end
	else:
		# Handle movement
		elapsed_time += delta
		var progress = elapsed_time / travel_time
		
		if progress >= 1.0:
			# Reached destination
			global_position = end_position if moving_to_end else start_position
			elapsed_time = 0
			waiting = true
		else:
			# Interpolate position
			var from_pos = start_position if moving_to_end else end_position
			var to_pos = end_position if moving_to_end else start_position
			
			# Use smoothing for more natural movement (optional)
			# Replace with progress for linear movement
			var smooth_progress = ease(progress, 0.5)  
			
			global_position = from_pos.lerp(to_pos, smooth_progress)
