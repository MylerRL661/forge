extends Node3D

var _isMouseAndKeyboard : bool = false
var DeadZone : float = 0.4

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event is InputEventKey or InputEventMouse:
		_isMouseAndKeyboard = true
		print("MandK True")
	if event is InputEventJoypadMotion or InputEventJoypadButton:
		_isMouseAndKeyboard = false
		print("MandK False")
