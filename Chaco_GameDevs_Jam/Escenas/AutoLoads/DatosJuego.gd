extends Node

var player_actual = null
var cantidad_enemigos:int = 0
var oleada_actual:int = 1

func _ready() -> void:
	Eventos.connect("oleada_terminada", self, "on_oleada_terminada")

func on_oleada_terminada() -> void:
	oleada_actual += 1
	Eventos.emit_signal("comenzar_oleada", oleada_actual)
