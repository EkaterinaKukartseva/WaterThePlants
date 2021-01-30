//
//  PlantsListViewController.swift
//  WaterThePlants
//
//  Created by EKATERINA  KUKARTSEVA on 26.01.2021.
//

import UIKit

class PlantsListViewController: UIViewController {
    
    private let plantCell = "plantCell"
    
    private var plants: [Plant] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    @IBAction func cancel(_ sender: UIStoryboardSegue) {}
    
    private func fetchData() {
        plants = CoreDataManager.shared.fetchPlants()
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension PlantsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        plants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: plantCell, for: indexPath) as! PlantTableViewCell
        let plant = plants[indexPath.row]
        cell.namePlantLabel.text = plant.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = actionWatering(at: indexPath)
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    private func actionWatering(at indexPath: IndexPath) -> UIContextualAction {
        
        let action = UIContextualAction(style: .normal, title: nil) { (action, view, completion) in
            
            completion(true)
        }
        
        action.backgroundColor = UIColor.white
        let trashImage = UIImage(named: "icon-watering_can")
        
        action.image = trashImage
        
        return action
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = actionDelete(at: indexPath)
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    private func actionDelete(at indexPath: IndexPath) -> UIContextualAction {
        let plant = plants[indexPath.row]
        
        let action = UIContextualAction(style: .normal, title: nil) { (action, view, completion) in
            
            CoreDataManager.shared.deletePlant(this: plant)
            
            self.plants.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        
        action.backgroundColor = UIColor.white
        let trashImage = UIImage(systemName: "trash.fill", withConfiguration: UIImage.SymbolConfiguration(weight: .black))?.withTintColor(UIColor(named: "BlackColor")!, renderingMode: .alwaysOriginal)
        
        action.image = trashImage
        
        return action
    }
    
}
