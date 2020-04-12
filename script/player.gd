extends KinematicBody2D


var GRAVITY : float = 9.8
var SPEED : int = 100
var motion : Vector2 = Vector2.ZERO
var is_bone : bool = false setget set_is_bone, get_is_bone
var dir : int = 1
var cur_animation


func _physics_process(delta):
	cur_animation = $anim.get_current_animation()
	$dog.scale.x = dir
#	motion.y += GRAVITY
	
	_controls(delta)
	_anim()
# warning-ignore:return_value_discarded
	move_and_slide(motion)


# warning-ignore:unused_argument
func _controls(delta) -> void:
	var left:bool = Input.is_action_pressed("ui_left")
	var right:bool = Input.is_action_pressed("ui_right")
	var atk:bool = Input.is_action_just_pressed("ui_select")
	
	if left:
		motion.x = -SPEED
		dir = -1
	elif right:
		motion.x = SPEED
		dir = 1
	else: 
		motion.x = 0
		
	if atk:
		pass


func _anim():
	
	if motion.x != 0 && cur_animation != "bite":
		if !is_bone:
			$anim.play("run")
		else:
			$anim.play("run_bone")
	elif motion.x == 0 && cur_animation != "bite":
		if !is_bone:
			$anim.play("idle")
		else:
			$anim.play("idle_bone")


func _mordida() -> void:
	if !get_is_bone():
		cur_animation = "bite"
		$anim.play("bite")
		yield($anim, "animation_finished")
		# TOCAR SOM DA MORDIDA
		print("mordeu!")


func _pega_osso() -> void:
	set_is_bone(true)


func get_is_bone() -> bool:
	return is_bone


func set_is_bone(value) -> void:
	is_bone = value


func _entrega_osso() -> void:
	set_is_bone(false)


func _on_gatilhos_body_entered(body):
	if body.name == "player":
		position = Vector2(203, 149)


func _on_gatilhos2_body_entered(body):
	if body.name == "player":
		position = Vector2(203,213)


func _on_gatilhos3_body_entered(body):
	if body.name == "player":
		position = Vector2(20,85)


func _on_gatilhos4_body_entered(body):
	if body.name == "player":
		position = Vector2(203,276)


func _on_gatilhos5_body_entered(body):
	if body.name == "player":
		position = Vector2(20,149)


func _on_gatilhos6_body_entered(body):
	if body.name == "player":
		position = Vector2(20,213)
