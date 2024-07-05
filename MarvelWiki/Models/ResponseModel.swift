//
//  ResponseModel.swift
//  MarvelWiki
//
//  Created by João Pedro Borges on 05/07/24.
//

import Foundation

struct MarvelResponse<T: Codable>: Codable {
    let code: Int
    let status: String
    let copyright: String
    let attributionText: String
    let attributionHTML: String
    let etag: String
    let data: MarvelData<T>?
}

struct MarvelData<T: Codable>: Codable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [T]?
}
