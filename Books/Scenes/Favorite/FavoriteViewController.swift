//
//  FavoriteViewController.swift
//  Books
//
//  Created by Ростислав Ермаченков on 10.03.2021.
//

import Foundation
import UIKit

class FavoriteViewController: UIViewController {
    
    var favoriteService = FavoriteService()
    
    @IBOutlet weak var table: UITableView!
    
    var covers: [FavoriteCover] = []
    private var coversViewModel = CoversViewModel.init(cells: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        covers = favoriteService.getFavorite()
        table.reloadData()
    }
    
    private func setupTable() {
        table.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseId)
    }
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return covers.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let cover = covers[indexPath.row]
        cell.textLabel?.text = "repo.fullName"

        return cell
    }
    

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let cover = covers[indexPath.row]
            
            covers.remove(at: indexPath.row)
            favoriteService.deleteCoverFromFavorite(cover: cover)
            table.deleteRows(at: [indexPath], with: .automatic)

        }
    }
}

