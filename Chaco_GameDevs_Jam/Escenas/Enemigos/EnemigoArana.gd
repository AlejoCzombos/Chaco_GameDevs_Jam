class_name EnemigoArana
extends EnemigoBase

export var proyectil:PackedScene = null
export var velocidad_proyectil: int = 1000
export var danio_proyectil: float = 1

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Spawn":
		controladorEstado(ESTADO.VIVO)
		$AnimationPlayer.play("Correr Araña")

func disparar() -> void:
	for _i in range(rand_range(1,3)):
		var new_proyectil:ProyectilEnemigo = proyectil.instance()
		new_proyectil.crear(
			global_position,
			rand_range(0,360),
			velocidad_proyectil,
			danio_proyectil, 
			1
			)
		Eventos.emit_signal("disparo_enemigo", new_proyectil)
