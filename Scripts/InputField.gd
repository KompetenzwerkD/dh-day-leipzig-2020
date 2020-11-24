extends Area


onready var ship = get_node("../Ship")

var accept_input: bool = false

func _ready():
	pass # Replace with function body.


var rotate = false

func _on_InputField_input_event(camera, event: InputEvent, click_position, click_normal, shape_idx):
	if accept_input:
		if event is InputEventMouseButton and event.pressed:
			#ship.global_transform.origin = click_position
			ship.set_target(click_position)
			rotate = true
		elif event is InputEventMouseButton and not event.pressed:
			#ship.global_transform.origin = click_position
			ship.set_target(Vector3.ZERO)
			rotate = false
			
		if rotate:
			ship.set_target(click_position)
