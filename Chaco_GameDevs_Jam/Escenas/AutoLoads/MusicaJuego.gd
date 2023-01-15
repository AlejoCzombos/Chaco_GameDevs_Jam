#MusicaJuego.gd
extends Node

## Atributos Export
export var tiempo_transicion:float = 4.0
export(float, -50.0, -20.0, 5.0) var volumen_apagado = -40.0

## Atributos Onready
onready var musica_nivel:AudioStreamPlayer = $MusicaNivel
onready var tween_musica_on:Tween = $TweenMusicaOn
onready var tween_musica_off:Tween = $TweenMusicaOff
onready var musica_menu:AudioStreamPlayer = $MusicaMenuPrincipal
onready var boton:AudioStreamPlayer = $Boton

## Atributos
var vol_original_musica_off:float = 0.0

## Metodos Custom
func set_streams(stream_nivel:AudioStream) -> void:
	musica_nivel.stream = stream_nivel

func play_musica_menu() -> void:
	stop_todo()
	musica_menu.play()

func play_musica_nivel() -> void:
	stop_todo()
	musica_nivel.play()

func play_boton() -> void:
	boton.play()

func stop_todo() -> void:
	for nodo in get_children():
		if nodo is AudioStreamPlayer:
			nodo.stop()

func fade_in(musica_fade_in: AudioStreamPlayer) -> void:
	var volumen_original = musica_fade_in.volume_db
	musica_fade_in.volume_db = volumen_apagado
	musica_fade_in.play()
	tween_musica_on.interpolate_property(
		musica_fade_in,
		"volume_db",
		volumen_apagado,
		volumen_original,
		tiempo_transicion,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN_OUT
	)
	tween_musica_on.start()

func fade_out(musica_fade_out: AudioStreamPlayer) -> void:
	vol_original_musica_off = musica_fade_out.volume_db
	tween_musica_off.interpolate_property(
		musica_fade_out,
		"volume_db",
		musica_fade_out.volume_db,
		volumen_apagado,
		tiempo_transicion,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN_OUT
	)
	tween_musica_off.start()

## Señales Internas
func _on_TweenMusicaOff_tween_completed(object: Object, _key: NodePath) -> void:
	object.stop()
	object.volume_db = vol_original_musica_off
