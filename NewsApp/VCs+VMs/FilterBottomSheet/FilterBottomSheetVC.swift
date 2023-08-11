//
//  FilterBottomSheetVC.swift
//  NewsApp
//
//  Created by Kavindu Dissanayake on 2023-08-11.
//

import UIKit
import RxSwift
import RxCocoa


class FilterBottomSheetVC: BaseVC {

    @IBOutlet weak var filtterOtipnsCv: UICollectionView!
    
    let disposeBag = DisposeBag()
    var viewModel = FilterBottomSheetViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()
        bindViewModel()
        // Do any additional setup after loading the view.
    }
    

}
extension FilterBottomSheetVC {
    func bindViewModel() {
        
        //cell declare
        viewModel.categoryList.asObservable()
            .bind(to: filtterOtipnsCv.rx.items(cellIdentifier: CategoryCell.className, cellType: CategoryCell.self)) { row, element, cell in
                // Configure your cell here
                cell.configCell(category: element)
            }
        
            .disposed(by: disposeBag)
        
        //select
        filtterOtipnsCv.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.viewModel.toggleSelection(at: indexPath.row)
            })
            .disposed(by: disposeBag)
        
        //call deleagets
        filtterOtipnsCv
            .rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    
    func configCollectionView(){
        //register xib
        self.filtterOtipnsCv.register(UINib(nibName: CategoryCell.className, bundle: Bundle.main), forCellWithReuseIdentifier: CategoryCell.className)
    }
}

extension FilterBottomSheetVC :UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == filtterOtipnsCv {
            // Dynamic cell width based on content width
            let font = UIFont(name: "Nunito-SemiBold", size: 14)!
            let width = viewModel.categoryList.value[indexPath.row].name?.widthWithConstrainedHeight(30, font: font) ?? 0
            return width < 90 ? CGSize(width: 97, height: 30) : CGSize(width: width + 30, height: 32)
            
        }
        return CGSize(width: 0, height: 0)
    }
    
}
