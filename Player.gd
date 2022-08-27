extends KinematicBody2D

var run_speed = 350
var jump_speed = -500
var gravity = 1000
var justLanded : bool

var velocity = Vector2()
onready var _animated_sprite = $AnimatedSprite


func _physics_process(delta):
	velocity.y += gravity * delta
	get_input()
	play_animations()
	velocity = move_and_slide(velocity, Vector2(0, -1))


func get_input():
	velocity.x = 0
	var right = Input.is_action_pressed("move_right")
	var left = Input.is_action_pressed("move_left")
	var jump = Input.is_action_just_pressed("jump_up")

	if is_on_floor() and jump:
		velocity.y = jump_speed
		_animated_sprite.play("jump")
	
	if right:
		velocity.x += run_speed
	if left:
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
	if is_on_floor():
		if justLanded: # if we are on the floor and just landed
			_animated_sprite.play("idle")
			justLanded = false
	else: # in the air 
		if !justLanded: # if we are in the air and have not landed yet
			justLanded = true 
