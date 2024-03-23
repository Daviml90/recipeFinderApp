//
//  ButtonViews.swift
//  LookUpRecipes
//
//  Created by Davi Martinelli de Lira on 3/13/24.
//

import SwiftUI

struct ButtonViews: View {
    var text: String = "Button"
    var textColor: Color = Color(hex: "#08bf9b")
    var background: Color = .white
    var font: Font = .headline
    
    init(text: String, background: Color, font: Font) {
        self.text = text
        self.textColor = .white
        self.background = background
        self.font = font
    }
    
    
    
    var body: some View {
        Text(text)
            .font(font)
            .foregroundStyle(textColor)
            .padding(2)
            .padding(.horizontal,10)
            .background(RoundedRectangle(cornerRadius: 40).fill(background).shadow(radius: 5))
        
    }
}

//#Preview {
//    ButtonViews()
//}
