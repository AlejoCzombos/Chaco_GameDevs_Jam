class_name Nivel
extends Node2D

onready var contenedor_enemigos:Node
onready var hud:HUD = $HUD
onready var mejora = $Mejora

func _ready() -> void:
	Eventos.emit_signal("comenzar_oleada", DatosJuego.oleada_actual)
	conectar_seniales()
	contenedor_enemigos = Node.new()
	contenedor_enemigos.name = "contenedor_enemigos"
	add_child(contenedor_enemigos)

func conectar_seniales() -> void:
# warning-ignore:return_value_discarded
	Eventos.connect("disparo", self, "_on_disparo")
# warning-ignore:return_value_discarded
	Eventos.connect("instanciar_enemigo", self, "on_instanciar_enemigo")
# warning-ignore:return_value_discarded
	Eventos.connect("disparo_enemigo", self, "_on_disparo_enemigo")
# warning-ignore:return_value_discarded
	Eventos.connect("descontar_enemigo", self, "on_descontar_enemigo")
# Esta es para las cartitas


func on_descontar_enemigo() -> void:
	DatosJuego.cantidad_enemigos -= 1
	if DatosJuego.cantidad_enemigos == 0:
		Eventos.emit_signal("oleada_terminada")
	hud.descontar_enemigos()

func _on_disparo(proyectil:ProyectilPlayer) -> void:
	add_child(proyectil)

func _on_disparo_enemigo(proyectil:ProyectilEnemigo) -> void:
	call_deferred("add_child", proyectil)

func on_instanciar_enemigo(enemigo:EnemigoBase) -> void:
	add_child(enemigo)

##### boton de prueba
func _on_Button_pressed():
	mejora.repartirCartas()
