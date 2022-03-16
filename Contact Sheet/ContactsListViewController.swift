//
//  ContactsListViewController.swift
//  Contact Sheet
//
//  Created by Илья Нечаев on 15.03.2022.
//

import UIKit

class ContactsListViewController: UITableViewController {
    private var contacts: [Contact] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        setupRefreshControl()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let contactVC = segue.destination as! ContactViewController
        contactVC.contact = sender as? Contact
    }
}

// MARK: - Private Methods
extension ContactsListViewController {
    @objc private func fetchData() {
        NetworkManager.shared.fetchContact { result in
            self.contacts = result
            self.tableView.reloadData()
            
            if self.refreshControl != nil {
                self.refreshControl?.endRefreshing()
            }
        }
    }
    
    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(fetchData), for: .valueChanged)
    }
}

// MARK: - UITAbleViewDelegate
extension ContactsListViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Segue.showContact.rawValue, sender: contacts[indexPath.row])
    }
}

// MARK: - UITAbleViewDataSource
extension ContactsListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Contact", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.imageProperties.maximumSize = CGSize(width: 100, height: 100)
        content.imageProperties.cornerRadius = 50
        
        let contact = contacts[indexPath.row]
        content.text = contact.name?.first
        content.secondaryText = contact.name?.last
        
        if let imageURL = contact.picture?.thumbnail {
            NetworkManager.shared.fetchData(with: imageURL) { imageData in
                content.image = UIImage(data: imageData)
                cell.contentConfiguration = content
            }
        }
        
        cell.contentConfiguration = content
        return cell
    }
}

