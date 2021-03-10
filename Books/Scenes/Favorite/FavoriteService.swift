//
//  FavoriteService.swift
//  Books
//
//  Created by Ростислав Ермаченков on 10.03.2021.
//

import Foundation

class FavoriteService {
    var coreDataManager: CoreDataManaging
    
    init() {
        self.coreDataManager = CoreDataManager()
    }

    
    func getFavorite() -> [FavoriteCover] {
        let covers = coreDataManager.getFavorite()
        return covers
    }
    
    func deleteCoverFromFavorite(cover: FavoriteCover) {
        coreDataManager.deleteCoverFromFavorite(cover: cover)
    }
}
