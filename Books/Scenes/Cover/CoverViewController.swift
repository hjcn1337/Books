//
//  CoverViewController.swift
//  Books
//
//  Created by Ростислав Ермаченков on 09.03.2021.
//

import Foundation
import UIKit

class CoverViewController: UIViewController {
    
    @IBOutlet weak var coverImageView: WebImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var coverTitle = ""
    var coverAuthor = ""
    var coverDescription = ""
    var coverImageUrlString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = coverTitle
        coverImageView.set(imageURL: coverImageUrlString)
        authorLabel.text = coverAuthor
        descriptionLabel.text = coverDescription
    }
    
}
