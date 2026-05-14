extends Area2D

var dragging = false
var hovering := false
var drag_offset = Vector2.ZERO

func _ready() -> void:
    mouse_entered.connect(func(): hovering = true)
    mouse_exited.connect(func(): hovering = false)

func _input(event):
    if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
        if event.pressed and hovering:
            dragging = true
        else:
            dragging = false

func _process(delta):
    print(dragging)
