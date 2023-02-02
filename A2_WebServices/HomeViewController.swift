//
//  ViewController.swift
//  Assignment 2
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var dogsTableView: UITableView!
    
    
    var dogList = [Dogs]()
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        dogsTableView.dataSource = self
        dogsTableView.delegate = self
        
        title = "All Dogs"
        
        fetchDataFromAPI()

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is PreviewViewController {
            if let vc = segue.destination as? PreviewViewController {
                vc.breedName = dogList[selectedIndex].name
            }
        }
    }
    
    
    func fetchDataFromAPI() {
        NetworkClient.shared.request(url: "https://dog.ceo/api/breeds/list/all") { dogs in
            
            DispatchQueue.main.async {
                self.dogList = dogs
                self.dogsTableView.reloadData()
            }
            
            
        } failure: { error in
            print(error)
        }
    }


}


extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dogList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DogsTableViewCell", for: indexPath) as! DogsTableViewCell
        cell.config(dog: dogList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        self.performSegue(withIdentifier: "DetailVC", sender: nil)
    }
}
