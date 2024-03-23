//
//  BackgroundView.swift
//  LookUpRecipes
//
//  Created by Davi Martinelli de Lira on 3/20/24.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        LinearGradient(colors: [Color("primaryColor"), .white], startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea()
    }
}

#Preview {
    BackgroundView()
}
