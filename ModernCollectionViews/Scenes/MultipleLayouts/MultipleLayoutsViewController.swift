//
//  MultipleLayoutsViewController.swift
//  ModernCollectionViews
//
//  Created by Alonso on 2/22/21.
//

import UIKit

struct MultipleItem: Hashable {

    private let identifier: UUID = UUID()
    let value: Int

}

class MultipleLayoutsViewController: UICollectionViewController {

    var sections: [SectionItem] = [SectionItem(type: .orthogonal), SectionItem(type: .list), SectionItem(type: .list)]

    // MARK: - Properties

    private var dataSource: UICollectionViewDiffableDataSource<SectionItem, MultipleItem>!

    private var factory: MultipleLayoutsFactoryProtocol
    weak var coordinator: MultipleLayoutsCoordinatorProtocol?

    // MARK: - Initializers

    init(factory: MultipleLayoutsFactoryProtocol) {
        self.factory = factory
        super.init(collectionViewLayout: UICollectionViewLayout())
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        title = "Multiple layouts"
    }

    private func setupCollectionView() {
        collectionView.collectionViewLayout = makeCollectionViewLayout()

        configureDataSource(with: .valueCell())
        updateUI()
    }

    private func makeCollectionViewLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionNumber, env -> NSCollectionLayoutSection? in
            switch self.sections[sectionNumber].type {
            case .orthogonal:
                return self.factory.gridSection()
            case .list:
                return self.factory.groupedListSection(env)
            }
        }
    }

    private func configureDataSource(with contentConfiguration: UIListContentConfiguration) {

        // Cell Registration

        let numberedCellRegistration = UICollectionView.CellRegistration<NumberedCollectionViewCell, MultipleItem> { cell, indexPath, item in
            cell.number = item.value
            cell.backgroundColor = .cyan
        }

        let listCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, MultipleItem> { cell, indexPath, item in

            var contentConfiguration = contentConfiguration
            contentConfiguration.text = "Row \(item.value)"
            contentConfiguration.secondaryText = "Value"
            contentConfiguration.image = UIImage(systemName: "applelogo")

            cell.accessories = [
                .disclosureIndicator(),
                .insert(displayed: .whenEditing),
                .delete(displayed: .whenEditing)]

            cell.contentConfiguration = contentConfiguration
        }

        // Diffable Data Source

        dataSource = UICollectionViewDiffableDataSource<SectionItem, MultipleItem>(collectionView: collectionView) {
            (collectionView, indexPath, identifier) -> UICollectionViewCell? in
            switch self.sections[indexPath.section].type {
            case .orthogonal:
                return collectionView.dequeueConfiguredReusableCell(
                    using: numberedCellRegistration,
                    for: indexPath,
                    item: identifier)
            case .list:
                return collectionView.dequeueConfiguredReusableCell(using: listCellRegistration, for: indexPath, item: identifier)
            }
        }

    }

    private func updateUI(animated: Bool = false) {
        var snapshot = NSDiffableDataSourceSnapshot<SectionItem, MultipleItem>()
        snapshot.appendSections(sections)
        for section in sections {
            let items = Array(0..<15).map { MultipleItem(value: $0) }
            snapshot.appendItems(items, toSection: section)
        }
        dataSource?.apply(snapshot, animatingDifferences: animated)
    }

}

// MARK: - Sections

extension MultipleLayoutsViewController {

    struct SectionItem: Hashable {
        private let uuid = UUID()
        let type: SectionType
    }

    enum SectionType: Hashable {
        case orthogonal
        case list
    }

}
