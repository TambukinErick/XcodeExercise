//
//  TableViewController.swift
//  Project1_Lopez
//
//  Created by student on 4/14/23.
//

import UIKit
import PokemonAPI

class TableViewController: UITableViewController {

    var searchResponse: SearchResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(NSLocalizedString("tableview_title", comment: ""))
        makeAPICall { searchResponse in
            self.searchResponse = searchResponse
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = (searchResponse?.Search[indexPath.row].name)?.capitalized
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return 151
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            guard let pokemonName = searchResponse?.Search[indexPath.row].name else {return}
            goToPokemonDetailsViewController(pokemonName)
        }
    func goToPokemonDetailsViewController(_ pokemonName: String?) {
        let storyboard = UIStoryboard(name: "PokemonDetailsViewController", bundle: nil)
        guard let pokemonDetailsViewController = storyboard.instantiateViewController(withIdentifier: "Pokedex") as? PokemonDetailsViewController else { return }
        pokemonDetailsViewController.pokemonName = pokemonName
        navigationController?.pushViewController(pokemonDetailsViewController, animated: true)
    }

    func makeAPICall(completion: @escaping (SearchResponse?) -> Void) {
        print("start API call")
        let domain = "https://pokeapi.co/api/v2/pokemon?limit="
        let limitSearchQuery = "151"
        guard let url = URL(string: "\(domain)\(limitSearchQuery)") else {
            completion(nil)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            var searchResponse: SearchResponse?
            defer {completion(searchResponse)}
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
               let response = try? JSONDecoder().decode(SearchResponse.self, from: data)
            {
                print("success")
                searchResponse = response
            } else {
                print("Something is wrong with decoding, probably.")
            }
        }
        task.resume()
    }
}

struct SearchResponse: Codable {
    let count: Int
    let Search: [Pokemon]

    enum CodingKeys: String, CodingKey {
        case count
        case Search = "results"
    }
}

struct Pokemon: Codable {
    var name: String
    var url: String
}

