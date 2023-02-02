//
//  NetworkClient.swift
//
//

import Foundation

class NetworkClient {
    
    static let shared = NetworkClient()
    
    private init() {}
    
    func request(url: String, completion: @escaping ([Dogs]) -> Void, failure: @escaping (String) -> Void) {
        let urlString = url.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
        let request = NSMutableURLRequest(url: NSURL(string: urlString!)! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "GET"
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        session.dataTask(with: request as URLRequest) { data, response, error in
            if let data = data {
                
                do {
                    let dict = try? JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
                    let list = dict!["message"] as! NSDictionary
                    let allDogNames = list.allKeys as! [String]
                    
                    var dogList = [Dogs]()
                    
                    for name in allDogNames {
                        let dog = Dogs()
                        dog.name = name
                        dog.subBreed = list[name] as! [String]
                        dogList.append(dog)
                    }
                    
                    completion(dogList)
                }
                
            } else if let error = error {
                failure(error.localizedDescription)
                print("HTTP Request Failed \(error)")
                
            }
        }.resume()
    }
    
    func fetchRandomImageUrl(url: String, completion: @escaping (String) -> Void) {
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "GET"
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        session.dataTask(with: request as URLRequest) { data, response, error in
            if let data = data {
                
                do {
                    let dict = try? JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
                    
                    completion(dict!["message"] as! String)
                }
                
            } else if let error = error {
                print("HTTP Request Failed \(error)")
                
            }
        }.resume()
    }
}
