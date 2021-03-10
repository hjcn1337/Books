//
//  FavoriteCell.swift
//  Books
//
//  Created by Ростислав Ермаченков on 10.03.2021.
//

import Foundation
import UIKit

//protocol CoversCellViewModel {
//    var title: String { get }
//    var imageUrlString: String { get }
//    var coverDescription: String { get }
//    var author: String { get }
//}

class FavoriteCell: UITableViewCell {
    
    static let reuseId = "FavoriteCell"
    
    let cellView: UIView = {
       let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()

    let coverImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = #colorLiteral(red: 0.8234507442, green: 0.3115251064, blue: 0.3296223879, alpha: 1)
        return imageView
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        selectionStyle = .none
        
        overlayFirstLayer()
        overlayCardView()
    }
    
    private func overlayCardView() {
        cellView.addSubview(coverImageView)
        cellView.addSubview(titleLabel)
        
        titleLabel.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: 10).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: coverImageView.centerYAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        titleLabel.numberOfLines = 0
        
        coverImageView.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 10).isActive = true
        coverImageView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 10).isActive = true
        coverImageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        coverImageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        
    }
    
    override func prepareForReuse() {
        coverImageView.set(imageURL: nil)
    }
    
     private func overlayFirstLayer() {
        if #available(iOS 14.0, *) {
            contentView.addSubview(cellView)
        } else {
            addSubview(cellView)
        }
    
        cellView.fillSuperview(padding: Constants.cellInsets)
    }
    
    func set(viewModel: CoversCellViewModel) {
        
        coverImageView.set(imageURL: viewModel.imageUrlString)
        titleLabel.text = viewModel.title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
