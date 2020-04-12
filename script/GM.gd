extends Node2D

export var next_level : PackedScene
var inimigos_contagem : int


func _process(delta):
	inimigos_contagem = GERENTE.inimigos_level


func _on_pilha_pilha_completa():
	## GO TO NEXT LEVEL \o/
	get_tree().change_scene(next_level.resource_path)
	pass # Replace with function body.
