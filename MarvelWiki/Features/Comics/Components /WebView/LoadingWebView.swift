//
//  LoadingWebView.swift
//  MarvelWiki
//
//  Created by João Pedro Borges on 12/07/24.
//

import SwiftUI

struct LoadingWebView: View {
    let url: URL?
    
    @State var isLoading = true
    @State var error = false
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            HStack{
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "arrow.backward")
                        .font(.system(size: 20).bold())
                        .foregroundColor(Color("mClearGray"))
                }
                Spacer()
                Text("More Details")
                    .font(.custom("Poppins-Bold", size: 24))
                    .foregroundColor(Color.white)
                
                Spacer()
            }
            .padding(.bottom,-8)
            .padding(.horizontal,30)
            if isLoading {
                ProgressView()
            }
            if let url = url {
                ComicWebView(url: url, isLoading: $isLoading,error: $error)
                    .background(Color("mBackground"))
                    .edgesIgnoringSafeArea(.all)
                    .onAppear{
                        isLoading = false
                    }
            }
        }
        .navigationBarBackButtonHidden(true)
        .frame(width: .infinity,height: .infinity)
        .background(Color("mBackground"))
    }
}
