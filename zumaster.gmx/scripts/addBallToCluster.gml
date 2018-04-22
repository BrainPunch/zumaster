/// addBallToCluster(ball, cluster)

var ball = argument0;
var cluster = argument1;

var gridX = round((ball.x - cluster.x) / cluster.spacing);
var gridY = round((ball.y - cluster.y) / cluster.spacing);

if (gridX < 0) {
    var oldWidth = ds_grid_width(cluster.grid);
    var oldHeight = ds_grid_height(cluster.grid);
    var newGrid = ds_grid_create(oldWidth+1, oldHeight);
    ds_grid_clear(newGrid, noone);
    ds_grid_set_grid_region(newGrid, cluster.grid, 0, 0, oldWidth-1, oldHeight-1, 1, 0);
    ds_grid_destroy(cluster.grid);
    cluster.grid = newGrid;
    cluster.x -= cluster.spacing;
    gridX = 0;
}
if (gridY < 0) {
    var oldWidth = ds_grid_width(cluster.grid);
    var oldHeight = ds_grid_height(cluster.grid);
    var newGrid = ds_grid_create(oldWidth, oldHeight+1);
    ds_grid_clear(newGrid, noone);
    ds_grid_set_grid_region(newGrid, cluster.grid, 0, 0, oldWidth-1, oldHeight-1, 0, 1);
    ds_grid_destroy(cluster.grid);
    cluster.grid = newGrid;
    cluster.y -= cluster.spacing;
    gridY = 0;
}
if (gridX >= ds_grid_width(cluster.grid)) {
    var oldWidth = ds_grid_width(cluster.grid);
    var oldHeight = ds_grid_height(cluster.grid);
    ds_grid_resize(cluster.grid, oldWidth+1, oldHeight);
    ds_grid_set_region(cluster.grid, oldWidth, 0, oldWidth, oldHeight-1, noone);
    gridX = oldWidth;
}
if (gridY >= ds_grid_height(cluster.grid)) {
    var oldWidth = ds_grid_width(cluster.grid);
    var oldHeight = ds_grid_height(cluster.grid);
    ds_grid_resize(cluster.grid, oldWidth, oldHeight+1);
    ds_grid_set_region(cluster.grid, 0, oldHeight, oldWidth-1, oldHeight, noone);
    gridY = oldHeight;
}

if (!instance_exists(ds_grid_get(cluster.grid, gridX, gridY))) {
    ds_grid_set(cluster.grid, gridX, gridY, ball);
    ball.grid = cluster;
}
