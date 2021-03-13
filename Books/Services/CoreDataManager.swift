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
    func deleteCoverFromFavorite(cover: CoversCellViewModel)
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
        coverObject.textID = coverModel.textID
        
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func deleteCoverFromFavorite(cover: CoversCellViewModel) {
        let fetchRequest: NSFetchRequest<FavoriteCover> = FavoriteCover.fetchRequest()
        let predicate = NSPredicate(format: "textID == %@", cover.textID)
        fetchRequest.predicate = predicate
        
        do {
            let coverArray = try context.fetch(fetchRequest)
            guard let coverToDelete = coverArray.first else { return }
            context.delete(coverToDelete)
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
}
