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
    }
}

// MARK: - Private Methods
extension ContactsListViewController {
    private func fetchData() {
        NetworkManager.shared.fetchContact { result in
            self.contacts = result
            print(result)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
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
        
        cell.contentConfiguration = content
        return cell
    }
}
