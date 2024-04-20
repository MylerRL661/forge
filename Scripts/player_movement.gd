extends CharacterBody3D


@export var SPEED = 5.0
@export var JUMP_VELOCITY = 10
var rotation_direction
@export var _isInteracting : bool = false
@export var _hasInteracted : bool = false
@export var _isPlayerInRange : bool = false
@export var rotation_speed = 5
@onready var model = $Rig/Skeleton3D
@onready var anim_player = $AnimationPlayer
@onready var player_spawn_position = $"../../PlayerSpawnPosition"

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor() and _isPlayerInRange == false:
		velocity.y = JUMP_VELOCITY
		anim_player.play("Jump_Full_Short", 0.5)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		rotation_direction = Vector2(direction.z, direction.x).angle()
		model.rotation.y = lerp_angle(model.rotation.y, rotation_direction, delta * 10)
		_walk_anim()
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		_interact()
		if is_on_floor() and not Input.is_action_just_pressed("jump") and _isInteracting == false:
			anim_player.play("Idle", 0.1)

	move_and_slide()

func _walk_anim():
	if is_on_floor() and not Input.is_action_just_pressed("jump"):
		anim_player.play("Running_B", 0.1)
		if !is_on_floor:
			anim_player.stop()

func _interact():
	if Input.is_action_just_pressed("interact"):
		_isInteracting = true
		_hasInteracted = true
		anim_player.play("Interact", 0.5)
		print("interacted")
	else:
		_hasInteracted = false

	if anim_player.is_playing() == false:
		_isInteracting = false


func _on_killbox_body_entered(body):
	if body.name == "Barbarian":
		transform.origin = player_spawn_position.transform.origin

func _on_area_3d_2_body_entered(body):
	if body.name == 'Barbarian':
		_isPlayerInRange = true

func _on_area_3d_2_body_exited(body):
	if body.name == 'Barbarian':
		_isPlayerInRange = false
