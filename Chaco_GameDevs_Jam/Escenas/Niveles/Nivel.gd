class_name Nivel
extends Node2D

func _ready() -> void:
	Eventos.connect("disparo", self, "_on_disparo")
	Eventos.connect("instanciar_enemigo", self, "on_instanciar_enemigo")

func _on_disparo(proyectil:Proyectil) -> void:
	add_child(proyectil)

func on_instanciar_enemigo(enemigo:EnemigoBase) -> void:
	add_child(enemigo)
