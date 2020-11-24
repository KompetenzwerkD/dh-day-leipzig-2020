extends Control

var current_open_node: Control = null

onready var close_button = $CloseContentButton

func open(content_node: Control) -> void:
	if content_node:
		self.visible = true
		content_node.visible = true
		current_open_node = content_node
		close_button.visible = true
	
func close() -> void:
	if current_open_node:
		self.visible = false
		current_open_node.visible = false
		close_button.visible = false
