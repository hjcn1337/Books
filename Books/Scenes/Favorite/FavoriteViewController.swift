//
//  FavoriteViewController.swift
//  Books
//
//  Created by Ростислав Ермаченков on 10.03.2021.
//

import Foundation
import UIKit

protocol FavoriteDisplayLogic: class {
    func displayData(viewModel: Favorite.Model.ViewModel.ViewModelData)
}

class FavoriteViewController: UIViewController, FavoriteDisplayLogic {
    
    var presenter: FavoritePresentationLogic?
    
    @IBOutlet weak var table: UITableView!
    
    private var coversViewModel = CoversViewModel.init(cells: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupTable()
        navigationItem.title = "Избранное"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.presentData(request: Favorite.Model.Response.ResponseType.presentFavorite)
    }
    
    private func setup() {
        presenter = FavoritePresenter(view: self)
    }
    
    private func setupTable() {
        table.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseId)
    }
    
    func displayData(viewModel: Favorite.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .displayFavorite(let coversViewModel):
            self.coversViewModel = coversViewModel
            table.reloadData()
        }
    }
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coversViewModel.cells.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseId, for: indexPath) as! FavoriteCell
        let cellViewModel = coversViewModel.cells[indexPath.row]
        cell.set(viewModel: cellViewModel)

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cellViewModel = coversViewModel.cells[indexPath.row]
        
        let storyboard = UIStoryboard(name: "CoverScene", bundle: nil)
        guard let coverViewController = storyboard.instantiateViewController(identifier: "CoverViewController") as? CoverViewController else { return }
        
        coverViewController.coverAuthor = cellViewModel.author
        coverViewController.coverDescription = cellViewModel.coverDescription
        coverViewController.coverImageUrlString = cellViewModel.imageUrlString
        coverViewController.coverTitle = cellViewModel.title
        
        navigationController?.pushViewController(coverViewController, animated: true)
    }
}

