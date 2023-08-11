//
//  HomeViewModel.swift
//  NewsApp
//
//  Created by Kavindu Dissanayake on 2023-08-10.
//
import RxSwift
import RxCocoa
import Alamofire

struct Category {
    var name: String?
    var isSelected: Bool?
}

class HomeViewModel {
    // Input
    let searchText = BehaviorRelay<String?>(value: nil)
    // MARK: - Input
    let atricleTopList = BehaviorRelay<[Article?]>(value:[])
    let atricleBottomList = BehaviorRelay<[Article?]>(value:[])

    let categoryList = BehaviorRelay<[Category]>(value: [
        .init(name: "business"),
        .init(name: "entertainment"),
        .init(name: "general"),
        .init(name: "health"),
        .init(name: "science"),
        .init(name: "sports"),
        .init(name: "technology")
    ])


    let selectedCategory = BehaviorRelay<String?>(value: nil)

    var currentPageTopNews = 1
    var totalResultsTopNews: Int = -1
    
    var currentPageBottomNews = 1
    var totalResultsBottomNews: Int = -1

}

extension HomeViewModel {
    func toggleSelection(at index: Int) {
        var items = categoryList.value
        for i in 0..<items.count {
            if i == index {
                items[i].isSelected = !(items[i].isSelected ?? false)
                
                // If the item is selected, update selectedCategory with its name
                if items[i].isSelected == true {
                    selectedCategory.accept(items[i].name)
                } else {
                    selectedCategory.accept(nil)
                }
            } else {
                items[i].isSelected = false
            }
        }
        categoryList.accept(items)
    }


}
extension HomeViewModel {
    func getTopNews(perPage: Int = 10,completion: @escaping CompletionHandler) {
        //check internet connection
        guard Reachability.isInternetAvailable() else {
            completion(false,"Internet connection appears to be offline. ")
            return
        }
        
        let endpoint = "top-headlines"
        let parameters: [String: Any] = [
            "q":searchText.value ?? "",
            "category": selectedCategory.value ?? "",
            "page": currentPageTopNews,
            "pageSize":perPage,
            "country":"us",//TODO: need to change it later
            "domains":"bbc.co.uk"//other wise getting error from server
        ]
        
        // If already fetched all articles, don't make a new request
        guard !hasFetchedAllArticles() else { return  completion(false,"") }
        
        AFWrapper.shared.request(endpoint, parameters: parameters, encoding: URLEncoding.queryString, success: { (response: NewsEverythingResponse) in
            if let total = response.totalResults {
                self.totalResultsTopNews = total
            }
            
            let updatedArticles = self.atricleTopList.value + (response.articles ?? [])
            self.atricleTopList.accept(updatedArticles)
            completion(true,"Sucess Data getting..")
        }, failure: { error in
            if let afError = error as? AFWrapperError {
                completion(false,afError.errorMessage)
            }else{
                completion(false,error.localizedDescription)
            }
        })
    }
    
    private func hasFetchedAllTopArticles() -> Bool {
        return atricleTopList.value.count == totalResultsTopNews
    }
}


extension HomeViewModel {
    func getAllNews(perPage: Int = 10,completion: @escaping CompletionHandler) {
        //check internet connection
        guard Reachability.isInternetAvailable() else {
            completion(false,"Internet connection appears to be offline. ")
            return
        }
        
        let endpoint = "everything"
        let parameters: [String: Any] = [
            "q":searchText.value ?? "",
            "category": selectedCategory.value ?? "",
            "page": currentPageBottomNews,
            "pageSize":perPage,
            "domains":"bbc.co.uk"//other wise getting error from server
        ]
        // If already fetched all articles, don't make a new request
        guard !hasFetchedAllArticles() else { return  completion(false,"") }
        
        
        AFWrapper.shared.request(endpoint, parameters: parameters, encoding: URLEncoding.queryString, success: { (response: NewsEverythingResponse) in
            if let total = response.totalResults {
                self.currentPageBottomNews = total
            }
            
            let updatedArticles = self.atricleBottomList.value + (response.articles ?? [])
            self.atricleBottomList.accept(updatedArticles)
            completion(true,"Sucess Data getting..")
        }, failure: { error in
            if let afError = error as? AFWrapperError {
                completion(false,afError.errorMessage)
            }else{
                completion(false,error.localizedDescription)
            }
        })
    }
    
    private func hasFetchedAllArticles() -> Bool {
        return atricleBottomList.value.count == totalResultsBottomNews
    }
}
