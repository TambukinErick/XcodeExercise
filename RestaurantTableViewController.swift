import UIKit

struct Restaurant{
    var imageName: String?
    var name: String
}

class RestaurantTableViewController: UITableViewController {

	private static let restaurantTableReuseIdentifier = "Andok's Chicken"

    var restaurants = [
        Restaurant(imageName: "jollibeeImage", name: "Jolibee"),
        Restaurant(imageName: "mcdoPic", name: "McDonald's"),
        Restaurant(imageName: "Wendys", name: "Wendy's"),
        Restaurant(imageName: "tacoBelll", name: "Taco Bell"),
        Restaurant(imageName: "kFc", name: "KFC"),
        Restaurant(imageName: "burgerKing", name: "Burger King"),
    ]


	override func viewDidLoad() {
		super.viewDidLoad()

		tableView.register(
			RestaurantTableViewCell.self,
			forCellReuseIdentifier: RestaurantTableViewController.restaurantTableCellReuseIdentifier
		)
		tableView.delegate = self
		tableView.dataSource = self
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(
			withIdentifier: RestaurantTableViewController.restaurantTableCellReuseIdentifier,
			for: indexPath
		) as? RestaurantTableViewCell 
		else { return UITableViewCell() }

		let restaurant = restaurants[indexPath.row]
		cell.restaurantLabel.text = restaurant.text
		cell.myImageView.imageName = UIImage(systemName: imageName)
		// cell.myImageView.imageName = restaurant
		cell.myImageView.imageName = restaurant.imageName
		return cell
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)

		let restaurant = restaurants[indexPath.row]
		goToDetailsViewController(restaurant: restaurant)
	}

	func goToDetailsViewController(restaurant: Restuarant) {
		// Despite ProgrammaticTwitterViewController's UI not being defined by a xib,
		// you can still push or present other view controllers whose UI are defined by storyboards.
		// "DetailsViewController" is the file name of the storyboard.
		let storyboard = UIStoryboard(name: "DetailsViewController", bundle: nil)
		// The "detailsVCIdentifier" string is defined as the storyboard ID of the DetailsViewController
		guard let detailsViewController = storyboard.instantiateViewController(withIdentifier: "detailsVCIdentifier") as? DetailsViewController else { return }

		detailsViewController.restaurant = restaurant

		// This generally shows the new screen from the bottom going up.
//		present(detailsViewController, animated: true)
		// This generally shows the new screen from the right going to the left.
		navigationController?.pushViewController(detailsViewController, animated: true)
	}

	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return restaurants.count
	}
}