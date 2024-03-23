//
//  Icons.swift
//  LookUpRecipes
//
//  Created by Davi Martinelli de Lira on 3/20/24.
//

import SwiftUI

struct MeatIcon: View {
    @ObservedObject var model: RecipeFinderModel
    
    var index: Int
    
    var body: some View {
        VStack {
            Image(model.meats[index].image)
                .resizable()
                .scaledToFit()
                .foregroundStyle(Color(model.meats[index].selected ? Color("secondaryColor") : Color("primaryColor")))
                .padding(10)
                .background(Circle()
                    .fill(.white)
                    .shadow(radius: 3))
                .padding(.vertical,1)
            Text(model.meats[index].name)
                .foregroundStyle(.black)
        }
        .padding(.vertical, 4)
        .padding(.horizontal, 16)
        .onTapGesture {
            model.meats[index].selected.toggle()
            if model.meats[index].selected {
                model.searchText.insert(model.meats[index].searchText)
            } else {
                model.searchText.remove(model.meats[index].searchText)
            }
        }
    }
    
}

struct VegetableIcon: View {
    @ObservedObject var model: RecipeFinderModel
    
    var index: Int
    
    var body: some View {
        VStack {
            Image(model.vegetables[index].image)
                .resizable()
                .scaledToFit()
                .foregroundStyle(Color(model.vegetables[index].selected ? Color("secondaryColor") : Color("primaryColor")))
                .padding(10)
                .background(Circle()
                    .fill(.white)
                    .shadow(radius: 3))
                .padding(.vertical,1)
            Text(model.vegetables[index].name)
                .foregroundStyle(.black)
        }
        .padding(.vertical, 4)
        .padding(.horizontal, 16)
        .onTapGesture {
            model.vegetables[index].selected.toggle()
            if model.vegetables[index].selected {
                model.searchText.insert(model.vegetables[index].searchText)
            } else {
                model.searchText.remove(model.vegetables[index].searchText)
            }
        }
    }
}

struct RestrictionIcon: View {
    @ObservedObject var model: RecipeFinderModel
    var index: Int
    
    var body: some View {
        VStack {
            Image(model.restrictions[index].image)
                .resizable()
                .scaledToFit()
                .foregroundStyle(Color(model.restrictions[index].selected ? Color("secondaryColor") : Color("primaryColor")))
                .padding(10)
                .background(Circle()
                    .fill(.white)
                    .shadow(radius: 3))
                .padding(.vertical,1)
                .onTapGesture {
                    model.restrictions[index].selected.toggle()
                    if model.restrictions[index].selected {
                        model.searchText.insert(model.restrictions[index].searchText)
                    } else {
                        model.searchText.remove(model.restrictions[index].searchText)
                    }
                }
            Text(model.restrictions[index].name)
                .foregroundStyle(.black)
        }.padding(.horizontal,16)
            .padding(.top,5)
        
    }
}
