extends Node2D

@onready var sprite = $Sprite2D
@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

@export var animation_duration := 0.5
@export var start_scale_multiplier := 0.0
@export var end_scale_multiplier := 2.4
@export var explosion_sound: AudioStream

var _elapsed_time := 0.0
var _base_scale := Vector2.ONE


func _ready() -> void:
    _base_scale = scale
    scale = _base_scale * start_scale_multiplier
    audio_player.stream = explosion_sound
    audio_player.play()


func _process(delta: float) -> void:
    _elapsed_time += delta
    var progress := minf(_elapsed_time / animation_duration, 1.0)
    var eased_progress := 1.0 - pow(1.0 - progress, 3.0)
    var scale_multiplier := lerpf(start_scale_multiplier, end_scale_multiplier, eased_progress)
    scale = _base_scale * scale_multiplier

    if progress >= 1.0:
        queue_free()