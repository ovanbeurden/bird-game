extends Node2D

var dragging = false
var drag_offset = Vector2.ZERO
var gravity_factor = 10
var mass = 10
var down_speed = 0

func _input_event(viewport, event, shape_idx):

    if event is InputEventMouseButton:
        if event.button_index == MOUSE_BUTTON_LEFT:

            if event.pressed:
                dragging = true
                drag_offset = global_position - get_global_mouse_position()

            else:
                dragging = false

        
func gravity() -> void:
    if dragging == false:
        if position.y < 0:
            down_speed += gravity_factor/mass
        else:
            position.y = 0
            down_speed = 0
        
        if position.y < down_speed:
            position.y += down_speed
        else:
            position.y = 0
    else:
        down_speed = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    gravity()
    print(position.y)
    if dragging:
        global_position = get_global_mouse_position() + drag_offset
    
