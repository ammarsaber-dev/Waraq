//
//  BookCardView.swift
//  Waraq
//
//  Created by Ammar Saber on 29/08/2026.
//

import SwiftUI

struct BookCardView: View {
    let book: Book
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(book.title)
                    .font(.headline)
                Text(book.author)
                    .font(.footnote)
            }
            
            Spacer()
            
            CircularProgressView(progress: book.progress, strokeWidth: 5, color: .red)
                .frame(width: 50, height: 50)
        }
    }
}

#Preview {
    BookCardView(book: Book(title: "Waraq", author: "Ammar Saber", totalPages: 120))
}
