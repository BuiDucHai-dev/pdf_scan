//
//  FilterSelectionView.swift
//  PDF_Scanner
//
//  Created by Bùi Đức Hải on 05/10/2023.
//

import SwiftUI

struct FilterSelectionView: View {
    
    @Binding var photo: [Photo]
    @Binding var currentItem: Int
    
    @State var filter: [Filter] = []
    @State var selectedItem = FilterEnum.origin_filter
    
    let filterType: [FilterEnum] = [
        FilterEnum.origin_filter,
        FilterEnum.bnw_filter,
        FilterEnum.gray_filter,
        FilterEnum.brightness_filter,
        FilterEnum.remove_shadow_filter
    ]
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(filter) { item in
                    ItemFilterView(filter: item, selectedFilter: $selectedItem)
                        .onTapGesture {
                            selectedItem = item.type
                        }
                }
            }
            .onAppear {
//                fetchFilterList()
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 8)
        }
        .background(Color.white)
        .onChange(of: currentItem) { _ in
            fetchFilterList()
        }
    }
    
    private func fetchFilterList() {
        print("fetchFilterList")
        filter.append(Filter(name: "Original",
                             photo: getImageWithFilter(photo: photo[currentItem], filterType: FilterEnum.origin_filter),
                             type: FilterEnum.origin_filter))
        filter.append(Filter(name: "B&W",
                             photo: getImageWithFilter(photo: photo[currentItem], filterType: FilterEnum.bnw_filter),
                             type: FilterEnum.bnw_filter, isPro: true))
        filter.append(Filter(name: "Gray",
                             photo: getImageWithFilter(photo: photo[currentItem], filterType: FilterEnum.gray_filter),
                             type: FilterEnum.gray_filter, isPro: true))
        filter.append(Filter(name: "Brightness",
                             photo: getImageWithFilter(photo: photo[currentItem], filterType: FilterEnum.brightness_filter),
                             type: FilterEnum.brightness_filter))
        filter.append(Filter(name: "Remove Shadow",
                             photo: getImageWithFilter(photo: photo[currentItem], filterType: FilterEnum.remove_shadow_filter),
                             type: FilterEnum.remove_shadow_filter))
    }
    
    private func getImageWithFilter(photo: Photo, filterType: FilterEnum) -> Photo {
        return photo
    }
}

struct FilterSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        FilterSelectionView(photo: .constant([Photo(originalData: Data())]), currentItem: .constant(0), filter: [])
    }
}
