//
//  StarshipDetailTableViewController.swift
//  SWAPIShips
//
//  Created by Heli Bavishi on 11/21/20.
//

import UIKit

class StarshipDetailTableViewController: UITableViewController {

    // MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    
    //MARK: - Properties
    /// Landing Pad
    var starshipToReceive: Starship? {
        didSet {
            guard let starship = starshipToReceive else { return }
            
            for film in starship.films {
                StarshipController.fetchFilm(with: film) { (result) in
                    switch result {
                    case .success(let film):
                        self.films.append(film.title)
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    case .failure(let error):
                        print(error.errorDescription)
                        // Present error to user
                    }
                }
            }
        }
    }
    
    var films: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filmCell", for: indexPath)
        
        let filmToDisplay = films[indexPath.row]
        cell.textLabel?.text = filmToDisplay

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "In Movies"
    }

    // MARK: - Helpers
    func updateViews() {
        guard let starship = starshipToReceive else { return }
        
        nameLabel.text = starship.name
        modelLabel.text = starship.model
        speedLabel.text = starship.speed
        costLabel.text = starship.cost
    }
}//END of class
