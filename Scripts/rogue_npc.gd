extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
@export var _isPlayerInRange : bool = false
@export var _isCheering : bool = false
@onready var anim_player : AnimationPlayer = $AnimationPlayer
@onready var player_character = $"../../Barbarian"

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	anim_player.play("Idle")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	if _isCheering == false:
		anim_player.play("Idle")

	_sayHello()
	if anim_player.is_playing() == false:
		_isCheering = false


func _on_area_3d_body_entered(body):
	if body == player_character:
		_isPlayerInRange = true

func _sayHello():
	if _isPlayerInRange == true and player_character._hasInteracted == true:
		_cheerAnimation()
		print("hello")

func _on_area_3d_body_exited(body):
	if body == player_character:
		_isPlayerInRange = false

func _cheerAnimation():
	_isCheering = true
	anim_player.play("Cheer")
	
	
