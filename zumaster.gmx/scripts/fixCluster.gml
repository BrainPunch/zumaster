/// fixCluster(cluster)

var cluster = argument0;
var grid = cluster.grid;
var angle = cluster.image_angle;

// Reset the original cluster
cluster.grid = ds_grid_create(1, 1);
ds_grid_clear(cluster.grid, noone);

// List every cell to check
var queue = ds_queue_create();
for (var i = 0; i < ds_grid_width(grid); ++i) {
    for (var j = 0; j < ds_grid_height(grid); ++j) {
        var root = ds_grid_get(grid, i, j);
        if (!instance_exists(root)) continue;
        
        cluster.x = root.x;
        cluster.y = root.y;
        cluster.image_angle = angle;
        
        ds_queue_clear(queue);
        ds_queue_enqueue(queue, i, j);
        while (!ds_queue_empty(queue)) {
            var gridX = ds_queue_dequeue(queue);
            var gridY = ds_queue_dequeue(queue);
            if (gridX < 0 || gridX >= ds_grid_width(grid)) continue;
            if (gridY < 0 || gridY >= ds_grid_height(grid)) continue;
            var ball = ds_grid_get(grid, gridX, gridY);
            if (!instance_exists(ball)) continue;
            
            ball.grid = noone;
            ds_grid_set(grid, gridX, gridY, noone);
            addBallToCluster(ball, cluster);
            
            ds_queue_enqueue(queue, gridX-1, gridY);
            ds_queue_enqueue(queue, gridX+1, gridY);
            ds_queue_enqueue(queue, gridX, gridY-1);
            ds_queue_enqueue(queue, gridX, gridY+1);
        }
        
        if (countCluster(cluster) == 1) {
            root.grid = noone;
            instance_destroy(cluster);
        }
        
        cluster = instance_create(root.x, root.y, obj_cluster);
    }
}
ds_queue_destroy(queue);

ds_grid_destroy(grid);
instance_destroy(cluster);
