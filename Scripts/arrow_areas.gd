extends Area3D

# Speed of the movement
var speed = 1.0
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var movement = Vector3(-1, 0, 0) * speed * delta
	translate(movement)
