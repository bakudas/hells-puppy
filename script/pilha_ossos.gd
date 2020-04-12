extends Node2D

signal pilha_completa


var frame : int = 0


func _process(delta):
	$sprite.frame = frame
	
	if $sprite.frame == 3:
		emit_signal("pilha_completa")


func add_frame() -> void:
	frame += 1


func _on_Area2D_body_entered(body):
	if body.name == "player" && body.get_is_bone():
		add_frame()
		body._entrega_osso()
