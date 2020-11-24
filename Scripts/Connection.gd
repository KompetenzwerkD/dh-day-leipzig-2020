extends Spatial
class_name Connection

var node_1
var node_2

func _on_node_scan() -> void:
	if node_1.scanned and node_2.scanned:
		visible = true
