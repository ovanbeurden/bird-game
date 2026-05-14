extends Node

@export var nut_scene: PackedScene = preload("res://scenes/nut.tscn")
@export var nut_types: Array[NutData] = [
	preload("res://resources/bluenut.tres"),
	preload("res://resources/purplenut.tres"),
	preload("res://resources/rednut.tres"),
]
@export var spawn_y := -1000.0
@export var min_spawn_interval := 0.6
@export var max_spawn_interval := 1.4
@export var horizontal_padding := 8.0

var _rng := RandomNumberGenerator.new()
var _spawn_cooldown := 0.0


func _ready() -> void:
	_rng.randomize()
	_reset_spawn_cooldown()


func _process(delta: float) -> void:
	_spawn_cooldown -= delta

	while _spawn_cooldown <= 0.0:
		_spawn_nut()
		_reset_spawn_cooldown()


func _spawn_nut() -> void:
	if nut_scene == null or nut_types.is_empty():
		return

	var nut := nut_scene.instantiate() as Area2D
	if nut == null:
		return

	var nut_type := nut_types[_rng.randi_range(0, nut_types.size() - 1)]
	nut.nut_data = nut_type

	var sprite := nut.get_node_or_null("Walnut") as Sprite2D
	if sprite != null and nut_type != null:
		sprite.texture = nut_type.texture

	var spawn_x := _get_random_spawn_x(sprite)
	nut.global_position = Vector2(spawn_x, spawn_y)
	add_child(nut)


func _get_random_spawn_x(sprite: Sprite2D) -> float:
	var visible_rect := _get_visible_world_rect()
	var half_width := horizontal_padding

	if sprite != null and sprite.texture != null:
		half_width += sprite.texture.get_width() * absf(sprite.scale.x) * 0.5

	var min_x := visible_rect.position.x + half_width
	var max_x := visible_rect.position.x + visible_rect.size.x - half_width

	if min_x >= max_x:
		return visible_rect.position.x + visible_rect.size.x * 0.5

	return _rng.randf_range(min_x, max_x)


func _get_visible_world_rect() -> Rect2:
	var camera := get_viewport().get_camera_2d()
	var viewport_size := get_viewport().get_visible_rect().size

	if camera == null:
		return Rect2(-viewport_size * 0.5, viewport_size)

	var visible_size := viewport_size * camera.zoom
	return Rect2(camera.global_position - visible_size * 0.5, visible_size)


func _reset_spawn_cooldown() -> void:
	_spawn_cooldown = _rng.randf_range(min_spawn_interval, max_spawn_interval)
