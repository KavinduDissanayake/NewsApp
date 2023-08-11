//
//  FilterBottomSheetViewModel.swift
//  NewsApp
//
//  Created by Kavindu Dissanayake on 2023-08-11.
//

import Foundation
import RxCocoa
import RxSwift



protocol FilterBottomSheetVCDelegate: AnyObject {
    func didSelectCategoryList(_ categoryList: [Category?])
    func currentSelectedCategories() -> [Category?]
}


class FilterBottomSheetViewModel {

    let categoryList = BehaviorRelay<[Category]>(value: [
        .init(name: "relevancy"),
        .init(name: "popularity"),
        .init(name: "publishedAt"),
        .init(name: "popularity"),
    ])
    
    
    let selectedCategories = BehaviorRelay<[Category?]>(value: [])
    
    
    func markCategoriesAsSelected() {
        let updatedCategories = categoryList.value.map { category in
            var updatedCategory = category
            updatedCategory.isSelected = selectedCategories.value.contains { $0?.name == category.name }
            return updatedCategory
        }

        categoryList.accept(updatedCategories)
    }

}

extension FilterBottomSheetViewModel {
    func toggleSelection(at index: Int) {
        var items = categoryList.value

        // Toggle the isSelected status of the item at the given index
        items[index].isSelected = !(items[index].isSelected ?? false)
        categoryList.accept(items)

        // Get all the names of the selected categories
        let selectedNames = items.filter { $0.isSelected == true }.map { $0 }

        // Update the selectedCategories array
        selectedCategories.accept(selectedNames)
    }

}
