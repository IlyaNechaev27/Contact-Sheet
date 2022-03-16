//
//  ContactViewController.swift
//  Contact Sheet
//
//  Created by Илья Нечаев on 15.03.2022.
//

import UIKit

class ContactViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    
    public var contact: Contact!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    private func setupViewController() {
        firstNameLabel.text = contact.name?.first
        lastNameLabel.text = contact.name?.last
        
        if let imageURL = contact.picture?.large {
            NetworkManager.shared.fetchData(with: imageURL) { imageData in
                self.imageView.image = UIImage(data: imageData)
            }
        }
    }
}
