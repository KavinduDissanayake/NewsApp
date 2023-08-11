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
    @IBOutlet weak var resetBtnImge: UIImageView!
    @IBOutlet weak var saveBtn: UIButton!
    
    @IBOutlet var backgroundView: UIView!
    
    
    
    var viewModel = FilterBottomSheetViewModel()
    let disposeBag = DisposeBag()
    
    weak var delegate: FilterBottomSheetVCDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()
        
        setUpUI()
        setupTapGesture()
        
        bindViewModel()
        
        //markCategoriesAsSelected
        if let previouslySelectedCategories = delegate?.currentSelectedCategories() {
            viewModel.selectedCategories.accept(previouslySelectedCategories)
            viewModel.markCategoriesAsSelected()
        }
        
    }
    
    @IBAction func saveAction(_ sender: Any) {
        dimisedView()
        let selectedCategories = viewModel.selectedCategories.value
        self.delegate?.didSelectCategoryList(selectedCategories)
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

extension FilterBottomSheetVC {
    func setUpUI(){
        let startColor = UIColor(red: 1, green: 0.23, blue: 0.27, alpha: 1)
        let endColor = UIColor(red: 1, green: 0.50, blue: 0.53, alpha: 1)
        saveBtn.setGradientBackground(colorOne: startColor, colorTwo: endColor, cornerRadius: 20)
    }
    func setupTapGesture() {
        resetBtnImge.isUserInteractionEnabled = true // Make sure user interaction is enabled
        
        let tapGesture = UITapGestureRecognizer()
        resetBtnImge.addGestureRecognizer(tapGesture)
        
        tapGesture.rx.event
            .bind(onNext: { [weak self] _ in
                // Handle the tap here
                self?.handleResetImageTap()
            })
            .disposed(by: disposeBag)
        
    }
    
    func handleResetImageTap() {
        // Your logic for the tap gesture on the resetBtnImge
        print("Image tapped!")
        dimisedView()
        viewModel.selectedCategories.accept([])
        let selectedCategories = viewModel.selectedCategories.value
        self.delegate?.didSelectCategoryList(selectedCategories)
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
