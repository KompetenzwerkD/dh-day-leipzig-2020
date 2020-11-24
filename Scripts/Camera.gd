extends Camera


onready var ship = get_node("../Ship")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta: float):
	global_transform = global_transform.interpolate_with(ship.camera_pos.global_transform, delta*15)

