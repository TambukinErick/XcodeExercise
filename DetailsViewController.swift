

import UIKit

class DetailsViewController: UIViewController {

	var restaurant: Restaurant?
	@IBOutlet weak var textLabel: UILabel!




	override func viewDidLoad() {
		super.viewDidLoad()
		textLabel?.name = restaurant?.name ?? "No resto yet"
	}
}