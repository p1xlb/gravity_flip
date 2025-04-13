extends Area2D

var speed = 400.0
var direction = Vector2.RIGHT
var lifetime = 3.0  # Laser will disappear after 3 seconds

func _ready():
	body_entered.connect(_on_body_entered)
	# Start the self-destruct timer
	var timer = get_tree().create_timer(lifetime)
	timer.timeout.connect(queue_free)

func _process(delta):
	# Move the laser
	position += direction * speed * delta

func _on_body_entered(body):
	if body.is_in_group("player") or body is CharacterBody2D:
		# Restart the level when player is hit
		get_tree().reload_current_scene()
		# Destroy the laser
		queue_free()
