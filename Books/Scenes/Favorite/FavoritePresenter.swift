//
//  FavoritePresenter.swift
//  Books
//
//  Created by Ростислав Ермаченков on 13.03.2021.
//

import Foundation


protocol FavoritePresentationLogic {
    func presentData(request: Favorite.Model.Response.ResponseType)
}

class FavoritePresenter: FavoritePresentationLogic {
    
    var service: FavoriteService?
    unowned let view: FavoriteDisplayLogic
    
    init(view: FavoriteDisplayLogic) {
        self.view = view
    }
    
    func presentData(request: Favorite.Model.Response.ResponseType) {
        if service == nil {
            service = FavoriteService()
    }
      
    switch request {
        case .presentFavorite:
            
            var coversViewModel = CoversViewModel.init(cells: [])
            
            let _ = service?.getFavorite().map { (favoriteItem) in
                
                guard let coverTitle = favoriteItem.title,
                      let imageUrlString = favoriteItem.imageUrlString,
                      let coverDesc = favoriteItem.desc,
                      let coverAuthor = favoriteItem.author,
                      let textID = favoriteItem.textID
                      
                      else { return }

                coversViewModel.cells.append(CoversViewModel.Cell.init(title: coverTitle, imageUrlString: imageUrlString, coverDescription: coverDesc, author: coverAuthor, textID: textID, isFavorite: true))
            }
        
            self.view.displayData(viewModel: Favorite.Model.ViewModel.ViewModelData.displayFavorite(coversViewModel: coversViewModel))
        }
        
    }

}
