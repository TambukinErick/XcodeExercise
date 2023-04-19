//
//  PokemonDetailsViewController.swift
//  Project1_Lopez
//
//  Created by student on 4/19/23.
//

import UIKit
import PokemonAPI

class PokemonDetailsViewController: UIViewController {
    var pokemonName: String?
    var searchResponse2: SearchResponse2?
    var pokemonSpriteURL: String?
    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pokemoneType: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Label?.text = pokemonName!
        makeAPICall2 { searchResponse2 in
            self.searchResponse2 = searchResponse2
            DispatchQueue.main.async { [self] in
                var example = URL(string: pokemonSpriteURL!)
                    let data = try? Data(contentsOf: example!)
                    imageView?.image = UIImage(data: data!)
                }
            }
        //pokemon types
        // Set label width to 0 when there is nothign there
        // 
        }
        
        func makeAPICall2(completion: @escaping (SearchResponse2?) -> Void) {
            print("start API call")
            let domain = "https://pokeapi.co/api/v2/pokemon/"
            guard let url = URL(string: "\(domain)\(pokemonName!)") else {
                completion(nil)
                return
            }
            print(url)
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                var searchResponse2: SearchResponse2?
                defer {completion(searchResponse2)}
                if let error = error {
                    print("Error with API call: \(error)")
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode)
                else {
                    print("Error with the response (\(String(describing: response))")
                    return
                }
                if let data = data,
                   let response = try? JSONDecoder().decode(SearchResponse2.self, from: data)
                {
                    print("success")
                    self.pokemonSpriteURL = response.Sprites.Front
                } else {
                    print("Something is wrong with decoding, probably.")
                }
            }
            task.resume()
        }
        
    }
    
struct SearchResponse2: Codable {
    let Sprites: Sprites
    let Types: [Type]
    
    enum CodingKeys: String, CodingKey {
        case Sprites = "sprites"
        case Types = "types"
    }
}

struct Sprites: Codable {
    let Front: String
    enum CodingKeys: String, CodingKey{
        case Front = "front_default"
    }
}

struct Type: Codable {
    let name: String
    

}


    

