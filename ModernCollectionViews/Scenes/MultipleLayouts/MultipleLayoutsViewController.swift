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

    // MARK: - Properties

    private var dataSource: UICollectionViewDiffableDataSource<Int, MultipleItem>!

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
        collectionView.collectionViewLayout = factory.makeCollectionViewLayout()

        configureDataSource(with: .valueCell())
        updateUI()
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

        dataSource = UICollectionViewDiffableDataSource<Int, MultipleItem>(collectionView: collectionView) {
            (collectionView, indexPath, identifier) -> UICollectionViewCell? in
            switch indexPath.section {
            case .zero:
                return collectionView.dequeueConfiguredReusableCell(
                    using: numberedCellRegistration,
                    for: indexPath,
                    item: identifier)
            default:
                return collectionView.dequeueConfiguredReusableCell(using: listCellRegistration, for: indexPath, item: identifier)
            }
        }

    }

    private func updateUI(animated: Bool = false) {
        let sections = Array(0..<10)
        var snapshot = NSDiffableDataSourceSnapshot<Int, MultipleItem>()
        snapshot.appendSections(sections)
        for section in sections {
            let items = Array(0..<5).map { MultipleItem(value: $0) }
            snapshot.appendItems(items, toSection: section)
        }
        dataSource?.apply(snapshot, animatingDifferences: animated)
    }

}


// MARK: - Sections

extension MultipleLayoutsViewController {

    enum Section {
        case main
        case secondary

        var items: [Int] {
            switch self {
            case .main:
                return Array(1..<6)
            case .secondary:
                return Array(6..<15)
            }
        }
    }

}
