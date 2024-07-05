//
//  IndicatorView.swift
//  MarvelWiki
//
//  Created by Pedro Victor Furtado Sousa on 05/07/24.
//

import Foundation
import SwiftUI

struct IndicatorView: View {
    let imageCount: Int
    @Binding var scrollID: Int?
    var body: some View {
        HStack {
            ForEach(1..<imageCount, id: \.self) { indicator in
            let index = scrollID ?? 0
                Button {
                    withAnimation {
                        scrollID = indicator
                    }
                } label: {
                    Image(systemName: "circle.fill")
                        .font(.system(size: 8))
                        .foregroundStyle(indicator == index ? Color.gray : Color(.lightGray))
                }
            }
        }
        .padding(.bottom)
        //.background(RoundedRectangle(cornerRadius: 10).fill(Color(.lightGray)).opacity(0.2))
    }
}
