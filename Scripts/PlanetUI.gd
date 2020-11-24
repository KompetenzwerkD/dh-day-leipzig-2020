extends Control

var target_pos
var current_interactible: Interactible

onready var camera = get_viewport().get_camera()

func _draw():
	draw_line(Vector2(target_pos.x+40, target_pos.y-300), target_pos - Vector2(-10, 75), Color.white, 2.0,true)
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func display(node: Interactible):
	current_interactible = node
	$Logo.texture = node.logo
	
	target_pos = camera.unproject_position(node.global_transform.origin)
	$Logo.rect_position = target_pos - Vector2(30,300)
	
	visible = true

func _process(_delta: float) -> void:	
	if visible:
		target_pos = camera.unproject_position(current_interactible.global_transform.origin)		
		$Logo.rect_position = target_pos - Vector2(30,300)
	update()
