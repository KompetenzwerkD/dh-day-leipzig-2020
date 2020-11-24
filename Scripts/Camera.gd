extends Camera


onready var ship = get_node("../Ship")

# Called when the node enters the scene tree for the first time.
func _ready():
	global_transform = ship.camera_pos.global_transform

func _process(delta: float):
	global_transform = global_transform.interpolate_with(ship.camera_pos.global_transform, delta*15)

