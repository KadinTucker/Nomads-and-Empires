mod package;

fn main() {
    println!("Hello, world!");
    println!("{}", package::town::get_moderate_distance(package::town::build_location(12, 16), package::town::build_location(6, 11)));
}
