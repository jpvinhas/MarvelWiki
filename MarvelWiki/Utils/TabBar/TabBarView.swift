//
//  TabBarView.swift
//  MarvelWiki
//
//  Created by João Pedro Borges on 02/07/24.
//

import SwiftUI

struct TabBar: Identifiable {
    var id = UUID()
    var iconname: String
    var tab: TabIcon
}

let tabItems = [
    TabBar(iconname: "house", tab: .Home),
    TabBar(iconname: "book.pages", tab: .Comics),
    TabBar(iconname: "person.crop.rectangle.stack", tab: .Characters),
    TabBar(iconname: "heart", tab: .Favorite)
]

enum TabIcon: String {
    case Home
    case Comics
    case Characters
    case Favorite
}

struct TabBarView: View {
    
    @Binding var selectedTab: TabIcon
    
    var body: some View {
        HStack{
            ForEach(tabItems) { item in
                Button(action: {
                    selectedTab = item.tab
                }, label: {
                    Spacer()
                    TabButtom(icon: item.iconname, isSelected: item.tab == selectedTab)
                    Spacer()
                })
            }
        }
        .frame(height: 70)
        .padding(.bottom,25)
        .padding(.top,7)
        .background(Color("tabBlue"))
    }
}
struct TabButtom: View {
    var icon: String
    var isSelected: Bool
    
    var body: some View {
        ZStack {
            if isSelected {
                Circle()
                    .fill(Color("mRed"))
                    .frame(width: 50, height: 50)
            }
            Image(systemName: icon).foregroundColor(.white).font(.system(size: 24,weight: .regular))
        }
    }
}

#Preview {
    Routes()
}
