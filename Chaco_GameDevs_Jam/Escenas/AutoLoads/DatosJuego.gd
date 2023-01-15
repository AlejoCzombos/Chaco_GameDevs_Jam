extends Node

var player_actual = null
var camara_actual = null
var hud_actual = null
var cantidad_enemigos:int = 0
var oleada_actual:int = 7

func _ready() -> void:
	Eventos.connect("oleada_terminada", self, "on_oleada_terminada")
	Eventos.connect("enemigos_totales", self, "on_enemigos_totales")

func on_enemigos_totales(enemigos:int) -> void:
	cantidad_enemigos = enemigos

func on_oleada_terminada() -> void:
	oleada_actual += 1
