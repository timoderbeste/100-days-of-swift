//
//  WebsiteListTableViewController.swift
//  Project4
//
//  Created by Timo Wang on 5/2/21.
//

import UIKit


class WebsiteListTableViewController: UITableViewController {
    var websites: Array<String> = Array<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Available Websites"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.websites = allowedWebsites
        print("self.websites: \(self.websites)")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.websites.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "website_name", for: indexPath)
        cell.textLabel?.text = self.websites[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Row \(indexPath.row) selected")
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "browser") as? BrowsingViewController {
            vc.websites = self.websites
            vc.initialWebsite = self.websites[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

}
