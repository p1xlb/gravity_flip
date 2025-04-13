extends Area2D

# Set this in the Inspector to specify which level to load next
@export var next_level_path: String = ""

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.name == "Player" or body.is_in_group("player"):
		print("Level Complete!")
		
		# Check if we have a next level to load
		if next_level_path != "":
			# Wait a brief moment before changing scenes
			get_tree().paused = true
			await get_tree().create_timer(0.5).timeout
			get_tree().paused = false
			# Load the next level
			get_tree().change_scene_to_file(next_level_path)
		else:
			# If no next level is specified, just print a completion message
			print("Game Complete! No more levels.")
