//
//  GroceryListView.swift
//  LookUpRecipes
//
//  Created by Davi Martinelli de Lira on 3/8/24.
//

import SwiftUI

struct GroceryListView: View {
    @StateObject var model: RecipeFinderModel
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color("primaryColor"), .white], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            VStack {
                Text("Grocery List")
                .font(.title2)
                .bold()
                    .padding(.leading, 20)
                Group {
                    List {
                        ForEach($model.ingredientsList, id:\.self) { $line in
                            RowView(item: line)
                                .swipeActions(edge: .trailing) {
                                    ZStack {
                                        Button {
                                            let currentLineIndex = model.ingredientsList.firstIndex(of: line)
                                            if let index = currentLineIndex {
                                                model.ingredientsList.remove(at: index)
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
                }.padding(7)
                    
                
                Button(action: {model.ingredientsList = []}, label: {
                    ButtonViews(text: "Clear", background: Color("primaryColor"), font: .headline)
                })
                .padding(.bottom, 20)
            }
        }
    }
}

#Preview {
    GroceryListView(model: RecipeFinderModel())
}
