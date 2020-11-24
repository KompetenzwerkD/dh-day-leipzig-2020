extends Button

export var url: String
export var label: String = "[ website ]"

func _ready():
	connect("pressed", self, "_on_pressed")
	$Label.text = label
	
func _on_pressed() -> void:
	OS.shell_open(url)

