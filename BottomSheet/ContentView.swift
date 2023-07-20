//
//  ContentView.swift
//  BottomSheet
//
//  Created by Yuriy on 19.07.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var isShow = false
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack {
                Color.blue.opacity(0.4)
                Button(action: {
                    isShow = true
                }, label: {
                    Text("TAP ME")
                        .font(.system(size: 40, weight: .semibold, design: .rounded))
                        .foregroundColor(Color.black)
                        .padding(20)
                        .background(Color.red
                            .opacity(0.5))
                        .cornerRadius(20)
                        
                    
                })
                .offset(y: -100)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            
            BottomSheetView(isShowing: $isShow)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
