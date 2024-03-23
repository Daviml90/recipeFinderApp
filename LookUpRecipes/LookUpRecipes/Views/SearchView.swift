//
//  SearchView.swift
//  LookUpRecipes
//
//  Created by Davi Martinelli de Lira on 3/3/24.
//

import SwiftUI

struct SearchView: View {
    @StateObject var model: RecipeFinderModel
    @State var searchBar: String = ""
    @State var applied: Bool = false
    @FocusState var barInFocus: Bool
    @State var otherSheet: Bool = false
    @State var screenNumber = 0
    @State var pickedRecipe: Recipe?
    @State var restictrionsPopover: Bool = false
    @State var listAdded: Bool = false
    var favorite: Bool {
        if model.favoriteRecipes.contains(where: {$0.label == pickedRecipe!.label}) {
           return true
        } else {
           return false
        }
    }
    
    
    var body: some View {
        ZStack {
            BackgroundView()
            if screenNumber == 0 {
                mainSearchView
            } else if screenNumber == 1 {
                resultsView
            } else {
                detailedView
            }
        }
    }
}


#Preview {
    SearchView(model: RecipeFinderModel())
}
