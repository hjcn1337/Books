//
//  NetworkDataFetcher.swift
//  Books
//
//  Created by Ростислав Ермаченков on 09.03.2021.
//

import Foundation

protocol DataFetcher {
    func getCovers(response: @escaping (CoversResponse?) -> Void)
}

struct NetworkDataFetcher: DataFetcher {

    let networking: Networking
    
    init(networking: Networking) {
        self.networking = networking
    }
    
    func getCovers(response: @escaping (CoversResponse?) -> Void) {
        
        let params = ["" : ""]
        networking.request(path: API.covers, params: params) { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
            
            let decoded = self.decodeJSON(type: CoversResponse.self, from: data)
            response(decoded)
        }
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from, let response = try? decoder.decode(type.self, from: data) else { return nil }
        return response
    }
}
