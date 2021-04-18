//
//  ViewController.swift
//  Project1
//
//  Created by Timo Wang on 4/17/21.
//

import UIKit

class ViewController: UITableViewController {
    var pictures: Array<String> = Array<String>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Storm Viewer"
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                self.pictures.append(item)
                print(item)
            }
        }
        
        self.pictures.sort()
        
        print(self.pictures)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "picture_name", for: indexPath)
        cell.textLabel?.text = self.pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "image_detail") as? ImageDetailViewController {
            
            vc.selectedImage = pictures[indexPath.row]
            vc.imageIdx = indexPath.row + 1
            vc.totalNumImages = self.pictures.count
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}

