//
//  ContentView.swift
//  LookUpRecipes
//
//  Created by Davi Martinelli de Lira on 2/27/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var model = RecipeFinderModel()
    @State var selectedTab = 0
    @State var searchScreen = 0
    
    var body: some View {
        NavigationStack {
            TabView(selection: $selectedTab) {
                    SearchView(model: model)
                    .tabItem {
                        Image(systemName: "magnifyingglass.circle")
                        Text("Search")
                    }
                    .tag(0)
                GroceryListView(model: model)
                    .tabItem { Image(systemName: "list.clipboard")
                        Text("Grocery List")
                    }
                    .tag(1)
                FavoritesView(model: model)
                    .tabItem { Image(systemName: "heart.fill")
                        Text("Favorites")
                    }
                    .tag(2)
            }
            .toolbar {
                        ToolbarItem(placement: .principal) {
                            HStack {
                                Text("Recipe").font(.headline)
                                    .underline()
                                Image( "recipeLogo")
                                    .resizable()
                                    .scaledToFit()
                                Text("Finder").font(.headline)
                                    .underline()
                            }
                            .padding(0)
                        }
                    }
        }
        
    }
    
    
}

#Preview {
    ContentView()
}
