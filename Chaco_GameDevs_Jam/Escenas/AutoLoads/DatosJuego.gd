extends Node

var player_actual = null
var camara_actual = null
var hud_actual = null
var cantidad_enemigos:int = 0
<<<<<<< HEAD
var oleada_actual:int = 1
=======
var oleada_actual:int = 7
var nivel_actual:String = ""
>>>>>>> 6781ce007377b81b31d9cc9079725eac4dd10e65

func _ready() -> void:
	Eventos.connect("oleada_terminada", self, "on_oleada_terminada")
	Eventos.connect("enemigos_totales", self, "on_enemigos_totales")

func on_enemigos_totales(enemigos:int) -> void:
	cantidad_enemigos = enemigos

func on_oleada_terminada() -> void:
	oleada_actual += 1
