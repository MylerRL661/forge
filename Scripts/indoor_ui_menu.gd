extends Control

@onready var exit_button = $"CanvasLayer/Exit Button2/Exit Button"
var _allMissonsFinished : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if _allMissonsFinished == true:
		exit_button.visible = true


func _on_exit_button_pressed():
	SceneManager.change_scene("res://Scenes/game2.tscn", SceneManager.Transitions.FADE)
