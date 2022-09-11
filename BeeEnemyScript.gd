extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const UPWARDS = Vector2(0,-1)
onready var _animated_sprite = $AnimatedSprite
onready var _bee_timer = $BeeDirectionTimer
onready var _bee_animation_timer = $BeeHitAnimationTimer
var velocity = Vector2()
export var flying_speed = 200
export var flying_range = 10
export(String, "Left", "Right") var starting_direction

# Called when the node enters the scene tree for the first time.
func _ready():
	if starting_direction == "Right":
		velocity.x = flying_speed
		_animated_sprite.flip_h = false
	if starting_direction == "Left":
		velocity.x = -flying_speed
		_animated_sprite.flip_h = true # true means facing left
	_bee_timer.wait_time = flying_range/10 # Changes the wait time of the change direction timer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# -1 in the Vector2 means that UP direction is towards -1 y coordinate
	# We are changing velocity by velocity.x everytime move and slide is called
	 # normalizing it?
	velocity = move_and_slide(velocity, UPWARDS) 


func changeDirection():
	velocity.x *= -1
	
	if _animated_sprite.flip_h == true:
		_animated_sprite.flip_h = false
	else:
		_animated_sprite.flip_h = true
	
	if abs(velocity.x) != flying_speed && _animated_sprite.flip_h == false:
		velocity.x = flying_speed
	elif abs(velocity.x) != flying_speed && _animated_sprite.flip_h == true:
		velocity.x = -flying_speed


func _on_BeeHitBox_body_entered(body):
	body.velocity.y = -600 
	self._animated_sprite.play("hit")
	_bee_animation_timer.start()


func _on_BeeHitAnimationTimer_timeout():
	_animated_sprite.play("default")
