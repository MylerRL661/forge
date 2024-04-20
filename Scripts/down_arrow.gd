extends AnimatedSprite3D

var SPEED = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	pass
	#var movement = Vector3(-1, 0, 0) * SPEED * delta
	#translate(movement)
	#_activate_sprite()


func _activate_sprite():
	if Input.is_action_just_pressed("backward"):
		frame = 1
