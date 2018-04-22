/// handleCombo(cluster, x, y)

var required = 3;

var cluster = argument0;
var source = ds_grid_get(cluster.grid, argument1, argument2);

var found = ds_list_create();

var queue = ds_queue_create();
ds_queue_enqueue(queue, argument1, argument2);
while (!ds_queue_empty(queue)) {
    var gridX = ds_queue_dequeue(queue);
    var gridY = ds_queue_dequeue(queue);
    
    if (gridX < 0 || gridX >= ds_grid_width(cluster.grid)) continue;
    if (gridY < 0 || gridY >= ds_grid_height(cluster.grid)) continue;
    var ball = ds_grid_get(cluster.grid, gridX, gridY);
    
    if (!instance_exists(ball)) continue;
    if (ds_list_find_index(found, ball) >= 0) continue;
    if (ball.color != source.color) continue;
    
    ds_list_add(found, ball);
    ds_queue_enqueue(queue, gridX-1, gridY);
    ds_queue_enqueue(queue, gridX+1, gridY);
    ds_queue_enqueue(queue, gridX, gridY-1);
    ds_queue_enqueue(queue, gridX, gridY+1);
}
ds_queue_destroy(queue);

if (ds_list_size(found) >= required) {
    for (var i = 0; i < ds_list_size(found); ++i) {
        instance_destroy(ds_list_find_value(found, i));
    }
    fixCluster(cluster);
}

ds_list_destroy(found);

