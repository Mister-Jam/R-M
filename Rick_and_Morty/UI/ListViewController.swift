//
//  ListViewController.swift
//  Rick_and_Morty
//
//  Created by James Tochukwu Nwankwo on 08/07/2024.
//

import UIKit

final class ListViewController: UIViewController {
    
    private let viewModel: ListViewModel
    private var refreshControl: UIRefreshControl?
    
    init(viewModel: ListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: collectionViewLayout())
        collectionView.backgroundColor = UIColor.sinbadBlue.withAlphaComponent(0.5)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.keyboardDismissMode = .interactive
        return collectionView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        setupSubviews()
        viewModel.fetchListData()
        bindViewModel()
    }
    
    private func configureNavBar() {
        setupNavigationBar(backgroundColor: .sinbadBlue, barTintColor: UIColor.sinbadBlue.withAlphaComponent(0.4), tintColor: .labelTitle)
        title = viewModel.pageTitle
    }
    
    private func bindViewModel() {
        viewModel.didThrowError = { [weak self] errorMessage in
            DispatchQueue.main.async {
                self?.showErrorPopup(message: errorMessage)
            }
        }
        
        viewModel.didFetchResultData = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    
    private func setupSubviews() {
        view.backgroundColor = .systemBackground
        addSubview(collectionView)
        collectionView.fillParentViewWithSafeAreaTop(
            padding: .init(
                top: .zero,
                left: 20,
                bottom: 20,
                right: 20))
        setupCollectionView()
        setupRefreshControl()
    }
    
    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        guard let refreshControl else { return }
        collectionView.refreshControl = refreshControl
        collectionView.refreshControl?.addTarget(self, action: #selector(reloadData), for: .valueChanged)
    }
    
    @objc private func reloadData() {
        collectionView.refreshControl?.endRefreshing()
        viewModel.fetchListData()
    }
    
    func collectionViewLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] (_, _) -> NSCollectionLayoutSection? in
            return self?.contentLayoutSection()
        }
    }
    
    private func setupCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.register(ListItemCollectionViewCell.self, forCellWithReuseIdentifier: ListItemCollectionViewCell.reuseIdentifier)
        collectionView.prefetchDataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func contentLayoutSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(
            top: .zero,
            leading: 5,
            bottom: 10,
            trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(250))
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
}

extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.listData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListItemCollectionViewCell.reuseIdentifier, for: indexPath) as? ListItemCollectionViewCell else { return UICollectionViewCell() }
        let model = viewModel.listData[indexPath.row]
        cell.setupCellData(with: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectListData(at: indexPath.row)
    }
}

extension ListViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if shouldUpdateCollectionView(indexPaths: indexPaths) {
            viewModel.fetchNextPageIfPossible()
        }
    }
    
    func shouldUpdateCollectionView(indexPaths: [IndexPath]) -> Bool {
        return indexPaths.contains { $0.row >= viewModel.listData.count - 5 }
    }
}
