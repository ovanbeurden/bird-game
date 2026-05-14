extends Area2D

var dragging = false
var drag_offset = Vector2.ZERO

func _input(event):
    if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:

        if event.pressed:
            dragging = true
        else:
            dragging = false

func _process(delta):
    print(dragging)
