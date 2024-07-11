import SwiftUI

struct CharactersView: View {
    
    @StateObject private var viewModel = CharactersViewModel ()
    
   var body: some View {
        NavigationView {
            VStack {
                MarvelWikiSearchBar(searchText: $viewModel.searchText, isSearching: $viewModel.isSearchingCharacter, search: $viewModel.search)
                Spacer()
                if viewModel.isSearchingCharacter  {
                    SearchCharacters()
                        .environmentObject(viewModel)
                }else{
                    CharactersList()
                        .environmentObject(viewModel)
                }
            }.frame(maxWidth: .infinity)
                .background(Color("mBackground"))
        }
        
    }
}
#Preview {
    CharactersView()
        .environmentObject(CharactersViewModel())
        .background(Color("mBackground"))
}
