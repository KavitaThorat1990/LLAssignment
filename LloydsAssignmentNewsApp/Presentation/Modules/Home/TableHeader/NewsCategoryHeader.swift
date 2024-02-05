//
//  NewsCategoryHeader.swift
//  ExpressNews
//
//  Created by Kavita Thorat on 03/02/24.
//

import SwiftUI

struct NewsCategoryHeader: View {
    var title: String

    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
                .foregroundColor(.black)
            
            Spacer()
        }
        .padding(.vertical, 10)
    }
}

#Preview {
    NewsCategoryHeader(title: "Technology")
}
