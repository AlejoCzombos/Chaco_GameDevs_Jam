class_name ProyectilPlayer
extends Proyectil

var nivel_proyectil:int = 0

func crear(pos: Vector2, dir: float, vel: float, nuevo_danio:float, nivel:int) -> void:
	position = pos
	rotation = dir
	velocidad = Vector2(vel, 0).rotated(dir)
	danio = nuevo_danio
	nivel_proyectil = nivel
	cambio_nivel_proyectil()

func cambio_nivel_proyectil() -> void:
	if nivel_proyectil < 4:
		var nivel = "Nivel" + str(nivel_proyectil)
		$AnimatedSprite.play(nivel)
	nivel_proyectil += 1
