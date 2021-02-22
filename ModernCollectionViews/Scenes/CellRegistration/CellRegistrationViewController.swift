//
//  CellRegistrationViewController.swift
//  ModernCollectionViews
//
//  Created by Alonso on 2/21/21.
//

import UIKit

class CellRegistrationViewController: UICollectionViewController {

    lazy private var configBarButtonItem: UIBarButtonItem = {
        let menu = createContentConfigurationMenu()
        return UIBarButtonItem(image: UIImage(systemName: "gear"), menu: menu)
    }()

    // MARK: - Properties

    private var dataSource: UICollectionViewDiffableDataSource<Section, Int>!

    weak var coordinator: CellRegistrationCoordinatorProtocol?

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
        title = "Cell registration"
        navigationItem.rightBarButtonItems = [configBarButtonItem, editButtonItem]
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
                .insert(displayed: .whenEditing),
                .delete(displayed: .whenEditing)]

            cell.contentConfiguration = contentConfiguration
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
        snapshot.appendItems(Section.main.items, toSection: .main)
        snapshot.appendItems(Section.secondary.items, toSection: .secondary)
        dataSource?.apply(snapshot, animatingDifferences: animated)
    }

    private func createContentConfigurationMenu() -> UIMenu {
        var actions: [UIAction] = []
        CellRegistrationContentConfiguration.allCases.forEach { content in
            let action = UIAction(title: content.title,
                                  image: UIImage(systemName: "paperplane")) { [weak self] _ in
                guard let self = self else { return }
                self.configureDataSource(with: content.configuration)
                self.updateUI()
            }
            actions.append(action)
        }
        return UIMenu(title: "Content configuration", children: actions)
    }

}

// MARK: - Sections

extension CellRegistrationViewController {

    enum Section {
        case main
        case secondary

        var items: [Int] {
            switch self {
            case .main:
                return Array(0..<5)
            case .secondary:
                return Array(5..<15)
            }
        }
    }

}
