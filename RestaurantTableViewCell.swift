import UIKit

class RestaurantTableViewCell: UITableViewCell {
	let restaurantLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	let myImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		let heightConstraint = imageView.heightAnchor.constraint(equalToConstant: 100)
		let widthConstraint = imageView.widthAnchor.constraint(equalToConstant: 100)
		heightConstraint.isActive = true
		widthConstraint.isActive = true

		return imageView
	}()

	let stackView: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .horizontal
		stackView.alignment = .leading
		stackView.spacing = 10.0
		return stackView
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupUI()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupUI()
	}

	func setupUI() {

		// Use V2 for a flexible layout that uses a UIStackView
		setupUIV2()
	}


	func setupUIV2() {
		contentView.addSubview(stackView)
		stackView.addArrangedSubview(myImageView)
		stackView.addArrangedSubview(restaurantLabel)

		let constraints = [
			stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
			stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
		]
		NSLayoutConstraint.activate(constraints)
	}

	lazy var string: String = {
		print("Creating string...")
		return "Test"
	}()

	func onTap() {
		print(string)
	}
}