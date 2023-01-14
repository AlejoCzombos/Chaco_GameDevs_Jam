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
			oleada.configurarOleada(Vector2(5,6), 0, 3,Vector2(5,6), 2, 1, 2)
			DatosJuego.cantidad_enemigos = 4
			pass
		2:
			print("oleada2")
			pass
		3:
			pass
		4:
			pass
		5:
			pass
		6:
			pass
		7:
			pass
		8:
			pass
		9:
			pass
		10: 
			pass
		11:
			pass
		12:
			pass
		13:
			pass
		14:
			pass
		15:
			pass
		16:
			pass
		_:
			printerr("ERROR OLEADA")
