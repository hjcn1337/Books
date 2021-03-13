//
//  CoversModels.swift
//  Books
//
//  Created by Ростислав Ермаченков on 09.03.2021.
//

import Foundation

enum Covers {
   
  enum Model {
    struct Request {
      enum RequestType {
        case getCovers
      }
    }
    struct Response {
      enum ResponseType {
        case presentCovers
      }
    }
    struct ViewModel {
      enum ViewModelData {
        case displayCovers(coversViewModel: CoversViewModel)
      }
    }
  }
}

struct CoversViewModel {
    struct Cell: CoversCellViewModel {
        let title: String
        let imageUrlString: String
        let coverDescription: String
        let author: String
        let textID: String
        var isFavorite: Bool
    }
 
    var cells: [Cell]
}
