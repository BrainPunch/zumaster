/// spawnClump(x, y)

var cx = argument0;
var cy = argument1;

var range = 250;
repeat (irandom_range(12, 24)) {
    var px = random_range(-range, range)+cx;
    var py = random_range(-range, range)+cy;
    var ball = instance_create(px, py, obj_ball);
    var force = 120;
    var dist = point_distance(px, py, cx, cy);
    with (ball) physics_apply_impulse(px, py,
        force*(cx-px)/dist,
        force*(cy-py)/dist);
}
