import SwiftUI

struct CharactersView: View {
    @StateObject private var viewModel = CharactersViewModel()
    
    
    var body: some View {
        NavigationView {
            VStack {
                MarvelWikiSearchBar(searchText: $viewModel.searchText, isSearching: $viewModel.isSearchingCharacter, search: $viewModel.search)
                Spacer()
                CharactersList()
                
            }.frame(maxWidth: .infinity)
                .background(Color("mBackground"))
        }
        
    }
}
#Preview {
    CharactersView()
}
