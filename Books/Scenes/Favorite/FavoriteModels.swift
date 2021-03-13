//
//  FavoriteModels.swift
//  Books
//
//  Created by Ростислав Ермаченков on 13.03.2021.
//

import Foundation

enum Favorite {
   
  enum Model {
    struct Request {
      enum RequestType {
        case getFavorite
      }
    }
    struct Response {
      enum ResponseType {
        case presentFavorite
      }
    }
    struct ViewModel {
      enum ViewModelData {
        case displayFavorite(coversViewModel: CoversViewModel)
      }
    }
  }
}
