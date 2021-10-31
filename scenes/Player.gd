extends KinematicBody2D

var speed : int = 300
var jumpSpeed : int = 200
var jumpForce : int = 400
var gravity : int = 800
var fallMultiplier : float = 1.5

var vel : Vector2 = Vector2()

onready var sprite : Sprite = get_node("Sprite")

# Inspired by a tutorial - https://www.youtube.com/watch?v=QftpPI5iYrY
func _movement(delta):
	vel.x = 0
	
	
	# movement inputs
	if Input.is_action_pressed("move_left"):
		if not is_on_floor():
			vel.x -= jumpSpeed
		else:
			vel.x -= speed
		sprite.flip_h = true
	if Input.is_action_pressed("move_right"):
		if not is_on_floor():
			vel.x += jumpSpeed
		else:
			vel.x += speed
		sprite.flip_h = false
	
	# applying the velocity
	vel = move_and_slide(vel, Vector2.UP)
	
	# gravity
	if(vel.y > 0):
		vel.y += gravity * fallMultiplier * delta
	else:
		vel.y += gravity * delta
	
	# jump input
	if Input.is_action_just_pressed("jump") and is_on_floor():
		vel.y -= jumpForce


func _physics_process(delta):
	_movement(delta)
	
	
