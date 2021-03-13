//
//  CoversService.swift
//  Books
//
//  Created by Ростислав Ермаченков on 09.03.2021.
//

import Foundation

class CoversService {
    private var networking: Networking
    private var fetcher: DataFetcher
    private var coreDataManager: CoreDataManaging
    
    private var coversResponse: CoversResponse?
    
    init() {
        self.networking = NetworkService()
        self.fetcher = NetworkDataFetcher(networking: networking)
        self.coreDataManager = CoreDataManager()
    }

    
    func getCovers(completion: @escaping (CoversResponse) -> Void) {
        
        fetcher.getCovers { [ weak self] (covers) in
            self?.coversResponse = covers
            guard let coversResponse = self?.coversResponse else { return }
            completion(coversResponse)
        }
    }
    
    func getFavorite() -> [FavoriteCover] {
        return coreDataManager.getFavorite()
    }
    
    func favoriteAction(cover: CoversCellViewModel) {
        if cover.isFavorite {
            coreDataManager.deleteCoverFromFavorite(cover: cover)
        } else {
            coreDataManager.addCoverToFavorite(coverModel: cover)
        }
    }
    
    
}
