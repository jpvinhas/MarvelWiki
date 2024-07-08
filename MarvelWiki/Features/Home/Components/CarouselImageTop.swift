//
//  CarouselImageTop.swift
//  MarvelWiki
//
//  Created by Pedro Victor Furtado Sousa on 08/07/24.
//

import Foundation
import SwiftUI

class CarouselImageTop: ObservableObject {

    @Published var data: Data = Data()

    init(imageURL: URL) {
        URLSession.shared.dataTask(with: imageURL) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async { self.data = data }
        }
        .resume()
    }
}

struct URLImageTop: View {
    @ObservedObject var carouselImage: CarouselImage

    init(_ imageUrl: URL) {
        carouselImage = CarouselImage(imageURL: imageUrl)
    }

    var body: some View {
        Image(uiImage: UIImage(data: carouselImage.data) ?? UIImage())
            .resizable()
            .scaledToFit()
            .frame(maxWidth: 340)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: .gray, radius: 10)
            .padding(4)
    }
}

