//
//  CoversService.swift
//  Books
//
//  Created by Ростислав Ермаченков on 09.03.2021.
//

import Foundation

class CoversService {
    var networking: Networking
    var fetcher: DataFetcher
    
    private var coversResponse: CoversResponse?
    
    init() {
        self.networking = NetworkService()
        self.fetcher = NetworkDataFetcher(networking: networking)
    }

    
    func getCovers(completion: @escaping (CoversResponse) -> Void) {
        fetcher.getCovers { [ weak self] (covers) in
            self?.coversResponse = covers
            guard let coversResponse = self?.coversResponse else { return }
            completion(coversResponse)
        }
    }
}
