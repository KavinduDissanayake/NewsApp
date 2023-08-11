//
//  FilterBottomSheetViewModel.swift
//  NewsApp
//
//  Created by Kavindu Dissanayake on 2023-08-11.
//

import Foundation
import RxCocoa
import RxSwift


class FilterBottomSheetViewModel {

    let categoryList = BehaviorRelay<[Category]>(value: [
        .init(name: "business"),
        .init(name: "entertainment"),
        .init(name: "general"),
        .init(name: "health"),
        .init(name: "science"),
        .init(name: "sports"),
        .init(name: "technology")
    ])
    
    
    let selectedCategories = BehaviorRelay<[String?]>(value: [])

}

extension FilterBottomSheetViewModel {
    func toggleSelection(at index: Int) {
        var items = categoryList.value

        // Toggle the isSelected status of the item at the given index
        items[index].isSelected = !(items[index].isSelected ?? false)
        categoryList.accept(items)

        // Get all the names of the selected categories
        let selectedNames = items.filter { $0.isSelected == true }.map { $0.name }

        // Update the selectedCategories array
        selectedCategories.accept(selectedNames)
    }

}
