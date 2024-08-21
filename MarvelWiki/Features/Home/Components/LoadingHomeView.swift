//
//  LoadingHomeView.swift
//  MarvelWiki
//
//  Created by João Pedro Borges on 21/08/24.
//

import SwiftUI

struct LoadingHomeView: View {
    var body: some View {
        VStack(alignment: .leading){
            ShimmerEffectBox()
                .frame(width: 80,height: 28)
                .padding(.leading,20)
            ShimmerEffectBox()
                .frame(width: 350,height: 200)
                .cornerRadius(15)
                .padding()
            ShimmerEffectBox()
                .frame(width: 80,height: 28)
                .padding()
                .padding(.leading,5)
            HStack{
                ShimmerEffectBox()
                    .frame(width: 100,height: 150)
                    .cornerRadius(20)
                    .padding(.horizontal,5)
                ShimmerEffectBox()
                    .frame(width: 100,height: 150)
                    .cornerRadius(20)
                    .padding(.horizontal,5)
                ShimmerEffectBox()
                    .frame(width: 100,height: 150)
                    .cornerRadius(20)
                    .padding(.horizontal,5)
            }.padding(.leading,20)
            ShimmerEffectBox()
                .frame(width: 80,height: 28)
                .padding()
                .padding(.leading,5)
            HStack{
                ShimmerEffectBox()
                    .frame(width: 100,height: 130)
                    .cornerRadius(20)
                    .padding(.horizontal,5)
                ShimmerEffectBox()
                    .frame(width: 100,height: 130)
                    .cornerRadius(20)
                    .padding(.horizontal,5)
                ShimmerEffectBox()
                    .frame(width: 100,height: 130)
                    .cornerRadius(20)
                    .padding(.horizontal,5)
            }.padding(.leading,20)
        }
    }
}

#Preview {
    LoadingHomeView()
}

