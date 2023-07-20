//
//  BottomSheetView.swift
//  BottomSheet
//
//  Created by Yuriy on 19.07.2023.
//

import SwiftUI

struct BottomSheetView: View {
    //112233441112233233232323
    //test
    @Binding var isShowing: Bool
    @State private var curHeight: CGFloat = 400
    
    let minHeight: CGFloat = 400
    let maxHeight: CGFloat = 400
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if isShowing {
                
                Color.black.opacity(0.4)
                    .onTapGesture {
                        isShowing = false
                    }
                
                content()
                    .animation(.easeInOut)
                    .transition(.move(edge: .bottom))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .edgesIgnoringSafeArea(.all)
        // сбрасывает высоту на curHeight
        .onChange(of: isShowing) { newValue in
            if !newValue {
                curHeight = minHeight
            }
        }
    }
    
    @ViewBuilder
    func content() -> some View {
        ZStack(alignment: .bottom) {
            ZStack {
                Capsule()
                    .frame(width: 40, height: 8)
                    .foregroundColor(Color.gray.opacity(0.4))
                    .padding(.bottom, curHeight + 10)
            }
            .frame(maxWidth: .infinity)
            .background(Color.white.opacity(0.000001))
            .gesture(dragGesture)
        
            VStack {
                ScrollView {
                    Text("Content")
                        .padding(20)
                        .frame(maxWidth: .infinity)
                    Text("Content")
                        .padding(20)
                    Text("Content")
                        .padding(20)
                    Text("Content")
                        .padding(20)
                    Text("Content")
                        .padding(20)
                    Text("Content")
                        .padding(20)
                    Text("Content")
                        .padding(20)
                    Text("Content")
                        .padding(20)
                    
                }
                .padding(.top, 20)
                
            }
            
            .frame(height: curHeight)
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(24, corners: [.topLeft, .topRight])
        }
        
        
    }
    @State private var prevDrag = CGSize.zero
    var dragGesture: some Gesture {
            DragGesture(minimumDistance: 0, coordinateSpace: .global)
                .onChanged { val in
                    let drugAmount = val.translation.height - prevDrag.height
                    
                    if curHeight > maxHeight  {
                        curHeight -= drugAmount / 5
                        curHeight = maxHeight
                    } else {
                        curHeight -= drugAmount
                    }

                    prevDrag = val.translation
                }
                .onEnded { val in
                    prevDrag = .zero
                    if curHeight > 250 {
                        curHeight = maxHeight
                    } else if curHeight < 250 {
                        isShowing = false
                    }
                }
        }
}


struct CornerRadiusStyle: ViewModifier {
    var radius: CGFloat
    var corners: UIRectCorner
    
    struct CornerRadiusShape: Shape {

        var radius = CGFloat.infinity
        var corners = UIRectCorner.allCorners

        func path(in rect: CGRect) -> Path {
            let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            return Path(path.cgPath)
        }
    }

    func body(content: Content) -> some View {
        content
            .clipShape(CornerRadiusShape(radius: radius, corners: corners))
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        ModifiedContent(content: self, modifier: CornerRadiusStyle(radius: radius, corners: corners))
    }
}

struct BottomSheetView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//        BottomSheetView(isShowing: .constant(true))
    }
}
