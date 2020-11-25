extends StaticBody
class_name Interactible

signal show_scan_ui
signal hide_scan_ui
signal was_scanned

var scanned = false

export var logo: Texture
export var content_node: NodePath
var content: Control

export var object_mesh: Mesh
export var in_network: bool = true

export var mesh: Mesh
export var material: SpatialMaterial

export (Array, NodePath) var conditions = []
var condition_count = 0

export var rotation_on: bool = true
export var rotate_axis: String = "y"
export var mesh_scale: float = 1.0

export var is_kowed: bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("Interactibles")
	content = get_node(content_node)
	
	if mesh:
		$Sphere.mesh = mesh
	if material:
		$Sphere.material_override = material
		
	$Sphere.scale *= mesh_scale
	
	if mesh_scale != 1:
		$CollisionShape.scale *= mesh_scale
		
	if conditions.size() > 0:
		visible = false
		$Area/CollisionShape.disabled = true
		$CollisionShape.disabled = true
		for nodepath in conditions:
			var node: Interactible = get_node(nodepath)
			node.connect("was_scanned", self, "_on_condition_was_scanned")


func _process(delta: float) -> void:
	if rotation_on:
		if rotate_axis == "z":
			$Sphere.rotate_z(delta * 0.3)
		else:
			$Sphere.rotate_y(delta * 0.3)


func _on_Area_body_entered(body) -> void:
	emit_signal("show_scan_ui", self)


func _on_Area_body_exited(body):
	emit_signal("hide_scan_ui")
	
func scan() -> void:
	if !scanned and (in_network or is_kowed):
		scanned = true
		emit_signal("was_scanned")

func _on_condition_was_scanned() -> void:
	print("condition scan event")
	condition_count += 1
	if condition_count == conditions.size():
		visible = true
		$Area/CollisionShape.disabled = false
		$CollisionShape.disabled = true
