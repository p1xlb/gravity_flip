extends StaticBody2D

var laser_scene = preload("res://laser.tscn")
var shoot_timer = 0.0
var shoot_interval = 1.5  # Shoot every 2.5 seconds

func _process(delta):
	# Update the timer
	shoot_timer += delta
	
	# Check if it's time to shoot
	if shoot_timer >= shoot_interval:
		shoot_timer = 0  # Reset timer
		shoot_laser()

func shoot_laser():
	var laser = laser_scene.instantiate()
	get_parent().add_child(laser)
	laser.global_position = $LaserSpawnPoint.global_position
	laser.direction = Vector2.LEFT  # Adjust this based on gun rotation
