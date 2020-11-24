extends Spatial

var connection_scene = preload("res://Objects/Connection.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	
	var done = []
	
	for source in get_node("../Targets").get_children():
		for target in get_node("../Targets").get_children():
			var label = source.name + target.name
			if source == target or label in done or !(source.in_network and target.in_network):
				continue
				
			var dist_vec = source.global_transform.origin - target.global_transform.origin
			var length = dist_vec.length()
			var origin = source.global_transform.origin - dist_vec / 2
			
			var conn = connection_scene.instance()
			add_child(conn)
			conn.scale.z = length / 2
			conn.scale.x = 0.15
			conn.scale.y = 0.15
			conn.global_transform.origin = origin
			conn.look_at(source.global_transform.origin, Vector3.UP)
			conn.visible = false
			
			conn.node_1 = source
			conn.node_2 = target
			
			done.append(label)
			done.append(target.name+source.name)
			
			source.connect("was_scanned", conn, "_on_node_scan")
			target.connect("was_scanned", conn, "_on_node_scan")

