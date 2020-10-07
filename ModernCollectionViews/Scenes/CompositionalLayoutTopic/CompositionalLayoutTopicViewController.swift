//
//  CompositionalLayoutTopicViewController.swift
//  ModernCollectionViews
//
//  Created by Alonso on 10/4/20.
//

import UIKit

final class CompositionalLayoutTopicViewController: UICollectionViewController {
    
    enum Section {
        case main
    }
    
    private var factory = CompositionalLayoutTopicViewFactory()
    
    // MARK: - Initializers
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "UICollectionViewCompositionalLayout"
        collectionView.backgroundColor = .systemBackground
        
        configureCollectionView()
    }
    
    // MARK: - Private
    
    private func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.register(cellType: NumberedCollectionViewCell.self)
        collectionView.collectionViewLayout = factory.makeCollectionViewLayout()
    }
    
    // MARK: - UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: NumberedCollectionViewCell.self, for: indexPath)
        cell.number = indexPath.row
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return collectionView.dequeueReusableView(with: UICollectionReusableView.self, kind: kind, for: indexPath)
    }

}
