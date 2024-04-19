extends Node3D

@onready var anim_player : AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_hitAnvil()

func _hitAnvil():
	if Input.is_action_just_pressed("interact"):
		anim_player.play('1H_Melee_Attack_Chop')
