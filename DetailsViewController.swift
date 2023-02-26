//
//  DetailsViewController.swift
//  Testing
//
//  Created by Luis Ligunas on 2/8/23.
//

import UIKit

class DetailsViewController: UIViewController {

	var restaurant: Restaurant?
	@IBOutlet weak var textLabel: UILabel!

	


	override func viewDidLoad() {
		super.viewDidLoad()
		textLabel?.text = restaurant?.text ?? "No resto yet"
	}
}