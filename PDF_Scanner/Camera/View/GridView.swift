//
//  GridView.swift
//  PDF_Scanner
//
//  Created by Bùi Đức Hải on 02/10/2023.
//

import SwiftUI

struct GridView: View {
    var body : some View {
            ZStack {
                HStack {
                    Spacer()
                    Divider().background(Color.white)
                    Spacer()
                    Divider().background(Color.white)
                    Spacer()
                }

                VStack {
                    Spacer()
                    Divider().background(Color.white)
                    Spacer()
                    Divider().background(Color.white)
                    Spacer()
                }
            }
        }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView()
    }
}
