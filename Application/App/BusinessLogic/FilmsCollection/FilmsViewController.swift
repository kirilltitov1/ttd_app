//
//  KinoViewController.swift
//  Application
//
//  Created by Kirill Titov on 02.06.2021.
//
// https://github.com/ReactiveX/RxSwift/issues/821

import UIKit
import RxSwift
import RxGesture
import RxCocoa
import SnapKit
import CasePaths

class FilmsViewController: UIViewController {
    
    // MARK: - Outlets
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: GridLayout(style: .fiftyFifty))
    private let searchBar = UISearchBar()
    
    // MARK: - Property
    
    private let disposeBag: DisposeBag
    private let reactor: FilmsReactor
    
    // MARK: - Init
    
    init(
        reactor: FilmsReactor,
        disposeBag: DisposeBag
    ) {
        self.reactor = reactor
        self.disposeBag = disposeBag
        
        super.init(nibName: nil, bundle: nil)
        
        viewHierarchy()
        makeConstraints()
        
        setupCollection()
        
        setupBindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
    }
    
    // MARK: - private
    
    private func setupCollection() {
        collectionView.register(FilmsViewCell.self, forCellWithReuseIdentifier: FilmsViewCell.reuseIdentifier)
        
        collectionView.alwaysBounceVertical = true
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    private func setupBindings() {
        reactor.state
            .observe(on: MainScheduler.instance)
            .distinctUntilChanged()
            .map { $0.cells.map(FilmsCellViewModel.init) }
            .bind(to: collectionView.rx.items(cellIdentifier: FilmsViewCell.reuseIdentifier, cellType: FilmsViewCell.self)) { [weak self] row, model, cell in
                
                guard let self = self else { return }
                
                cell.setupCellWith(viewModel: model)
                
                cell.contentView.rx
                    .tapGesture().when(.recognized)
                    .map { _ in FilmsReactor.Action.selectFilm(film: model.film) }
                    .bind(to: self.reactor.action)
                    .disposed(by: cell.reuseBag)
                
            }.disposed(by: disposeBag)
        
        searchBar.rx.text
            .orEmpty
            .distinctUntilChanged()
            .debounce(.milliseconds(500),
                      scheduler: MainScheduler.instance)
            .compactMap { FilmsReactor.Action.loadFilmsBy(prefix: $0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    // MARK: - Layout
    
    private func viewHierarchy() {
        view.addSubview(collectionView)
        view.addSubview(searchBar)
    }
    
    private func makeConstraints() {
        collectionView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview().inset(10)
            $0.top.equalTo(searchBar.snp.bottom)
        }
        searchBar.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(5)
            $0.leading.trailing.equalToSuperview()
        }
    }
}
