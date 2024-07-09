//
//  ListViewModel.swift
//  Rick_and_Morty
//
//  Created by James Tochukwu Nwankwo on 08/07/2024.
//

import Foundation

final class ListViewModel {
    
    var listData: [ListItemCellModel] = []
    let pageTitle: String
    private let rmClient: RickAndMortyClientProvider
    var didSelectItem: ((ListItemCellModel) -> Void)?
    var isApiInProgress: ((Bool) -> Void)?
    var didThrowError: ((String) -> Void)?
    var didFetchResultData: (() -> Void)?
    private let userInitiatedQueue = DispatchQueue(label: "com.rickandmorty.app", qos: .userInitiated)
    private var isFetchInProgress = false
    private var isShowingLoadingView = false
    
    init(pageTitle: String,
         client: RickAndMortyClientProvider = RickAndMortyClientService.shared) {
        self.pageTitle = pageTitle
        self.rmClient = client
    }
    
    func fetchListData(page: Int? = nil) {
        guard !isFetchInProgress else {
            return
        }
        isFetchInProgress = true
        rmClient.fetchCharacters(
            page: page) { [weak self] status in
                self?.isApiInProgress?(status)
            } completion: { [weak self] response in
                self?.isFetchInProgress = false
                switch response {
                case .success(let result):
                    self?.listData += result
                    self?.didFetchResultData?()
                case .failure(let error):
                    self?.didThrowError?(error.localizedDescription)
                }
            }

    }
    
    func didSelectListData(at index: Int) {
        let selectedItem = listData[index]
        didSelectItem?(selectedItem)
    }
    
    func fetchNextPageIfPossible() {
        guard let nextPageIndex = listData.last?.nextPageIndex else { return }
        userInitiatedQueue.async { [weak self] in
            self?.fetchListData(page: nextPageIndex)
        }
    }
    
    func showLoadingView() {
        isShowingLoadingView = true
        isApiInProgress?(isShowingLoadingView)
    }
    
}
