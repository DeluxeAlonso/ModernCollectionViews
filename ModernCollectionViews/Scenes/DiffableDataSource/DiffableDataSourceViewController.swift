//
//  DiffableDataSourceViewController.swift
//  ModernCollectionViews
//
//  Created by Alonso on 2/23/21.
//

import UIKit

class DiffableDataSourceViewController: UICollectionViewController {

    private var dataSource: UICollectionViewDiffableDataSource<Section, String>!

    weak var coordinator: DiffableDataSourceCoordinatorProtocol?

    // MARK: - Initializers

    init() {
        super.init(collectionViewLayout: UICollectionViewLayout())
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "UICollectionViewDiffableDataSource"

        configureCollectionView()
    }

    // MARK: - Private

    private func configureCollectionView() {
        collectionView.register(viewType: SectionHeaderView.self, kind: UICollectionView.elementKindSectionHeader)

        configureCollectionViewLayout()
        configureCollectionViewDataSource()
        updateUI()
    }

    private func configureCollectionViewLayout() {
        let config = UICollectionLayoutListConfiguration(appearance: .grouped)
        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout.list(using: config)
    }

    private func configureCollectionViewDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, String> { cell, indexPath, item in
            var content = UIListContentConfiguration.cell()
            content.text = item

            cell.accessories = [.disclosureIndicator()]
            cell.contentConfiguration = content
        }

        dataSource = UICollectionViewDiffableDataSource<Section, String>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: String) -> UICollectionViewCell? in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                    for: indexPath,
                                                                    item: identifier)
            return cell
        }
    }

    private func updateUI() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.main])

        let items = ["Bluetooth settings", "Odd/Even numbers"]
        snapshot.appendItems(items, toSection: .main)
        dataSource?.apply(snapshot, animatingDifferences: false)
    }

    // MARK: - UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if indexPath.row == .zero {
            coordinator?.showBluetoothSettings()
        } else if indexPath.row == 1 {
            coordinator?.showOddEvenNumbers()
        }
    }

}

// MARK: - Sections

extension DiffableDataSourceViewController {

    enum Section {
        case main
    }

}

