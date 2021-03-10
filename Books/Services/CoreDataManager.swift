//
//  CoreDataManager.swift
//  Books
//
//  Created by Ростислав Ермаченков on 10.03.2021.
//

import Foundation
import CoreData
import UIKit

protocol CoreDataManaging {
    func addCoverToFavorite(coverModel: CoversCellViewModel)
    func getFavorite() -> [FavoriteCover]
    func deleteCoverFromFavorite(cover: FavoriteCover)
}

struct CoreDataManager: CoreDataManaging {

    var context = (UIApplication.shared.delegate as! AppDelegate).coreDataStack.persistentContainer.viewContext
    
    func getFavorite() -> [FavoriteCover] {
        let fetchRequest: NSFetchRequest<FavoriteCover> = FavoriteCover.fetchRequest()
        
        do {
            let covers = try context.fetch(fetchRequest)
            return covers
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        return []
    }
    
    func addCoverToFavorite(coverModel: CoversCellViewModel) {
        guard let entity = NSEntityDescription.entity(forEntityName: "FavoriteCover", in: context) else { return }
        let coverObject = FavoriteCover(entity: entity, insertInto: context)
        coverObject.author = coverModel.author
        coverObject.imageUrlString = coverModel.imageUrlString
        coverObject.desc = coverModel.coverDescription
        coverObject.title = coverModel.title
        
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func deleteCoverFromFavorite(cover: FavoriteCover) {
        context.delete(cover)
        
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
}
