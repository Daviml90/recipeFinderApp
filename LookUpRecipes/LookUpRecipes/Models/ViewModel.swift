//
//  Data.swift
//  LookUpRecipes
//
//  Created by Davi Martinelli de Lira on 2/27/24.
//

import Foundation

class RecipeFinderModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var searchText: Set<String> = []
    @Published var meats: [Ingredient] = []
    @Published var vegetables: [Ingredient] = []
    @Published var restrictions: [Ingredient] = []
    @Published var notFound: Bool = false
    @Published var appliedTexts: [String] = []
    @Published var ingredientsList: [String] = ["banana"]
    @Published var favoriteRecipes: [Recipe] = []
    
    // Search Data
    
    var beef = Ingredient(name: "Beef", image: "beefSymbol", searchText: "Beef")
    var pork = Ingredient(name: "Pork", image: "porkSymbol", searchText: "Pork")
    var chicken = Ingredient(name: "Chicken", image: "chickenSymbol", searchText: "Chicken")
    var turkey = Ingredient(name: "Turkey", image: "turkeySymbol", searchText: "Turkey")
    var bacon = Ingredient(name: "Bacon", image: "baconSymbol", searchText: "Bacon")
    var broccoli = Ingredient(name: "Broccoli", image: "broccoliSymbol", searchText: "Broccoli")
    var onion = Ingredient(name: "Onion", image: "onionSymbol", searchText: "Onion")
    var carrot = Ingredient(name: "Carrot", image: "carrotSymbol", searchText: "Lemon")
    var potato = Ingredient(name: "Potato", image: "potatoSymbol", searchText: "Potato")
    var spinach = Ingredient(name: "Spinach", image: "spinachSymbol", searchText: "Spinach")
    var glutenFree = Ingredient(name: "GF", image: "glutenSymbol", searchText: "Gluten Free")
    var vegan = Ingredient(name: "Vegan", image: "veganSymbol", searchText: "Vegan")
    var peanutFree = Ingredient(name: "No Peanut", image: "peanutSymbol", searchText: "Peanut Free")
    var dairyFree = Ingredient(name: "No Dairy", image: "dairySymbol", searchText: "Dairy Free")
    var vegetarian = Ingredient(name: "Vegetarian", image: "vegetarianSymbol", searchText: "Vegetarian")
    var kosher = Ingredient(name: "Kosher", image: "kosherSymbol", searchText: "Kosher")
    
    init() {
        self.meats.append(beef)
        self.meats.append(pork)
        self.meats.append(chicken)
        self.meats.append(turkey)
        self.meats.append(bacon)
        self.vegetables.append(broccoli)
        self.vegetables.append(onion)
        self.vegetables.append(potato)
        self.vegetables.append(carrot)
        self.vegetables.append(spinach)
        self.restrictions.append(glutenFree)
        self.restrictions.append(vegan)
        self.restrictions.append(dairyFree)
        self.restrictions.append(peanutFree)
        self.restrictions.append(vegetarian)
        self.restrictions.append(kosher)
    }
    
    func delete(index: IndexSet) {
        self.appliedTexts.remove(atOffsets: index)
    }
    
    func clearSearch() {
        for index in 0..<self.meats.count {
            self.meats[index].selected = false
        }
        for index in 0..<self.vegetables.count {
            self.vegetables[index].selected = false
        }
        for index in 0..<self.restrictions.count {
            self.restrictions[index].selected = false
        }
        self.searchText = []
        self.appliedTexts = []
    }
    
    func getMenuData() {
        var search: String = ""
        
        for text in searchText {
            search += " \(text)"
        }
        
        
        self.recipes = []
        let littleLemonAddress = "https://api.edamam.com/api/recipes/v2?type=public&q=\(search)&app_id=28abe590&app_key=15df2831af1356384f39129f327669fb"
        let url = URL(string: littleLemonAddress)
        if let url = url {
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data{
                    let fullMenu = try? JSONDecoder().decode(RecipesResponse.self, from: data)
                    guard let fullMenu = fullMenu else {
                        return print("test2")
                    }
                    for item in fullMenu.hits {
                        self.recipes.append(item.recipe)
                    }
                    if fullMenu.hits.count == 0 {
                        self.notFound = true
                    }
                }
            }
            task.resume()
            
        }
        
    }
    
}
