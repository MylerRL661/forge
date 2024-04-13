extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
@export var _isPlayerInRange : bool = false
@onready var anim_player : AnimationPlayer = $AnimationPlayer
@onready var player_character = $"../../Barbarian"

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	_sayHello()


func _on_area_3d_body_entered(body):
	if body == player_character:
		anim_player.play("Cheer")
		_isPlayerInRange = true

func _sayHello():
	if _isPlayerInRange == true and player_character._isInteracting == true:
		print("hello")

func _on_area_3d_body_exited(body):
	if body == player_character:
		_isPlayerInRange = false
