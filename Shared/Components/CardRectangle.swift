//
//  CardRectangle.swift
//  Quick Map
//
//  Created by Chatsopon Deepateep on 11/6/2565 BE.
//

import SwiftUI

struct CardRectangle: View {
    let color: Color
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundColor(color)
            .frame(height: 50)
            .shadow(color: .black.opacity(0.125), radius: 5, x: 0, y: 2)
            .shadow(color: .black.opacity(0.5), radius: 0.5, x: 0, y: 0)
    }
}

struct CardRectangle_Previews: PreviewProvider {
    static var previews: some View {
        CardRectangle(color: .textField)
    }
}
