extends Spatial

onready var tween = $Tween

onready var title_ui = $UI/Title
onready var about_ui = $UI/About
onready var start_ui = $UI/Start
onready var scan_ui = $UI/Scan
onready var content_ui = $UI/Content
onready var input_field = $InputField
onready var progress_ui = $UI/Progress

onready var ship: Ship = $Ship
var current_interactible:Interactible = null

# Called when the node enters the scene tree for the first time.
func _ready():
	for node in get_tree().get_nodes_in_group("Interactibles"):
		node.connect("show_scan_ui", self, "_on_show_scan_ui")
		node.connect("hide_scan_ui", self, "_on_hide_scan_ui")
		
	for node in $Targets.get_children():
		node.connect("was_scanned", progress_ui, "_on_planet_scanned")

func _on_Button_pressed():
	start_ui.visible = false
	
	tween.interpolate_property(
		title_ui,
		"modulate",
		Color.white,
		Color(1.0, 1.0, 1.0, 0.0),
		0.5,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN
	)

	tween.interpolate_property(
		about_ui,
		"modulate",
		Color.white,
		Color(1.0, 1.0, 1.0, 0.0),
		0.5,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN
	)	
	
	tween.start()
	
	yield(get_tree().create_timer(0.5), "timeout")
	title_ui.visible = false
	about_ui.visible = false
	input_field.accept_input = true


func _on_show_scan_ui(node: Interactible):
	current_interactible = node
	scan_ui.display(node)

func _on_hide_scan_ui():
	current_interactible = null
	scan_ui.visible = false


func _on_CloseContentButton_pressed():
	content_ui.close()
	input_field.accept_input = true


func _on_ScanButton_pressed():
	if current_interactible:
		content_ui.open(current_interactible.content)
		input_field.accept_input = false
		current_interactible.scan()
