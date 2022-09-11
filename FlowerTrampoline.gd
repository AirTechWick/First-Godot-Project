extends Node2D
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var _jump_boost_timer = $JumpBoostTimer
export var _strength_x = 800
export var _strength_y = 800


# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
#
#
#
func _on_TrampolineHitbox_body_entered(body):
	_jump_boost_timer.start()
	body.velocity.x = -_strength_x
	body.velocity.y = -_strength_y
