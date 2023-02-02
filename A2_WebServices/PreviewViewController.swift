//
//  PreviewViewController.swift
//  Assignment 2
//
//

import UIKit

class PreviewViewController: UIViewController {
    
    @IBOutlet weak var breedImageView: UIImageView!
    
    
    var breedName = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Preview"

        NetworkClient.shared.fetchRandomImageUrl(url: "https://dog.ceo/api/breed/\(breedName)/images/random") { url in
            DispatchQueue.main.async {
                self.breedImageView.getImage(from: URL(string: url)!)
            }
        }
    }

    @IBAction func newImageAction(_ sender: Any) {
        
        NetworkClient.shared.fetchRandomImageUrl(url: "https://dog.ceo/api/breeds/image/random") { urlString in
            DispatchQueue.main.async {
                if let url = URL(string: urlString) {
                    self.breedImageView.getImage(from: url)
                } else {
                    self.breedImageView.image = nil
                }
            }
        }
    }
}
