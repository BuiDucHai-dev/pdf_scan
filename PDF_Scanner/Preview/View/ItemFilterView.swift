//
//  ItemFilterView.swift
//  PDF_Scanner
//
//  Created by Bùi Đức Hải on 05/10/2023.
//

import SwiftUI

public struct ItemFilterView: View {
    
    var filter: Filter
    @Binding var selectedFilter: FilterEnum
    @State var color: Color = Color.blue
    
    public var body: some View {

        VStack {
            ZStack {
                Image(uiImage: filter.photo.thumbnailImage!)
                    .resizable()
                    .frame(width: 60, height: 60)
                if selectedFilter == filter.type {
                    Rectangle()
                        .stroke(Color.blue, lineWidth: 3)
                }
            }
            .frame(width: 60, height: 60)
            
            Text("\(filter.name)")
                .font(.footnote)
                .fontWeight(getFontWeight())
                .foregroundColor(getColor())
                .lineLimit(1)
        }
        .onAppear {
            print("ItemFilterView \(filter.name)")
        }
        .frame(width: 80)
    }
    
    private func getFontWeight() -> Font.Weight {
        if selectedFilter == filter.type {
            return Font.Weight.medium
        } else {
            return Font.Weight.regular
        }
    }
    
    private func getColor() -> Color {
        if selectedFilter == filter.type {
            return Color.blue
        } else {
            return Color.primary
        }
    }
}

struct ItemFilterView_Previews: PreviewProvider {
    static var previews: some View {
        ItemFilterView(filter: Filter(name: "Original",
                                      photo: Photo(originalData: Data()),
                                      type: .origin_filter),
                       selectedFilter: .constant(FilterEnum.origin_filter))
    }
}
