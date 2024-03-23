//
//  Detailed Recipe.swift
//  LookUpRecipes
//
//  Created by Davi Martinelli de Lira on 2/29/24.
//

import SwiftUI

struct DetailedView: View {
    let recipe: Recipe
    
    var body: some View {
        VStack{
            Text(recipe.label)
            AsyncImage(url: URL(string: recipe.image), content: { image in
                                image.resizable()
                                     .aspectRatio(contentMode: .fit)
                                     .frame(maxWidth: 70, maxHeight: 50)
                            },
                            placeholder: {
                                ProgressView()
                            }
                        )
            ForEach(recipe.ingredientLines, id:\.self) { line in
                Text(line)
            }
            
        }
        
    }
}

#Preview {
    DetailedView()
}
