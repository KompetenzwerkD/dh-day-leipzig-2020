extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var institutes_found = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_planet_scanned():
	institutes_found += 1
	$ColorRect/InstituteCountLabel.text = str(institutes_found) + "/6"
