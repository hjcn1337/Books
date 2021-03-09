//
//  CoversViewController.swift
//  Books
//
//  Created by Ростислав Ермаченков on 09.03.2021.
//

import Foundation
import UIKit

protocol CoversDisplayLogic: class {
    func displayData(viewModel: Covers.Model.ViewModel.ViewModelData)
}

class CoversViewController: UIViewController, CoversDisplayLogic {
    
    var presenter: CoversPresentationLogic?

    private var coversViewModel = CoversViewModel.init(cells: [])
    private lazy var footerView = FooterView()
    
    let activityView = UIActivityIndicatorView(style: .large)
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupTable()
        navigationItem.title = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String
        
        presenter?.presentData(request: Covers.Model.Response.ResponseType.presentCovers)
        showActivityIndicatory()
    }
    
    func displayData(viewModel: Covers.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .displayCovers(let coversViewModel):
            self.coversViewModel = coversViewModel
            
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yyyy"
            let nowDate = formatter.string(from: date)
            
            footerView.setTitle("Всего - \(coversViewModel.cells.count). Последнее обновление \(nowDate)")
            table.reloadData()
            activityView.stopAnimating()
        }
    }
    
    private func setup() {
        presenter = CoversPresenter(view: self)
    }
    
    private func setupTable() {
        table.register(CoversCell.self, forCellReuseIdentifier: CoversCell.reuseId)
        table.tableFooterView = footerView
    }
    
    private func showActivityIndicatory() {
        activityView.center = self.view.center
        self.view.addSubview(activityView)
        activityView.startAnimating()
    }
    
}

extension CoversViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coversViewModel.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CoversCell.reuseId, for: indexPath) as! CoversCell
        let cellViewModel = coversViewModel.cells[indexPath.row]
        cell.set(viewModel: cellViewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
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
