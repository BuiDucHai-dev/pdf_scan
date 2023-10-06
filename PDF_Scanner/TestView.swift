//
//  TestView.swift
//  PDF_Scanner
//
//  Created by Bùi Đức Hải on 28/09/2023.
//

import SwiftUI
import Vision

struct TestView: View {
    
    @State var a = false
    var body: some View {
        VStack(spacing: 0) {
            Text("hello")
                .background(Color.blue)
            Divider()
                .background(Color.blue)
                .foregroundColor(Color.red)
            Text("hello")
                .background(Color.blue)
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
