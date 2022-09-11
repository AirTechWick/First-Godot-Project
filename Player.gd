extends KinematicBody2D

export var run_speed = 350 # Need these large numbers because we are using delta in our code which is a very large fraction
export var jump_speed = -500
export var gravity = 1000
var justLanded : bool


var velocity = Vector2() # Can also be called position if not using an angle
onready var _animated_sprite = $AnimatedSprite



func _physics_process(delta): # delta is the amount of time elapsed during one frame
	print(velocity.x)
	velocity.y += gravity * delta
	defaultVelocityX()
	get_input()
	play_animations()
	velocity = move_and_slide(velocity, Vector2(0, -1))


func get_input():
	
	var right = Input.is_action_pressed("move_right")
	var left = Input.is_action_pressed("move_left")
	var jump = Input.is_action_just_pressed("jump_up")

	if is_on_floor() and jump:
		velocity.y = jump_speed
		_animated_sprite.play("jump")
	
	if right: # if right press is detected
		velocity.x += run_speed
	if left: # if left press is detected
		velocity.x -= run_speed

func play_animations():
	checkLanding() # plays idle animation if character landed
	
	if Input.is_action_just_pressed("move_right"):
		_animated_sprite.play("run")
		_animated_sprite.flip_h = false # by default the sprite faces right on false
	if Input.is_action_just_released("move_right"):
		_animated_sprite.play("idle")
		
	if Input.is_action_just_pressed("move_left"):
		_animated_sprite.play("run")
		_animated_sprite.flip_h = true
	if Input.is_action_just_released("move_left"):
		_animated_sprite.play("idle")
	

func checkLanding():
	var movingRight = Input.is_action_pressed("move_right")
	var movingLeft = Input.is_action_pressed("move_left")
	if is_on_floor():
		if justLanded: # if we are on the floor and just landed
			if movingRight || movingLeft:
				_animated_sprite.play("run")
				justLanded = false
			else:
				_animated_sprite.play("idle")
				justLanded = false
	else: # in the air 
		if !justLanded: # if we are in the air and have not landed yet
			justLanded = true

func defaultVelocityX():
	# Can get variables from other nodes with ".." to go to parent in tree first
	if abs(velocity.x) == get_node("../LeftFlowerTrampoline")._strength_x: # if we are being boosted by timer, this is hardcoded
		null # do nothing
	else:
		velocity.x = 0



func _on_JumpBoostTimer_timeout():
	velocity.x = 0 # Replace with function body.
