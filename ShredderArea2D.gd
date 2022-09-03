extends Area2D

onready var _this_collision_shape = $CollisionShape2D


func _on_Area2D_body_entered(body):
	print(body.get_class())
	print(body.name + " entered the Shredder Area") # Replace with function body.
	print(body.position)
	body.position = Vector2(500,100)

	
