//
//  StarshipListTableViewController.swift
//  SWAPIShips
//
//  Created by Heli Bavishi on 11/21/20.
//

import UIKit

class StarshipListTableViewController: UITableViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var starshipSearchBar: UISearchBar!
    
    // MARK: - Properties
    /// Source of Truth
    var starships: [Starship] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        starshipSearchBar.delegate = self
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return starships.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "starshipCell", for: indexPath)
        
        let starshipToDisplay = starships[indexPath.row]
        cell.textLabel?.text = starshipToDisplay.name
        
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // IIDOO
        // I: Identifier
        if segue.identifier == "toStarshipDetailVC" {
            // I: Index
            // D : Destination
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destinationVC = segue.destination as? StarshipDetailTableViewController else { return }
            // O : Object to send
            let starshipToSend = starships[indexPath.row]
            // O : Object to receive
            destinationVC.starshipToReceive = starshipToSend
        }
    }
}//END of class

extension StarshipListTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        StarshipController.fetchStarships(with: searchText) { (result) in
            switch result {
            
            case .success(let starships):
                self.starships = starships
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                // Present user the error
                print(error.localizedDescription)
            }
        }
    }
}
