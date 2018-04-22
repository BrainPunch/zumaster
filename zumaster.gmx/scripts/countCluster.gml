/// countCluster(cluster)

var grid = argument0.grid;
var count = 0;

for (var i = 0; i < ds_grid_width(grid); ++i) {
    for (var j = 0; j < ds_grid_height(grid); ++j) {
        if (instance_exists(ds_grid_get(grid, i, j))) {
            count += 1;
        }
    }
}

return count;
