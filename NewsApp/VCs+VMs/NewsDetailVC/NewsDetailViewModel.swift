//
//  NewsDetailViewModel.swift
//  NewsApp
//
//  Created by Kavindu Dissanayake on 2023-08-11.
//

import RxSwift
import RxCocoa


class NewsDetailViewModel {
    
    let article: BehaviorRelay<Article?> = BehaviorRelay(value: nil)

}
