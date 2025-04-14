extends StaticBody2D

@export var laserDirection : String = ""

var laser_scene_horizontal = preload("res://laser.tscn")
var laser_scene_vertical = preload("res://laser_vertical.tscn")
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
	var laser
	if laserDirection == "LEFT" or laserDirection == "RIGHT":
		laser = laser_scene_horizontal.instantiate()
	elif laserDirection == "UP" or laserDirection == "DOWN":
		laser = laser_scene_vertical.instantiate()
	else:
		print("Invalid laser direction: " + laserDirection)
		return
		
	get_parent().add_child(laser)
	laser.global_position = $LaserSpawnPoint.global_position
	if laserDirection == "LEFT":  # Adjust this based on gun rotation
		laser.direction = Vector2.LEFT
	
	elif laserDirection == "RIGHT":
		laser.direction = Vector2.RIGHT
	
	elif laserDirection == "UP":
		laser.direction = Vector2.UP
	
	elif laserDirection == "DOWN":
		laser.direction = Vector2.DOWN
	
	else:
		print("Invalid laser direction specified.")
