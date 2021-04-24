//
//  DetailViewController.swift
//  Project1
//
//  Created by Timo Wang on 4/17/21.
//

import UIKit

class ImageDetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    
    var selectedImage: String?
    var imageIdx: Int?
    var totalNumImages: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        if let imageIdx = self.imageIdx, let totalNumImages = self.totalNumImages {
            self.title = "Picture \(imageIdx) of \(totalNumImages)"
        }
        
        self.navigationItem.largeTitleDisplayMode = .never

        if let selectedImage = self.selectedImage {
            self.imageView.image = UIImage(named: selectedImage)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.hidesBarsOnTap = false
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
