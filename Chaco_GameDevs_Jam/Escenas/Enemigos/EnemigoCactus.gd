class_name EnemigoCactus
extends EnemigoBase

enum ESTADO_IA{ATACANDO, HUYENDO}

var estadoIAactual = ESTADO_IA.HUYENDO
var huyendo = false


func _process(delta) -> void:
	if player_objetivo != null && !stuneado && puede_moverse:
		movimiento = -global_position.direction_to(player_objetivo.global_position)
	elif stuneado:
		movimiento = lerp(movimiento, Vector2(0,0), 0.3)
	if huyendo:
		global_position += movimiento * (velocidad  * 5 ) * delta

func controladorEstado(nuevoEstado: int) -> void:
	match nuevoEstado:
		ESTADO.SPAWN:
			$DisparoEnemigo.esta_disparando = false
			colisionador.set_deferred("disabled", true)
			colisionadorArea.set_deferred("disabled", true)
		ESTADO.VIVO:
			$DisparoEnemigo.esta_disparando = true
			puede_moverse = true
			colisionador.set_deferred("disabled", false)
			colisionadorArea.set_deferred("disabled", false)
		ESTADO.MUERTO:
			Eventos.emit_signal("descontar_enemigo")
			puede_moverse = false
			colisionador.set_deferred("disabled", true)
			colisionadorArea.set_deferred("disabled", true)
			queue_free()
		_:
			printerr("Error estados")
	estadoActual = nuevoEstado


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
