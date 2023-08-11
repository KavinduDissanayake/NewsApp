//
//  HomeVC.swift
//  NewsApp
//
//  Created by Kavindu Dissanayake on 2023-08-10.
//

import UIKit
import SwiftUI
import RxSwift
import RxCocoa

class HomeVC: BaseVC{
    
    @IBOutlet weak var topSearchTF: UITextField!
    @IBOutlet weak var latestNewsCV: UICollectionView!
    @IBOutlet weak var catgoryCV: UICollectionView!
    @IBOutlet weak var allNewsTV: UITableView!
    @IBOutlet weak var searchBarBackStack: UIStackView!
    @IBOutlet weak var seeAllBtnStack: UIStackView!
    
    
    let disposeBag = DisposeBag()
    var viewModel = HomeViewModel()
    
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar(isHide: true)
        // Do any additional setup after loading the view.
        configCollectionView()
        setUpUI()
        configTableView()
        bindViewModel()
        
        configTableView()
        setupTapGesture()
        
        //fetch all the data from api
        getTopAndAllNews()
       
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        hideNavigationBar(isHide: false)
    }
    
    func setUpUI(){
        searchBarBackStack.setBorder(width: 1.0, color: UIColor(hexString: "#f1f2fa"), cornerRadius: 10.0)
    }
    func setupTapGesture() {
        seeAllBtnStack.isUserInteractionEnabled = true // Make sure user interaction is enabled
        
        let tapGesture = UITapGestureRecognizer()
        seeAllBtnStack.addGestureRecognizer(tapGesture)
        
        tapGesture.rx.event
            .bind(onNext: { [weak self] _ in
                // Handle the tap here
                self?.seeAllTap()
            })
            .disposed(by: disposeBag)
        
    }
    
    func seeAllTap() {
        ASP.shared.pushToViewController(in: .Home, for: .SeeAllNewsVC, from: self)
    }
    
}

extension HomeVC {
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
                self?.getTopAndAllNews()
            })
            .disposed(by: disposeBag)
        
        
        //cell declare
        viewModel.atricleTopList.asObservable()
            .bind(to: latestNewsCV.rx.items(cellIdentifier: LatestNewsCell.className, cellType: LatestNewsCell.self)) { row, element, cell in
                cell.configCell(article: element)
            }
            .disposed(by: disposeBag)
        
        //cell pagnition
        latestNewsCV.rx.willDisplayCell
            .subscribe(onNext: { [weak self] (cell, indexPath) in
                let lastItem = (self?.viewModel.atricleTopList.value.count ?? 0) - 2
                if indexPath.row == lastItem {
                    self?.viewModel.currentPageTopNews += 1
                    self?.getTopNews()
                }
            })
            .disposed(by: disposeBag)
        
        latestNewsCV.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                
                ASP.shared.pushToViewController(in: .Home, for: .NewsDetailVC, from: self,data: self?.viewModel.atricleTopList.value[indexPath.row])

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
                self?.getTopAndAllNews()
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


extension HomeVC {
    func configCollectionView(){
        //register xib
        self.latestNewsCV.register(UINib(nibName: LatestNewsCell.className, bundle: Bundle.main), forCellWithReuseIdentifier: LatestNewsCell.className)
        
        self.catgoryCV.register(UINib(nibName: CategoryCell.className, bundle: Bundle.main), forCellWithReuseIdentifier: CategoryCell.className)
    }
    
    func configTableView(){
        self.allNewsTV?.register(UINib(nibName: NewsTVCell.className, bundle: nil), forCellReuseIdentifier:  NewsTVCell.className)

    }
}

//MARK: api call
extension HomeVC {
    func getTopNews(){
        self.startLoading()
        viewModel.getTopNews() { status, message in
            self.stopLoading()
            //handle error
            if message !=  "" && !status{
                self.showAlert(message)
            }
        }
    }
}

extension HomeVC {
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

extension HomeVC {
    func getTopAndAllNews() {
        self.startLoading()
        //used this to speed up the process
        let group = DispatchGroup()
        var messages: [String] = []

        group.enter()
        viewModel.getTopNews() { status, message in
            if !status && !message.isEmpty {
                messages.append(message)
            }
            group.leave()
        }

        group.enter()
        viewModel.getAllNews() { status, message in
            if !status && !message.isEmpty {
                messages.append(message)
            }
            group.leave()
        }

        group.notify(queue: .main) {
            self.stopLoading()
            messages.forEach { self.showAlert($0) }
        }
    }
}


extension HomeVC :UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == latestNewsCV {
            return CGSize(width: 345, height: 240)
        }
        
        if collectionView == catgoryCV {
            
            // Dynamic cell width based on content width
            let font = UIFont(name: "Nunito-SemiBold", size: 14)!
            let width = viewModel.categoryList.value[indexPath.row].name?.widthWithConstrainedHeight(30, font: font) ?? 0
            return width < 90 ? CGSize(width: 97, height: 30) : CGSize(width: width + 20, height: 32)
            
        }
        return CGSize(width: 0, height: 0)
        
    }
}


//MARK: PREVIEW
struct HomeVC_Previews: PreviewProvider {
    static var previews: some View {
        let homeVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeVC")
        return UIViewControllerWrapper(viewController: homeVC).ignoresSafeArea()
    }
}

