extends Area2D

var dragging = false
var hovering := false
var drag_offset = Vector2.ZERO
var drag_pointer_global_position = Vector2.ZERO
var active_touch_index := -1
@onready var drag_man = get_tree().get_root().get_node("BirdGame/DragMan")
@onready var bird = get_parent() as CharacterBody2D

func _ready() -> void:
    mouse_entered.connect(func(): hovering = true)
    mouse_exited.connect(func(): hovering = false)

func _input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
    if drag_man.current_dragged_object != null and drag_man.current_dragged_object != self:
        return

    if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
        if event.pressed:
            _start_drag(get_global_mouse_position())
        elif drag_man.current_dragged_object == self:
            _stop_drag()
        return

    if event is InputEventScreenTouch:
        if event.pressed:
            active_touch_index = event.index
            _start_drag(_viewport_to_global(event.position))
        elif drag_man.current_dragged_object == self and event.index == active_touch_index:
            _stop_drag()

func _input(event: InputEvent) -> void:
    if drag_man.current_dragged_object != self:
        return

    if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
        _stop_drag()
    elif event is InputEventMouseMotion:
        drag_pointer_global_position = get_global_mouse_position()
    elif event is InputEventScreenDrag and event.index == active_touch_index:
        drag_pointer_global_position = _viewport_to_global(event.position)
    elif event is InputEventScreenTouch and not event.pressed and event.index == active_touch_index:
        _stop_drag()

func _start_drag(pointer_global_position: Vector2) -> void:
    dragging = true
    drag_pointer_global_position = pointer_global_position
    drag_offset = bird.global_position - pointer_global_position
    drag_man.current_dragged_object = self
    bird.play_grab_sound()

func _stop_drag() -> void:
    dragging = false
    active_touch_index = -1
    drag_man.current_dragged_object = null

func _viewport_to_global(viewport_position: Vector2) -> Vector2:
    return get_canvas_transform().affine_inverse() * viewport_position
