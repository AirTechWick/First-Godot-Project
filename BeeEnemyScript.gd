extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const UPWARDS = Vector2(0,-1)
onready var _animated_sprite = $AnimatedSprite
onready var _bee_timer = $BeeTimer
var velocity = Vector2()
export var flying_speed = 200
export var flying_range = 10  

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity.x = flying_speed
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
		
		
	
#	if velocity.x > 0:
#		_animated_sprite.flip_h = false
#	elif velocity.x < 0:
#		_animated_sprite.flip_h = true
#	else: # if velocity is 0
#		if _animated_sprite.flip_h == false: # sprite facing right
#			velocity.x = flying_speed
#		else:
#			velocity.x = -flying_speed
