//
//  Detailed Recipe.swift
//  LookUpRecipes
//
//  Created by Davi Martinelli de Lira on 2/29/24.
//

import SwiftUI

let mockRecipe = Recipe(label: "Chicken Vesuvio", ingredientLines: ["1/2 cup olive oil","5 cloves garlic, peeled","3/4 cup white wine","3/4 cup chicken stock","3 tablespoons chopped parsley","1 tablespoon dried oregano","Salt and pepper","1 cup frozen peas, thawed"], image: "https://www.allrecipes.com/thmb/xvlRRhK5ldXuGcXad8XDM5tTAfE=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/223382_chicken-stir-fry_Rita-1x1-1-b6b835ccfc714bb6a8391a7c47a06a84.jpg", healthLabels: ["Mediterranean","Dairy-Free","Gluten-Free","Wheat-Free","Egg-Free","Peanut-Free","Tree-Nut-Free","Soy-Free","Fish-Free","Shellfish-Free","Pork-Free","Red-Meat-Free","Crustacean-Free","Celery-Free","Mustard-Free","Sesame-Free","Lupine-Free","Mollusk-Free","Kosher"], url: "http://www.seriouseats.com/recipes/2011/12/chicken-vesuvio-recipe.html")

struct DetailedView: View {
    let recipe: Recipe
    @StateObject var model: RecipeFinderModel
    @Environment(\.dismiss) private var dismiss
    @State var restictrionsPopover: Bool = false
    
    var favorite: Bool {
        if model.favoriteRecipes.contains(where: {$0.label == recipe.label}) {
           return true
        } else {
           return false
        }
    }
    
    
    var body: some View {
        ScrollView {
            
            VStack{
                AsyncImage(url: URL(string: recipe.image), content: { image in
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
                
                
                Text(recipe.label)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding()
               
                HStack {
                    HealthLabels(recipe: recipe)
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
                        Button("Add to List") {
                            for item in recipe.ingredientLines {
                                model.ingredientsList.append(item)
                            }
                        }
                    }
                        ForEach(recipe.ingredientLines, id:\.self) { line in
                            Text("- \(line)")
                        }
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 15)
                .padding(.vertical,20)
                
                let privacyPolicyText = "[Go to Recipe's website](\(recipe.url))"
                
                Text(.init(privacyPolicyText))
                Spacer()
                
            }
            
            
        }.ignoresSafeArea()
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
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    Button {
                       addRemoveFavorite()
                    } label: {
                        Image(systemName: "heart.circle.fill")
                            .font(.title)
                            .foregroundStyle(.white)
                            .background(Circle().fill(favorite ? Color("primaryColor") : .gray))
                    }
                }
            }
            
        
    }
    
    func addRemoveFavorite() {
        
        if let recipeIndex = model.favoriteRecipes.firstIndex(where: {$0.label == recipe.label}) {
            model.favoriteRecipes.remove(at: recipeIndex)
        } else {
            model.favoriteRecipes.append(recipe)
        }
        
    }
    
}

struct HealthLabels: View {
    var recipe: Recipe
    
    
    var body: some View {
        HStack {
            if Set(recipe.healthLabels).contains("Gluten-Free") {
                HStack(spacing: 4){
                    Image("glutenSymbol")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 20)
                }.foregroundStyle(Color(hex: "#ab7a0f"))
            }
            if Set(recipe.healthLabels).contains("Dairy-Free") {
                HStack(spacing: 4){
                    Image("dairySymbol")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 20)
                }.foregroundStyle(Color(hex: "#157de6"))
            }
            if Set(recipe.healthLabels).contains("Kosher") {
                HStack(spacing: 4){
                    Image("kosherSymbol")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 20)
                }.foregroundStyle(Color(.black))
            }
            if Set(recipe.healthLabels).contains("Peanut-Free") {
                HStack(spacing: 4){
                    Image("peanutSymbol")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 20)
                }.foregroundStyle(Color(.brown))
            }
            if Set(recipe.healthLabels).contains("Vegan") {
                HStack(spacing: 4){
                    Image("veganSymbol")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 20)
                }.foregroundStyle(Color(hex: "#09541d"))
            }
            if Set(recipe.healthLabels).contains("Vegetarian") {
                HStack(spacing: 4){
                    Image("vegetarianSymbol")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 20)
                }.foregroundStyle(Color(.green))
            }
            
        }
    }
    
}

struct RestrictionsList: View {
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 4){
                Image("glutenSymbol")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 20)
                    .foregroundStyle(Color(hex: "#ab7a0f"))
                Text("Gluten Free")
            }
            HStack(spacing: 4){
                Image("dairySymbol")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 20)
                    .foregroundStyle(Color(hex: "#157de6"))
                Text("Dairy Free")
            }
            HStack(spacing: 4){
                Image("kosherSymbol")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 20)
                    .foregroundStyle(.black)
                Text("Kosher")
            }
            HStack(spacing: 4){
                Image("peanutSymbol")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 20)
                    .foregroundStyle(.brown)
                Text("Peanut Free")
            }
            HStack(spacing: 4){
                Image("veganSymbol")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 20)
                    .foregroundStyle(Color(hex: "#09541d"))
                Text("Vegan")
            }
            HStack(spacing: 4){
                Image("vegetarianSymbol")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 20)
                    .foregroundStyle(.green)
                Text("Vegetarian")
            }
        }.padding(.horizontal,5)
    }

}


struct RowView: View {
  let item: String

  @State private var stroken = false

  var body: some View {
      
      VStack(alignment: .leading) {
          HStack(alignment: .top) {
              Image(systemName: stroken ? "checkmark.square.fill" : "square")
              Text(item)
                  .strikethrough(stroken)
                  
          }
          .onTapGesture(perform: {
              self.stroken.toggle()
      })
      }.frame(maxWidth: .infinity, alignment: .leading)
  }
}

#Preview {
    DetailedView(recipe: mockRecipe, model: RecipeFinderModel())
}
