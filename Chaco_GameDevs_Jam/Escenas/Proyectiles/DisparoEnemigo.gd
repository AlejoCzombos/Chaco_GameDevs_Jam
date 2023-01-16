extends Node2D

export var cadencia_disparo: float = 0.1
export var velocidad_proyectil: int = 300
export var danio_proyectil: float = 2
export var proyectil:PackedScene = null

onready var punto_disparo:Position2D = $PosicionDisparo
onready var timer_enfriamiento: Timer = $TimerEnfriamiento
onready var esta_enfriado:bool = true
onready var esta_disparando:bool = false
onready var player_objetivo = null

func _ready() -> void:
	timer_enfriamiento.wait_time = cadencia_disparo
	player_objetivo = DatosJuego.player_actual

# warning-ignore:unused_argument
func _process(delta):
	if esta_disparando && esta_enfriado:
		disparar()

func disparar() -> void:
	esta_enfriado = false
	timer_enfriamiento.start()
	var new_proyectil:ProyectilEnemigo = proyectil.instance()
	
	#rotacion disparo
	var dir_player = player_objetivo.global_position - global_position
	
	new_proyectil.crear(
		punto_disparo.global_position,
		dir_player.angle(),
		velocidad_proyectil,
		danio_proyectil,
		2
		)
	Eventos.emit_signal("disparo_enemigo", new_proyectil)

func _on_TimerEnfriamiento_timeout():
	esta_enfriado = true
