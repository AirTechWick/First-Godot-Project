extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2()
export var flying_speed = 200
export var flying_range = 10  
onready var _animated_sprite = $AnimatedSprite
onready var _bee_timer = $BeeTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity.x = flying_speed # normalizing it?
	_bee_timer.wait_time = flying_range/10 # Changes the wait time of the change direction timer



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# -1 in the Vector2 means that UP direction is towards -1 y coordinate
	# We are changing velocity by velocity.x everytime move and slide is called
	velocity = move_and_slide(velocity, Vector2(0, -1)) 



func changeDirection():
	if _animated_sprite.flip_h == true:
		_animated_sprite.flip_h = false
	else:
		_animated_sprite.flip_h = true
	velocity.x *= -1 
