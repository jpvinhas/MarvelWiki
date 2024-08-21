//
//  FavoritesViewModel.swift
//  MarvelWiki
//
//  Created by João Pedro Borges on 21/08/24.
//

import Foundation
import CoreData
import SwiftUI

@Observable
class FavoritesViewModel {
    
    static let shared = FavoritesViewModel()
    
    var favoriteComics: [Comic] = []
    
    private let viewContext = PersistenceController.shared.persistentContainer.viewContext
    
    private init() {
        loadFavorites()
    }
    
    func saveComic(_ comic: Comic) {
        _ = ComicEntity.from(comic, context: viewContext)
        
        do {
            try viewContext.save()
            favoriteComics.append(comic)
        } catch {
            print("Erro ao salvar o quadrinho: \(error.localizedDescription)")
        }
    }
    
    func deleteComic(_ comic: Comic) {
        let fetchRequest: NSFetchRequest<ComicEntity> = ComicEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", comic.id)
        
        do {
            let results = try viewContext.fetch(fetchRequest)
            if let comicEntity = results.first {
                viewContext.delete(comicEntity)
                try viewContext.save()
                if let index = favoriteComics.firstIndex(of: comic) {
                    favoriteComics.remove(at: index)
                }
            }
        } catch {
            print("Erro ao deletar o quadrinho: \(error.localizedDescription)")
        }
    }
    
    private func loadFavorites() {
        let fetchRequest: NSFetchRequest<ComicEntity> = ComicEntity.fetchRequest()
        
        do {
            let results = try viewContext.fetch(fetchRequest)
            favoriteComics = results.map { comicEntity in
                Comic(
                    id: Int(comicEntity.id),
                    title: comicEntity.title,
                    description: comicEntity.descriptionText ,
                    modified: comicEntity.modified,
                    pageCount: Int(comicEntity.pageCount),
                    resourceURI: comicEntity.resourceURI,
                    urls: [],
                    thumbnail: Comic.Thumbnail(path: comicEntity.thumbnailPath ?? ""),
                    creators: Comic.Creators(available: 0, collectionURI: "", items: [], returned: 0), // Adapte se necessário
                    characters: Comic.Characters(available: 0, collectionURI: "", items: [], returned: 0) // Adapte se necessário
                )
            }
        } catch {
            print("Erro ao carregar quadrinhos favoritos: \(error.localizedDescription)")
        }
    }
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
}
