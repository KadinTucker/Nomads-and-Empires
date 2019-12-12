

/**
 * Defining locations and some functions using locations
 * Locations are two dimensional and integers. 
 * Distances between these locations are calculated using the moderate distance formula. 
 */
pub struct Location {
    pos_x: i32,
    pos_y: i32
}

pub fn build_location(x: i32, y: i32) -> Location {
    Location {
        pos_x: x,
        pos_y: y
    }
}

/**
 * Returns a distance using the 'moderate distance formula'
 * This is a formula calculated by taking the diagonals (of length sqrt2)
 * as many times as possible and computing the rest using Manhattan distance.
 * This formula is much faster and somewhat more realistic. 
 */
pub fn get_moderate_distance(p1: Location, p2: Location) -> f64 {
    let diff_x = abs(p1.pos_x - p2.pos_x);
    let diff_y = abs(p1.pos_y - p2.pos_y);
    let diff_xy = abs(diff_x - diff_y);
    (diff_xy as f64) + 1.41 * ((max(diff_x, diff_y) - diff_xy) as f64)
}

fn abs(x: i32) -> i32 {
    if x < 0 {
        return -1 * x;
    }
    x
}

fn max(x: i32, y: i32) -> i32 {
    if x > y {
        return x;
    }
    y
}


struct Town {
    location: Location, //The location of the town
    population: i32, //How many people live in the town. Grows logistically, with prosperity determining the maximum
    prosperity: f64, //How prosperous the town is. Decays proportional to its own size
    goods: i32, //How much stuff is currently in the town
    avg_good_dist: f64, //The average distance travelled of the goods along trade routes
    //Alternative: make avg_good_dist a standard deviation value; this is a measure of exoticness. 
    avg_good_origin: Location //The average location of origin of local goods
}

/**
 * Sells goods from the origin to the destination
 */
fn add_goods(origin: &mut Town, destination: &mut Town, num_goods: i32) {
    origin.goods -= num_goods;
    destination.avg_good_dist = 
            (destination.avg_good_dist * destination.goods as f64 + origin.avg_good_dist * num_goods as f64 + get_moderate_distance(origin.avg_good_origin, destination.avg_good_origin)) 
            / ((destination.goods + num_goods) as f64);
    //TODO: implement the same adding method for locations
}