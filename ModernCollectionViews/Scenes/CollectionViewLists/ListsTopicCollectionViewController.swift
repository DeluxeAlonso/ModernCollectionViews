//
//  ListsTopicCollectionViewController.swift
//  ModernCollectionViews
//
//  Created by Alonso on 10/5/20.
//

import UIKit

class ListsTopicCollectionViewController: UICollectionViewController {
    
    enum Section {
        case main
        case secondary
    }
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Int>!
    
    // MARK: - Initializers
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupCollectionView()
    }
    
    // MARK: - Private
    
    private func setupNavigationBar() {
        title = "Lists with collection views"
        navigationItem.rightBarButtonItem = editButtonItem
    }
    
    private func setupCollectionView() {
        collectionView.collectionViewLayout = makeCollectionViewLayout()
        
        configureCollectionViewDataSource()
        updateUI()
    }
    
    private func makeCollectionViewLayout() -> UICollectionViewLayout {
        var config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        
        config.trailingSwipeActionsConfigurationProvider = { indexPath in
          let actionHandler: UIContextualAction.Handler = { action, view, completion in
            completion(true)
          }

          let action = UIContextualAction(style: .normal, title: "Test", handler: actionHandler)
          action.image = UIImage(systemName: "checkmark")
          action.backgroundColor = .systemGreen

          return UISwipeActionsConfiguration(actions: [action])
        }
        
        return UICollectionViewCompositionalLayout.list(using: config)
    }
    
    private func configureCollectionViewDataSource() {
        
        // Cell Registration
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Int> { cell, indexPath, item in
            
            var content = UIListContentConfiguration.valueCell()
            content.text = "Row \(item)"
            content.secondaryText = "Value"
            content.image = UIImage(systemName: "applelogo")
            
            cell.accessories = [.disclosureIndicator(), .delete(displayed: .whenEditing)]
            
            cell.contentConfiguration = content
        }
        
        // Diffable Data Source
        
        dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: collectionView) {
            (collectionView, indexPath, identifier) -> UICollectionViewCell? in
            
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
        }
    }
    
    private func updateUI(animated: Bool = false) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([.main, .secondary])
        snapshot.appendItems(Array(0..<5), toSection: .main)
        snapshot.appendItems(Array(5..<15), toSection: .secondary)
        dataSource?.apply(snapshot, animatingDifferences: animated)
    }

}
