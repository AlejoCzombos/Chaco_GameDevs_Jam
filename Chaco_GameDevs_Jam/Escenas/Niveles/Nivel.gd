class_name Nivel
extends Node2D

func _ready() -> void:
	Eventos.connect("disparo", self, "_on_disparo")
	Eventos.connect("instanciar_enemigo", self, "on_instanciar_enemigo")
	Eventos.connect("disparo_enemigo", self, "_on_disparo_enemigo")

func _on_disparo(proyectil:ProyectilPlayer) -> void:
	add_child(proyectil)

func _on_disparo_enemigo(proyectil:ProyectilEnemigo) -> void:
	call_deferred("add_child", proyectil)

func on_instanciar_enemigo(enemigo:EnemigoBase) -> void:
	add_child(enemigo)
