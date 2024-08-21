import SwiftUI

struct CharactersView: View {
    
    @StateObject private var viewModel = CharactersViewModel.shared
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                MarvelWikiSearchBar(searchText: $viewModel.searchText, isSearching: $viewModel.isSearchingCharacter, search: $viewModel.search)
                    .padding(.bottom)
                if viewModel.isInitLoading {
                    LoadingCharactersView()
                } else if viewModel.isSearchingCharacter {
                    SearchCharacters()
                        .environmentObject(viewModel)
                } else {
                    CharactersList()
                        .environmentObject(viewModel)
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("mBackground"))
        }
    }
}
#Preview {
    CharactersView()
        .environmentObject(CharactersViewModel.shared)
        .background(Color("mBackground"))
}
