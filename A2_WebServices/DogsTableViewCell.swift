//
//  DogsTableViewCell.swift
//  Assignment 2
//
//

import UIKit

class DogsTableViewCell: UITableViewCell {

    @IBOutlet weak var dogNameLbl: UILabel!
    @IBOutlet weak var dogSubBreedLbl: UILabel!
    @IBOutlet weak var randomDogIV: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(dog: Dogs) {
        dogNameLbl.text = dog.name
        let subBreeds = dog.subBreed
        var subbreedString = ""
        for breed in subBreeds {
            subbreedString += "\(breed),"
        }
        if !subbreedString.isEmpty { subbreedString.removeLast() }
        dogSubBreedLbl.text = subbreedString
        
        NetworkClient.shared.fetchRandomImageUrl(url: "https://dog.ceo/api/breeds/image/random") { urlString in
            DispatchQueue.main.async {
                if let url = URL(string: urlString) {
                    self.randomDogIV.getImage(from: url)
                } else {
                    self.randomDogIV.image = nil
                }
            }
        }
    }

}
