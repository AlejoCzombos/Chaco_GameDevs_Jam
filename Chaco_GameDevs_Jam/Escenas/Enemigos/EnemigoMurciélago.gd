extends EnemigoBase

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Spawn":
		controladorEstado(ESTADO.VIVO)
		$AnimationPlayer.play("Correr Murcielago")

