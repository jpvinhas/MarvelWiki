//
//  ContentView.swift
//  MarvelWiki
//
//  Created by Pedro Victor Furtado Sousa on 28/06/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world 5!")
                .font(.custom("BentonSans Comp Black", size: 30))
        }
        .padding()
    }
}


#Preview {
    ContentView()
}
