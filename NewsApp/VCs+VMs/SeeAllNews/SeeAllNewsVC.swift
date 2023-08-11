//
//  SeeAllNewsVC.swift
//  NewsApp
//
//  Created by Kavindu Dissanayake on 2023-08-11.
//

import UIKit
import RxSwift
import RxCocoa


class SeeAllNewsVC: BaseVC {

    @IBOutlet weak var topSearchTF: UITextField!
    @IBOutlet weak var allNewsTV: UITableView!
    @IBOutlet weak var catgoryCV: UICollectionView!
    @IBOutlet weak var searchBarBackStack: UIStackView!
    @IBOutlet weak var filterBtn: UIImageView!
    
    let disposeBag = DisposeBag()
    var viewModel = SeeAllNewsViewModel()
    
    var selectedCategories: [Category?] = []

    
    // MARK: -Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultBackBtn()
        configCollectionView()
        configTableView()
        bindViewModel()
        setupTapGesture()
       // getBottomNews()
        setUpUI()
    }
    
    // MARK: -Life Cycle
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    
    func setUpUI(){
        searchBarBackStack.setBorder(width: 1.0, color: UIColor(hexString: "#f1f2fa"), cornerRadius: 10.0)
    }
    func setupTapGesture() {
        filterBtn.isUserInteractionEnabled = true // Make sure user interaction is enabled

        let tapGesture = UITapGestureRecognizer()
        filterBtn.addGestureRecognizer(tapGesture)

        tapGesture.rx.event
            .bind(onNext: { [weak self] _ in
                // Handle the tap here
                self?.handlefilterBtnImageTap()
            })
            .disposed(by: disposeBag)
    }

    func handlefilterBtnImageTap() {
        //TODO: Rector this 
        let storyBoard = UIStoryboard(name: "Home", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "FilterBottomSheetVC") as! FilterBottomSheetVC
        vc.delegate = self
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
        
        
//        ASP.shared.presentViewController(in: .Home, for: .FilterBottomSheetVC, from: self)
    }
}

extension SeeAllNewsVC {
    func bindViewModel() {
        
        topSearchTF.rx.text.orEmpty
            .bind(to: viewModel.searchText)
            .disposed(by: disposeBag)
        
        //set debounced to avoid too many request
        viewModel.searchText.asObservable()
            .debounce(.seconds(3), scheduler: MainScheduler.instance)
            .distinctUntilChanged() // Make sure we only
            .subscribe(onNext: { [weak self] text in
                guard let text = text, !text.isEmpty else { return }
                self?.getBottomNews()
                
            })
            .disposed(by: disposeBag)
        
     
        
        //call deleagets
        catgoryCV
            .rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        //cell declare
        viewModel.categoryList.asObservable()
            .bind(to: catgoryCV.rx.items(cellIdentifier: CategoryCell.className, cellType: CategoryCell.self)) { row, element, cell in
                // Configure your cell here
                cell.configCell(category: element)
            }
        
            .disposed(by: disposeBag)
     
        
        
        //select
        catgoryCV.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.viewModel.toggleSelection(at: indexPath.row)
                self?.getBottomNews()
              
            })
            .disposed(by: disposeBag)
        
        
        //cell declare
        viewModel.atricleBottomList.asObservable()
            .bind(to: allNewsTV.rx.items(cellIdentifier: NewsTVCell.className, cellType: NewsTVCell.self)) { row, element, cell in
                cell.selectionStyle = .none

                cell.configCell(article: element)
            }
            .disposed(by: disposeBag)
        
        //cell pagnition
        allNewsTV.rx.willDisplayCell
            .subscribe(onNext: { [weak self] (cell, indexPath) in
                let lastItem = (self?.viewModel.atricleBottomList.value.count ?? 0) - 2
                if indexPath.row == lastItem {
                    self?.viewModel.currentPageBottomNews += 1
                    self?.getBottomNews()
                }
            })
            .disposed(by: disposeBag)
        
        
        allNewsTV.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                
                ASP.shared.pushToViewController(in: .Home, for: .NewsDetailVC, from: self,data: self?.viewModel.atricleBottomList.value[indexPath.row])

            })
            .disposed(by: disposeBag)
        
    }
}
extension SeeAllNewsVC {
    func configCollectionView(){
        //register xib
        self.catgoryCV.register(UINib(nibName: CategoryCell.className, bundle: Bundle.main), forCellWithReuseIdentifier: CategoryCell.className)
    }
    
    
    func configTableView(){
        self.allNewsTV?.register(UINib(nibName: NewsTVCell.className, bundle: nil), forCellReuseIdentifier:  NewsTVCell.className)

    }
}

//MARK: api call

extension SeeAllNewsVC {
    func getBottomNews(){
        self.startLoading()
        viewModel.getAllNews() { status, message in
            self.stopLoading()
            //handle error
            if message !=  "" && !status{
                self.showAlert(message)
            }
        }
    }
}




extension SeeAllNewsVC :UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        if collectionView == catgoryCV {
            
            // Dynamic cell width based on content width
            let font = UIFont(name: "Nunito-SemiBold", size: 14)!
            let width = viewModel.categoryList.value[indexPath.row].name?.widthWithConstrainedHeight(30, font: font) ?? 0
            return width < 90 ? CGSize(width: 97, height: 30) : CGSize(width: width + 20, height: 32)
            
        }
        return CGSize(width: 0, height: 0)
        
    }
}



class DelegateManager {
    static let shared = DelegateManager()
    
    private var delegates: [String: AnyObject] = [:]
    
    private init() {}
    
    func setDelegate<T: AnyObject>(for identifier: ViewContolers, delegate: T) {
        delegates[identifier.rawValue] = delegate
    }
    
    func delegate<T>(for identifier: ViewContolers) -> T? {
        return delegates[identifier.rawValue] as? T
    }
}

extension SeeAllNewsVC: FilterBottomSheetVCDelegate {
    func didSelectCategoryList(_ categoryList: [Category?]) {
        self.selectedCategories = categoryList
    }
    
    func currentSelectedCategories() -> [Category?] {
        return self.selectedCategories

    }
}
