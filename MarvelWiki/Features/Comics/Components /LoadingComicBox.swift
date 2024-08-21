//
//  LoadingComicView.swift
//  MarvelWiki
//
//  Created by João Pedro Borges on 21/08/24.
//

import SwiftUI

struct LoadingComicBox: View {
    var body: some View {
        VStack{
            ShimmerEffectBox()
                .frame(width: 100, height: 150)
                .cornerRadius(10)
            ShimmerEffectBox()
            .frame(width: 90,height: 15)
        }
    }
}

#Preview {
    LoadingComicBox()
}
