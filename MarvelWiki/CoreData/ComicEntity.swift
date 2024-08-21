//
//  ComicEntity.swift
//  MarvelWiki
//
//  Created by João Pedro Borges on 21/08/24.
//

import CoreData

extension ComicEntity {
    static func from(_ comic: Comic, context: NSManagedObjectContext) -> ComicEntity {
        let comicEntity = ComicEntity(context: context)
        comicEntity.id = Int64(comic.id)
        comicEntity.title = comic.title
        comicEntity.descriptionText = comic.description
        comicEntity.modified = comic.modified
        comicEntity.pageCount = Int64(comic.pageCount ?? 0)
        comicEntity.resourceURI = comic.resourceURI
        comicEntity.thumbnailPath = comic.thumbnail.path
        return comicEntity
    }
}

