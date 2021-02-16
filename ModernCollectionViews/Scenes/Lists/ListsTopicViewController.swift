//
//  ListsTopicViewController.swift
//  ModernCollectionViews
//
//  Created by Alonso on 10/5/20.
//

import UIKit

final class ListsTopicViewController: UICollectionViewController {
    
    enum Section {
        case main
        case secondary
    }
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Int>!

    private var mainItems: [Int] = Array(0..<5)
    private var secondaryItems: [Int] = Array(5..<15)
    
    weak var coordinator: ListTopicCoordinatorProtocol?
    
    // MARK: - Initializers
    
    init() {
        super.init(collectionViewLayout: UICollectionViewLayout())
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

        // Reordering

        dataSource.reorderingHandlers.canReorderItem = { _ in return true }
        dataSource.reorderingHandlers.didReorder = { [weak self] transaction in
            guard let self = self else { return }
            for sectionTransaction in transaction.sectionTransactions {
                let sectionIdentifier = sectionTransaction.sectionIdentifier
                switch sectionIdentifier {
                case .main:
                    self.mainItems = sectionTransaction.finalSnapshot.items
                case .secondary:
                    self.secondaryItems = sectionTransaction.finalSnapshot.items
                }
            }
        }
    }
    
    private func updateUI(animated: Bool = false) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([.main, .secondary])
        snapshot.appendItems(mainItems, toSection: .main)
        snapshot.appendItems(secondaryItems, toSection: .secondary)
        dataSource?.apply(snapshot, animatingDifferences: animated)
    }

}
