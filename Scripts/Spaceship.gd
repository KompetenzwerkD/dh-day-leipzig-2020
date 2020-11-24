extends KinematicBody
class_name Ship

var target: Vector3 = Vector3.ZERO

var speed: float = 10.0
var acc: float = 2.0
var decc: float = 2.0
var turn: float = 3.0

var velocity: Vector3 = Vector3.ZERO

onready var camera_pos = $CameraPositon
onready var origin_camera_pos = camera_pos.transform.origin

func _ready():
	pass # Replace with function body.



func set_target (new_target: Vector3) -> void:
	if new_target != Vector3.ZERO and !$TargetMarker.visible:
		$TargetMarker.visible = true
	elif new_target == Vector3.ZERO:
		$TargetMarker.visible = false
	
	target = Vector3(new_target.x, target.y, new_target.z)
	
	$TargetMarker.transform.origin = to_local(target).normalized() * 3
	
	#$BetweenMarker.transform.origin = $FwdMarker.transform.origin.linear_interpolate($TargetMarker.transform.origin, 0.02).normalized() * 3
	
func _process(delta: float) -> void:
	if target:
		var fwd = -global_transform.basis.z.normalized()
		if Vector3.FORWARD.angle_to(to_local(target)) > 0.05:
			var target_vec = Vector3.FORWARD.linear_interpolate(to_local(target).normalized(), 0.05)
			look_at(to_global(target_vec), Vector3.UP)
	
	camera_pos.transform.origin = origin_camera_pos * (1 + velocity.length() * 0.075)
	
	
	
	if velocity.length() < 0.1 and $Ignition.emitting:
		$Ignition.emitting = false
	elif velocity.length() > 0.1 and not $Ignition.emitting:
		$Ignition.emitting = true

func _physics_process(_delta: float) -> void:
	$FwdMarker.transform.origin = Vector3.FORWARD * 3

	if target:
		velocity += -global_transform.basis.z * 2
		
	velocity = move_and_slide(velocity, Vector3.UP)
	
	velocity *= 0.9
