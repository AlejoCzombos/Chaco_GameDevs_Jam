class_name Nivel
extends Node2D

onready var contenedor_enemigos:Node

func _ready() -> void:
	Eventos.emit_signal("comenzar_oleada", DatosJuego.oleada_actual)
	conectar_seniales()
	contenedor_enemigos = Node.new()
	contenedor_enemigos.name = "contenedor_enemigos"
	add_child(contenedor_enemigos)

func conectar_seniales() -> void:
	Eventos.connect("disparo", self, "_on_disparo")
	Eventos.connect("instanciar_enemigo", self, "on_instanciar_enemigo")
	Eventos.connect("disparo_enemigo", self, "_on_disparo_enemigo")
	Eventos.connect("descontar_enemigo", self, "on_descontar_enemigo")

func on_descontar_enemigo() -> void:
	DatosJuego.cantidad_enemigos -= 1
	if DatosJuego.cantidad_enemigos == 0:
		Eventos.emit_signal("oleada_terminada")

func _on_disparo(proyectil:ProyectilPlayer) -> void:
	add_child(proyectil)

func _on_disparo_enemigo(proyectil:ProyectilEnemigo) -> void:
	call_deferred("add_child", proyectil)

func on_instanciar_enemigo(enemigo:EnemigoBase) -> void:
	add_child(enemigo)
