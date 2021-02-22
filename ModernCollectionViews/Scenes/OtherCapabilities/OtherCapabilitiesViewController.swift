//
//  OtherCapabilitiesViewController.swift
//  ModernCollectionViews
//
//  Created by Alonso on 2/21/21.
//

import UIKit

class OtherCapabilitiesViewController: UICollectionViewController {

    // MARK: - Properties

    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>!

    private var mainItems: [Item] = Array(0..<5).map { .rowItem(model: RowModel(value: $0)) }
    private var secondaryItems: [Item] = Array(0..<5).map { .rowItem(model: RowModel(value: $0)) }
    private var tertiaryItems: [Item] = Array(0..<5).map { .rowItem(model: RowModel(value: $0)) }

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
        navigationItem.rightBarButtonItem = editButtonItem
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
                .disclosureIndicator(displayed: .whenNotEditing),
                .reorder(displayed: .whenEditing, options: .init( showsVerticalSeparator: true))
            ]

            cell.contentConfiguration = contentConfiguration
        }

        // Diffable Data Source

        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) {
            (collectionView, indexPath, item) -> UICollectionViewCell? in
            switch item {
            case .sectionItem:
                return collectionView.dequeueConfiguredReusableCell(using: headerRegistration,
                                                                    for: indexPath,
                                                                    item: item)
            case .rowItem:
                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                    for: indexPath,
                                                                    item: item)
            }
        }

        // Reordering

        dataSource.reorderingHandlers.canReorderItem = { [weak self] _ in
            guard let self = self else { return false }
            return self.collectionView.isEditing
        }
        dataSource.reorderingHandlers.didReorder = { [weak self] transaction in
            guard let self = self else { return }
            for sectionTransaction in transaction.sectionTransactions {
                let sectionIdentifier = sectionTransaction.sectionIdentifier
                switch sectionIdentifier {
                case .main:
                    self.mainItems = sectionTransaction.finalSnapshot.items
                case .secondary:
                    self.secondaryItems = sectionTransaction.finalSnapshot.items
                case .tertiary:
                    self.tertiaryItems = sectionTransaction.finalSnapshot.items
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
            let headerItem: Item = .sectionItem(model: .init(value: section.rawValue))
            sectionSnapshot.append([headerItem])

            switch section {
            case .main: sectionSnapshot.append(mainItems, to: headerItem)
            case .secondary: sectionSnapshot.append(secondaryItems, to: headerItem)
            case .tertiary: sectionSnapshot.append(tertiaryItems, to: headerItem)
            }
            
            sectionSnapshot.expand([headerItem])
            dataSource.apply(sectionSnapshot, to: section)
        }
    }

}

// MARK: - Sections

extension OtherCapabilitiesViewController {

    enum Section: Int, CaseIterable {
        case main
        case secondary
        case tertiary
    }

}
