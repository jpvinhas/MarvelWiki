//
//  CarouselImage.swift
//  MarvelWiki
//
//  Created by Pedro Victor Furtado Sousa on 08/07/24.
//

import Foundation
import SwiftUI

class CarouselImage: ObservableObject {

    @Published var data: Data = Data()

    init(imageURL: URL) {
        URLSession.shared.dataTask(with: imageURL) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async { self.data = data }
        }
        .resume()
    }
}

struct URLImage: View {
    @ObservedObject var carouselImage: CarouselImage

    init(_ imageUrl: URL) {
        carouselImage = CarouselImage(imageURL: imageUrl)
    }

    var body: some View {
        Image(uiImage: UIImage(data: carouselImage.data) ?? UIImage())
            .resizable()
            .scaledToFit()
            .frame(width: 100)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .shadow(color: .gray, radius: 3)
            .padding(4)
    }
}
