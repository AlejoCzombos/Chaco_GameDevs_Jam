extends CanvasLayer


## VIDA
onready var vidaMax = $Vida/VidaContainer/ProgressBar/Letras/VidaMax.text
onready var barVidaMax = $Vida/VidaContainer/ProgressBar.max_value
onready var vidaActual = $Vida/VidaContainer/ProgressBar/Letras/VidaActual.text
onready var barVidaActual = $Vida/VidaContainer/ProgressBar.value


## ENEMIGOS
onready var enemigosRestantes = $Enemigos/EnemigosContainer/ProgressBar/Enemigos.text
onready var barEnemigosRestantes = $Enemigos/EnemigosContainer/ProgressBar.value 
onready var barEnemigosTotales = $Enemigos/EnemigosContainer/ProgressBar.max_value

##RONDAS 
onready var labelRondas = $Rondas.text 


func _ready():
	visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	

func set_vida_maxima(vidaMaxima):
	vidaMax = vidaMaxima
	barVidaMax = vidaMaxima 


func set_vida_actual(vidaAct):
	vidaActual = vidaAct
	barVidaActual = vidaAct 
	
func set_enemigos_restantes(enemigos):
	enemigosRestantes = enemigos
	barEnemigosRestantes = enemigos
	
func set_enemigos_totales(enemigos):
	barEnemigosTotales = enemigos

func set_ronda(n):
	labelRondas = n
