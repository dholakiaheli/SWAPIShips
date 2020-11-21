//
//  StarshipDetailTableViewController.swift
//  SWAPIShips
//
//  Created by Austin Goetz on 11/20/20.
//

import UIKit

class StarshipDetailTableViewController: UITableViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    
    // MARK: - Properties
    var starshipToReceive: Starship? {
        didSet {
            self.loadViewIfNeeded()
            guard let starship = starshipToReceive else { return }
            for film in starship.films {
                StarshipController.fetchFilms(with: film) { (result) in
                    switch result {
                    case .success(let film):
                        self.films.append(film.title)
                    case .failure(let error):
                        print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                        // Present error to user
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    var films: [String] = []

    // MARK: - Lifecycle Methods
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
        speedLabel.text = starship.topSpeed
        costLabel.text = starship.cost
    }
}
