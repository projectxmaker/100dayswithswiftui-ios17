//
//  ContentView.swift
//  DD
//
//  Created by Pham Anh Tuan on 10/18/23.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingRed = false
    
    var body: some View {
        VStack {
            
            Button("Tap Me") {
                withAnimation {
                    isShowingRed.toggle()
                }
            }

            if isShowingRed {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .transition(.asymmetric(insertion: .push(from: .top), removal: .opacity))
            }
        }
    }
}

#Preview {
    ContentView()
}
