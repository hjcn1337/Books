//
//  CoversPresenter.swift
//  Books
//
//  Created by Ростислав Ермаченков on 09.03.2021.
//

import Foundation

protocol CoversPresentationLogic {
    func presentData(request: Covers.Model.Response.ResponseType)
}

class CoversPresenter: CoversPresentationLogic {
    
    var service: CoversService?
    unowned let view: CoversDisplayLogic
    
    init(view: CoversDisplayLogic) {
        self.view = view
    }
    
    func presentData(request: Covers.Model.Response.ResponseType) {
        if service == nil {
            service = CoversService()
      }
      
      switch request {
      case .presentCovers:
        service?.getCovers { [weak self] coversInfo in
            let cells = coversInfo.map { (coversItem) in
                return CoversViewModel.Cell.init(title: coversItem.title, imageUrlString: coversItem.image, coverDescription: coversItem.coversResponseDescription, author: coversItem.author)
            }
            
            let coversViewModel = CoversViewModel.init(cells: cells)
            
            self?.view.displayData(viewModel: Covers.Model.ViewModel.ViewModelData.displayCovers(coversViewModel: coversViewModel))
          }
      }
    }
    
}
