extends Node3D

#arrows
@onready var down_arrow_area = $Area3D_down
@onready var down_arrow_sprite = $Area3D_down/down_arrow
@onready var right_arrow_area = $Area3D_right
@onready var right_arrow_sprite = $Area3D_right/right_arrow
@onready var left_arrow_area = $Area3D_left
@onready var left_arrow_sprite = $Area3D_left/left_arrow
@onready var up_arrow_area = $Area3D_up
@onready var up_arrow_sprite = $Area3D_up/up_arrow

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_killbox_area_entered(area):
	if area.is_in_group('arrows'):
		area.queue_free()

func _activate_down():
	pass
