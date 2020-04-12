extends KinematicBody2D
class_name inimigo

var SPEED : int = 100
var motion : Vector2 = Vector2.ZERO
var dir : int = 1
var is_alive : bool = true
var cur_animation

onready var player : Node2D = get_parent().get_node("player")
onready var bloodsplash : PackedScene = preload("res://objetos/bloodsplash.tscn")
 


func _ready():
	GERENTE.inimigos_level = GERENTE.inimigos_level + 1
	

# warning-ignore:unused_argument
func _physics_process(delta):
	cur_animation = $anim.get_current_animation()
	$Sprite.scale.x = dir
#	motion.y += GRAVITY

	_movement()
	_anim()
# warning-ignore:return_value_discarded
	move_and_slide(motion)

	if is_on_wall():
		dir = -dir


func _movement() -> void:
	pass


func _anim() -> void:
	if motion.x != 0 && cur_animation != "bone1" && cur_animation != "bone2":
		$anim.play("run")


func _dead_to_bone() -> void:
	_explode_sangue_fx()
	cur_animation = "bone" + String(round(rand_range(1,3)))
	$anim.play(cur_animation)
	is_alive = false


func _explode_sangue_fx() -> void:
	var blood = bloodsplash.instance()
	get_parent().add_child(blood)
	get_parent().move_child(blood, 2)
	blood.position = position
	print(blood.name)
	

func _dead_to_die() -> void:
	_atualiza_contagem_inimigos()
	queue_free()
	

func _atualiza_contagem_inimigos() -> void:
	GERENTE.inimigos_level = GERENTE.inimigos_level - 1

func _on_hitbox_body_entered(body):
	## 
	## checa a colisão com o jogador
	## senão tiver com osso ele morde o inimigo
	##
	if body.name == "player" && !body.get_is_bone():
		body._mordida()
		_dead_to_bone()
		
		## se não tiver com o osso ele pega o osso
		if !is_alive:
			body._pega_osso()
			_dead_to_die()
