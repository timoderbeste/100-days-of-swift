//
//  DetailViewController.swift
//  Project1
//
//  Created by Timo Wang on 4/17/21.
//

import UIKit

class ImageDetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    
    var selectedImageName: String?
    var imageIdx: Int?
    var totalNumImages: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        if let imageIdx = self.imageIdx, let totalNumImages =
            self.totalNumImages {
            self.title = "Picture \(imageIdx) of \(totalNumImages)"
        }
        
        self.navigationItem.largeTitleDisplayMode = .never
        
        self.navigationItem.rightBarButtonItem =
            UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))

        if let selectedImage = self.selectedImageName {
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
    
    @objc func shareTapped() {
        guard let image = self.imageView.image?.jpegData(compressionQuality: 0.8)
        else {
            print("No image found")
            return
        }
        
        let vc = UIActivityViewController(activityItems: [image, self.selectedImageName!],
                                          applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
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
