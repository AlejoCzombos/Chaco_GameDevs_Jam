class_name SpawnEnemigos
extends Node2D

onready var oleada:Oleada = $Oleada
func _ready() -> void:
	Eventos.connect("comenzar_oleada", self, "on_comenzar_oleada")

func on_comenzar_oleada(numero_oleada:int) -> void:
	print("Oleada comenzada")
	oleadas(numero_oleada)

func oleadas(num_oleada:int) -> void:
	match num_oleada:
		1:
			oleada.configurarOleada(Vector2(5,6), -1, 0,Vector2(5,6), 0, 3, 2)
			DatosJuego.cantidad_enemigos = 3
			pass
		2:
			oleada.configurarOleada(Vector2(5,6), -1, 0,Vector2(5,6), 0, 5, 2)
			DatosJuego.cantidad_enemigos = 5
			pass
		3:
			oleada.configurarOleada(Vector2(5,6), 0, 2,Vector2(5,6), 0, 5, 2)
			DatosJuego.cantidad_enemigos = 7
			pass
		4:
			oleada.configurarOleada(Vector2(5,6), 0, 5,Vector2(5,6), 0, 2, 2)
			DatosJuego.cantidad_enemigos = 7
			pass
		5:
			oleada.configurarOleada(Vector2(5,6), 0, 8,Vector2(5,6), -1, 0, 2)
			DatosJuego.cantidad_enemigos = 8
			pass
		6:
			oleada.configurarOleada(Vector2(5,6), 0, 8,Vector2(5,6), 2, 3, 2)
			DatosJuego.cantidad_enemigos = 11
			pass
		7:
			oleada.configurarOleada(Vector2(5,6), 0, 5,Vector2(5,6), 2, 6, 2)
			DatosJuego.cantidad_enemigos = 11
			pass
		8:
			oleada.configurarOleada(Vector2(5,6), 0, 5,Vector2(5,6), 2, 9, 2)
			DatosJuego.cantidad_enemigos = 14
			pass
		9:
			oleada.configurarOleada(Vector2(5,6), 3, 3,Vector2(5,6), 2, 10, 2)
			DatosJuego.cantidad_enemigos = 13
			pass
		10: 
			oleada.configurarOleada(Vector2(5,6), 3, 6,Vector2(5,6), 2, 6, 2)
			DatosJuego.cantidad_enemigos = 12
			pass
		11:
			oleada.configurarOleada(Vector2(5,6), 3, 10,Vector2(5,6), 5, 3, 2)
			DatosJuego.cantidad_enemigos = 13
			pass
		12:
			oleada.configurarOleada(Vector2(5,6), 3, 10,Vector2(5,6), 5, 6, 2)
			DatosJuego.cantidad_enemigos = 16
			pass
		13:
			oleada.configurarOleada(Vector2(5,6), 4, 3,Vector2(5,6), 5, 10, 2)
			DatosJuego.cantidad_enemigos = 13
			pass
		14:
			oleada.configurarOleada(Vector2(5,6), 4, 6,Vector2(5,6), 5, 13, 2)
			DatosJuego.cantidad_enemigos = 19
			pass
		15:
			oleada.configurarOleada(Vector2(5,6), 4, 9,Vector2(5,6), 3, 10, 2)
			DatosJuego.cantidad_enemigos = 19
			pass
		16:
			oleada.configurarOleada(Vector2(5,6), 4, 12,Vector2(5,6), 3, 12, 2)
			DatosJuego.cantidad_enemigos = 24
			pass
		_:
			printerr("ERROR OLEADA")
