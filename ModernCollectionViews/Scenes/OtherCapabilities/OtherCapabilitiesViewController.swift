//
//  OtherCapabilitiesViewController.swift
//  ModernCollectionViews
//
//  Created by Alonso on 2/21/21.
//

import UIKit

struct Item: Hashable {

    let identifier = UUID()
    let value: Int

    init(value: Int) {
        self.value = value
    }

}

class OtherCapabilitiesViewController: UICollectionViewController {

    // MARK: - Properties

    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>!

    private var mainItems: [Item] = Array(0..<5).map { Item(value: $0) }
    private var secondaryItems: [Item] = Array(0..<5).map { Item(value: $0) }

    weak var coordinator: OtherCapabilitiesCoordinatorProtocol?

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
        collectionView.backgroundColor = .systemBackground

        setupNavigationBar()
        setupCollectionView()
    }

    // MARK: - Private

    private func setupNavigationBar() {
        title = "Other capabilities"
    }

    private func setupCollectionView() {
        collectionView.collectionViewLayout = makeCollectionViewLayout()

        configureDataSource()
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

    private func configureDataSource() {

        // Header Registration

        let headerRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Item> { cell, indexPath, item in
            var content = cell.defaultContentConfiguration()
            content.text = "Section \(item.value)"
            cell.contentConfiguration = content

            cell.accessories = [
                .outlineDisclosure(displayed: .always, options: .init(style: .header))
            ]
        }

        // Cell Registration

        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Item> { cell, indexPath, item in

            var contentConfiguration = UIListContentConfiguration.valueCell()
            contentConfiguration.text = "Row \(item.value)"
            contentConfiguration.secondaryText = "Value"
            contentConfiguration.image = UIImage(systemName: "applelogo")

            cell.accessories = [
                .reorder(displayed: .always, options: .init( showsVerticalSeparator: true))
            ]

            cell.contentConfiguration = contentConfiguration
        }

        // Diffable Data Source

        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) {
            (collectionView, indexPath, item) -> UICollectionViewCell? in
            if indexPath.item == 0 {
                return collectionView.dequeueConfiguredReusableCell(using: headerRegistration,
                                                                    for: indexPath,
                                                                    item: item)
            } else {
                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                    for: indexPath,
                                                                    item: item)
            }
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
        let sections = Section.allCases
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(sections)
        dataSource?.apply(snapshot, animatingDifferences: animated)

        for section in sections {
            var sectionSnapshot = NSDiffableDataSourceSectionSnapshot<Item>()
            let headerItem = Item(value: section.rawValue)
            sectionSnapshot.append([headerItem])
            let items = Array(0..<5).map { Item(value: $0) }
            sectionSnapshot.append(items, to: headerItem)
            sectionSnapshot.expand([headerItem])
            dataSource.apply(sectionSnapshot, to: section)
        }
        //        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        //        snapshot.appendSections([.main, .secondary])
        //        snapshot.appendItems(mainItems, toSection: .main)
        //        snapshot.appendItems(secondaryItems, toSection: .secondary)
        //        dataSource?.apply(snapshot, animatingDifferences: animated)
    }

}

// MARK: - Sections

extension OtherCapabilitiesViewController {

    enum Section: Int, CaseIterable {
        case main
        case secondary
    }

}
