extends Node2D
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var _jump_boost_timer = $JumpBoostTimer
export var _strength_x = 800
export var _strength_y = 800


func _on_TrampolineHitbox_body_entered(body):
	_jump_boost_timer.start()
	body.velocity.x = -_strength_x
	body.velocity.y = -_strength_y
