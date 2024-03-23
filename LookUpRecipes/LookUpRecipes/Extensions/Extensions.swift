//
//  Extensions.swift
//  LookUpRecipes
//
//  Created by Davi Martinelli de Lira on 3/2/24.
//

import Foundation
import SwiftUI

extension Color {
    init(hex: String) {
        var cleanHexCode = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        cleanHexCode = cleanHexCode.replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0
        
        Scanner(string: cleanHexCode).scanHexInt64(&rgb)
        
        let redValue = Double((rgb >> 16) & 0xFF) / 255.0
        let greenValue = Double((rgb >> 8) & 0xFF) / 255.0
        let blueValue = Double(rgb & 0xFF) / 255.0
        self.init(red: redValue, green: greenValue, blue: blueValue)
    }
}

extension SearchView {
    
    // Views
    var mainSearchView: some View {
        VStack(alignment: .leading) {
                searchTitle(title: "Meat")
                ScrollView(.horizontal) {
                    HStack{
                        ForEach(0..<model.meats.count) { index in
                            MeatIcon(model: model, index: index)
                        }
                    }
                }
                .frame(height: 100)
            thinLine
            
            searchTitle(title: "Vegetables")
                ScrollView(.horizontal) {
                    HStack{
                        HStack{
                            ForEach(0..<model.vegetables.count) { index in
                                VegetableIcon(model: model, index: index)
                            }
                        }
                    }
                }
                .frame(height: 100)
            thinLine
            searchTitle(title: "Restrictions")
                ScrollView(.horizontal) {
                    HStack{
                        HStack{
                            ForEach(0..<model.restrictions.count) { index in
                                RestrictionIcon(model: model, index: index)
                            }
                        }
                    }
                }.frame(height: 100)
            thinLine
            Group {
                Button(action: {otherSheet = true}, label: {
                    ButtonViews(text: "Refine Search", background: Color("primaryColor"), font: .headline)
                })
                .padding(.vertical,10)
                if model.searchText.count < 1 && model.appliedTexts.count < 1 {
                    Text("Please define your search.")
                        .padding(.bottom,20)
                } else {
                    VStack {
                        Button {
                            screenNumber = 1
                        } label: {
                            ButtonViews(text: "GO", background: Color("secondaryColor"), font: .title)
                        }
                        .simultaneousGesture(TapGesture().onEnded {
                            if model.appliedTexts.count > 0 {
                                for item in model.appliedTexts {
                                    model.searchText.insert(item)
                                }
                            }
                        })
                        Button(action: {model.clearSearch()}, label: {
                            Text("Clear Search")
                                .foregroundStyle(Color("primaryColor"))
                        })
                    }
                    .padding(.bottom,20)
                }
            }.padding(.horizontal,15)
                .frame(maxWidth: .infinity)
            
                Spacer()
                }
        .onAppear() {
            model.clearSearch()
    }
        .sheet(isPresented: $otherSheet, content: {
            otherView
                .presentationDetents([.medium])
        })
    }
    
    var detailedView: some View {
                
        
        ScrollView {
            ZStack {
                Color(.white)
            VStack{
                
                ZStack(alignment: .topTrailing) {
                    AsyncImage(url: URL(string: pickedRecipe!.image), content: { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: 400, maxHeight: 400)
                    },
                               placeholder: {
                        ProgressView()
                    }
                    )
                    .mask(
                        LinearGradient(gradient: Gradient(colors: [Color.black, Color.black.opacity(0)]), startPoint: .center, endPoint: .bottom)
                    )
                    Button {
                        addRemoveFavorite()
                    } label: {
                        Image(systemName: "heart.circle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                            .background(Circle().fill(favorite ? Color("primaryColor") : .gray))
                    }
                    .padding()
                }
                
                
                Text(pickedRecipe!.label)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding()
                
                HStack {
                    HealthLabels(recipe: pickedRecipe!)
                    Spacer()
                    Image(systemName: "info.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 20)
                        .foregroundStyle(Color("primaryColor"))
                        .onTapGesture {
                            restictrionsPopover = true
                        }
                        .popover(isPresented: $restictrionsPopover,  content: {
                            RestrictionsList()
                                .frame(maxHeight: 200)
                                .presentationCompactAdaptation(.popover)
                        })
                }.padding(.horizontal,15)
                
                VStack(alignment: .leading){
                    HStack {
                        Text("Ingredients")
                            .font(.headline)
                            .padding(.vertical,10)
                        Spacer()
                        Button(listAdded ? "Added ✅" : "Add to List") {
                            for item in pickedRecipe!.ingredientLines {
                                model.ingredientsList.append(item)
                            }
                            listAdded = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                listAdded = false
                            }
                        }
                    }
                    ForEach(pickedRecipe!.ingredientLines, id:\.self) { line in
                        Text("- \(line)")
                    }
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 15)
                .padding(.vertical,20)
                
                
                let privacyPolicyText = "[Go to Recipe's website](\(pickedRecipe!.url))"
                
                Text(.init(privacyPolicyText))
                Spacer()
                
            }
        }
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                
                                Button {
                                    screenNumber = 1
                                } label: {
                                    Image(systemName: "arrowshape.backward.circle.fill")
                                        .font(.title)
                                        .foregroundStyle(.white)
                                        .background(Circle().fill(Color("primaryColor")))
                                }
                                
                            }
                            ToolbarItem(placement: .navigationBarTrailing) {
                                
                                Button {
                                    
                                } label: {
                                    Image(systemName: "arrowshape.backward.circle.fill")
                                        .font(.title)
                                        .foregroundColor(Color(.black.opacity(0)))
                                }
                            }

                    
                    }
        }.padding(1)
            
        
    }
    
    var resultsView: some View {
    
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
                            ForEach(model.recipes, id: \.label) { receita in
                                Text(receita.label)
                                    .onTapGesture {
                                        pickedRecipe = receita
                                        screenNumber = 2
                                    }
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
                        ToolbarItem(placement: .navigationBarTrailing) {
                            
                            Button {
                                
                            } label: {
                                Image(systemName: "arrowshape.backward.circle.fill")
                                    .font(.title)
                                    .foregroundColor(Color(.black.opacity(0)))
                            }
                        }
                        ToolbarItem(placement: .navigationBarLeading) {
                            
                            Button {
                                screenNumber = 0
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
    
    var otherView: some View {
        ZStack {
            LinearGradient(colors: [.white, Color("primaryColor")], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                HStack {
                    TextField("type a keyword...", text: $searchBar)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 25.0)
                            .fill(.white)
                            .shadow(radius: 5))
                        .padding(.horizontal)
                        .focused($barInFocus)
                    

                    Button(action: {
                        model.appliedTexts.append(searchBar)
                        applied.toggle()
                        searchBar = ""
                        barInFocus = false
                    }, label: {
                            ButtonViews(text: "Apply", background: Color("primaryColor"), font: .headline)
                    })
                } .padding(20)
                List {
                    ForEach($model.appliedTexts, id:\.self, editActions: .delete) { $text in
                        Text(text)
                            .font(.headline)
                            .foregroundStyle(Color("secondaryColor"))
                    }
                }.listStyle(.plain)
            }
        }
    }
    
    var thinLine: some View {
        Rectangle()
            .frame(height: 1)
            .padding(.horizontal,8)
    }
    
    // Functions
    
    func addRemoveFavorite() {
        
        if let recipeIndex = model.favoriteRecipes.firstIndex(where: {$0.label == pickedRecipe!.label}) {
            model.favoriteRecipes.remove(at: recipeIndex)
        } else {
            model.favoriteRecipes.append(pickedRecipe!)
        }
        
    }
    
    @ViewBuilder
    func searchTitle(title: String) -> some View {
        Text(title)
        .font(.title2)
        .bold()
            .padding(.leading, 20)
    }
     
    
}
