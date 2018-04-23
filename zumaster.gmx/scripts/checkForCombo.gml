/// checkForCombo(ball)

var root = argument0;
var visited = ds_map_create();

var queue = ds_queue_create();
ds_queue_enqueue(queue, root);
while (!ds_queue_empty(queue)) {
    var ball = ds_queue_dequeue(queue);
    if (!instance_exists(ball)) continue;
    if (ds_map_exists(visited, ball)) continue;
    if (ball.color != root.color) continue;
    
    ds_map_add(visited, ball.id, true);
    
    var key = ds_map_find_first(ball.adjacent);
    repeat (ds_map_size(ball.adjacent)) {
        ds_queue_enqueue(queue, key);
        key = ds_map_find_next(ball.adjacent, key);
    }
}
ds_queue_destroy(queue);

if (ds_map_size(visited) >= 5) {
    var ball = ds_map_find_first(visited);
    repeat (ds_map_size(visited)) {
        instance_destroy(ball);
        ball = ds_map_find_next(visited, ball);
    }
}
ds_map_destroy(visited);
