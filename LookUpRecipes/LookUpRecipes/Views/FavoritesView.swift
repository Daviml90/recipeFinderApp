//
//  Favorites.swift
//  LookUpRecipes
//
//  Created by Davi Martinelli de Lira on 3/9/24.
//

import SwiftUI

struct FavoritesView: View {
    @StateObject var model: RecipeFinderModel
    
    var body: some View {
        
        ZStack {
            BackgroundView()
            VStack {
                Text("Favorites")
                .font(.title2)
                .bold()
                    .padding(.leading, 20)
                
                    List {
                        ForEach($model.favoriteRecipes, id:\.label) { $recipe in
                            NavigationLink(recipe.label, destination: DetailedView(recipe: recipe, model: model))
                                .swipeActions(edge: .trailing) {
                                    ZStack {
                                        Button {
                                            let currentRecipeIndex = model.favoriteRecipes.firstIndex(where: {$0.label == recipe.label})
                                            if let index = currentRecipeIndex {
                                                model.favoriteRecipes.remove(at: index)
                                            }
                                           
                                        } label: {
                                            Image(systemName: "trash")
                                        }
                                        .tint(Color("secondaryColor"))
                                    }
                                    }
                        }
                        
                    }.listStyle(.plain)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                        .padding(7)
            }
            
        }
            
        }
}

#Preview {
    FavoritesView(model: RecipeFinderModel())
}
