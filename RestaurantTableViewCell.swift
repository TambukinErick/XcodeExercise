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
		let widthConstraint = view.widthAnchor.constraint(equalToConstant: 100)
		heightConstraint.isActive = true
		widthConstraint.isActive = true

		return imageView
	}()

	let stackView: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .horizontal
		stackView.alignment = .leading
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
		// Use V1 for a non-flexible layout that does not use a UIStackView
//		setupUIV1()
		// Use V2 for a flexible layout that uses a UIStackView
		setupUIV2()
	}

	func setupUIV1() {
		restaurantLabel.translatesAutoresizingMaskIntoConstraints = false
		myImageView.translatesAutoresizingMaskIntoConstraints = false

		contentView.addSubview(restaurantLabel)
		contentView.addSubview(myImageView)

		let constraints = [
			restaurantLabel.topAnchor.constraint(equalTo: myImageView.bottomAnchor),
			restaurantLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			restaurantLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			restaurantLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

			myImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
			myImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
		]
		NSLayoutConstraint.activate(constraints)
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

	// MARK: Exhibiting lazy variables.
	lazy var string: String = {
		print("Creating string...")
		return "Test"
	}()

	func onTap() {
		print(string)
	}
}