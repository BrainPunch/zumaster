/// countClumpSize(ball)

var visited = ds_map_create();
var queue = ds_queue_create();

ds_queue_enqueue(queue, argument0);
while (!ds_queue_empty(queue)) {
    var ball = ds_queue_dequeue(queue);
    if (ds_map_exists(visited, ball)) continue;
    if (!instance_exists(ball)) continue;
    
    ds_map_add(visited, ball, true);
    
    var key = ds_map_find_first(ball.adjacent);
    repeat (ds_map_size(ball.adjacent)) {
        ds_queue_enqueue(queue, key);
        key = ds_map_find_next(ball.adjacent, key);
    }
}

var count = ds_map_size(visited);
ds_queue_destroy(queue);
ds_map_destroy(visited);

return count;
