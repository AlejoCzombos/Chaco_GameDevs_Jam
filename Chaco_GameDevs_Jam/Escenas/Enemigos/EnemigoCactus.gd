class_name EnemigoCactus
extends EnemigoBase

enum ESTADO_IA{ATACANDO, HUYENDO}

var estadoIAactual = ESTADO_IA.HUYENDO
var huyendo = false

func _ready() -> void:
	$DisparoEnemigo.esta_disparando = true

func _process(delta) -> void:
	if player_objetivo != null && !stuneado && puede_moverse:
		movimiento = -global_position.direction_to(player_objetivo.global_position)
	elif stuneado:
		movimiento = lerp(movimiento, Vector2(0,0), 0.3)
	if huyendo:
		global_position += movimiento * (velocidad  * 5 ) * delta

func controladorEstadoIA(nuevoEstado: int) -> void:
	match nuevoEstado:
		ESTADO_IA.ATACANDO:
			huyendo = false
			puede_moverse = false
			$DisparoEnemigo.esta_disparando = true
		ESTADO_IA.HUYENDO:
			$DisparoEnemigo.esta_disparando = false
			puede_moverse = true
			huyendo = true
		_:
			printerr("Error estados")
	estadoIAactual = nuevoEstado

func _on_AreaPersecusion_body_entered(_body):
	controladorEstadoIA(ESTADO_IA.HUYENDO)

func _on_AreaSalirPersecusion_body_exited(_body):
	controladorEstadoIA(ESTADO_IA.ATACANDO)
