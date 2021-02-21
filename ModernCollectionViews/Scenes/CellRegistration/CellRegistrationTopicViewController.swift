//
//  CellRegistrationTopicViewController.swift
//  ModernCollectionViews
//
//  Created by Alonso on 2/21/21.
//

import UIKit

class CellRegistrationTopicViewController: UICollectionViewController {

    enum Section {
        case main
        case secondary
    }

    private var dataSource: UICollectionViewDiffableDataSource<Section, Int>!

    private var mainItems: [Int] = Array(0..<5)
    private var secondaryItems: [Int] = Array(5..<15)

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
        title = "Cell registration"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action, target: self,
            action: #selector(contentConfigurationUpdate))
    }

    private func setupCollectionView() {
        collectionView.collectionViewLayout = makeCollectionViewLayout()

        configureDataSource(with: .valueCell())
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

    private func configureDataSource(with contentConfiguration: UIListContentConfiguration) {

        // Cell Registration

        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Int> { cell, indexPath, item in

            var contentConfiguration = contentConfiguration
            contentConfiguration.text = "Row \(item)"
            contentConfiguration.secondaryText = "Value"
            contentConfiguration.image = UIImage(systemName: "applelogo")

            cell.accessories = [
                .disclosureIndicator(),
                .delete(displayed: .whenEditing)]

            cell.contentConfiguration = contentConfiguration
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

    // MARK: - Selectors

    @objc func contentConfigurationUpdate() {
        let alertController = UIAlertController(title: nil,
                                                message: "Choose a content configuration mode",
                                                preferredStyle: .actionSheet)

        CellRegistrationTopicContentConfiguration.allCases.forEach { content in
            let action = UIAlertAction(title: content.title, style: .default) { _ in
                self.configureDataSource(with: content.configuration)
                self.updateUI()
            }
            alertController.addAction(action)
        }

        present(alertController, animated: true, completion: nil)
    }

}
