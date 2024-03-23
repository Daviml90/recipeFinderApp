//
//  ResultsView.swift
//  LookUpRecipes
//
//  Created by Davi Martinelli de Lira on 3/3/24.
//

import SwiftUI

struct ResultsView: View {
    @StateObject var model: RecipeData
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        if model.notFound {
            Text("No recipes found, please redifine the search.")
        } else {
            ZStack {
                LinearGradient(colors: [Color("primaryColor"), .white], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                VStack {
                    VStack(alignment: .leading) {
                        Text("Searching:")
                            .font(.title2)
                            .padding(.top,10)
                        ScrollView(.horizontal) {
                            HStack{
                                ForEach(model.searchText.sorted(), id:\.self) { item in
                                    Text(item)
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                        .padding(.horizontal,5)
                                        .background(RoundedRectangle(cornerRadius: 25.0)
                                            .fill(Color("secondaryColor")))
                                }
                            }
                        }
                        Text("Results:")
                            .font(.title2)
                            .padding(.top,10)
                    } .padding(.horizontal, 20)
                    VStack {
                        List {
                            ForEach(model.receitas, id: \.label) { receita in
                                NavigationLink(receita.label, destination: DetailedView(recipe: receita, model: model))
                            }
                        }
                        .listStyle(.plain)
                    }.padding(7)
                    .background(RoundedRectangle(cornerRadius: 25).fill(.white))
                        .padding()
                    .onAppear(perform: {
                        model.getMenuData()
                    })
                    .navigationBarBackButtonHidden(true)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            
                            Button {
                                dismiss()
                            } label: {
                                Image(systemName: "arrowshape.backward.circle.fill")
                                    .font(.title)
                                    .foregroundStyle(.white)
                                    .background(Circle().fill(Color("primaryColor")))
                            }
                        }
                        
                    }
                }
            }
            
            }
    }
}

//#Preview {
//    ResultsView(model: RecipeData())
//}
