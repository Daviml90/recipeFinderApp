//
//  Models.swift
//  LookUpRecipes
//
//  Created by Davi Martinelli de Lira on 2/27/24.
//

import Foundation

struct RecipesResponse: Codable {
    let hits: [Hit]
}

struct Hit: Codable {
    let recipe: Recipe
}

struct Recipe: Codable {
    let label: String
    let ingredientLines: [String]
    let image: String
    let healthLabels: [String]
    let url: String
}

struct Ingredient {
    let id = UUID()
    let name: String
    let image: String
    let searchText: String
    var selected: Bool = false
    
    init(name: String, image: String, searchText: String) {
        self.name = name
        self.image = image
        self.searchText = searchText
    }
    
    mutating func unselect() {
        selected = false
    }
    
    mutating func selectTogle() {
        selected.toggle()
    }
    
    
}
