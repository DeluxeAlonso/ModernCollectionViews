//
//  BluetoothSettingsViewController.swift
//  ModernCollectionViews
//
//  Created by Alonso on 2/23/21.
//

import UIKit

class BluetoothSettingsViewController: UICollectionViewController {

    // MARK: - Properties

    private var isShowingAvailableConnections = true

    private var dataSource: UICollectionViewDiffableDataSource<Section, BluetoothItem>!

    weak var coordinator: BluetoothSettingsCoordinatorProtocol?

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
        collectionView.allowsSelection = false
        collectionView.backgroundColor = .systemBackground

        setupNavigationBar()
        setupCollectionView()
    }

    // MARK: - Private

    private func setupNavigationBar() {
        title = "Bluetooth settings"
    }

    private func setupCollectionView() {
        collectionView.collectionViewLayout = makeCollectionViewLayout()

        configureDataSource()
        showAvailableConnections()
    }

    private func makeCollectionViewLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .grouped)
        return UICollectionViewCompositionalLayout.list(using: config)
    }

    private func configureDataSource() {

        // Cell Registration

        let enableBluetoothCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, BluetoothItem> { [weak self] cell, indexPath, item in
            guard let self = self else { fatalError() }

            var contentConfiguration = UIListContentConfiguration.cell()
            contentConfiguration.text = item.title

            let enableWifiSwitch = UISwitch()
            enableWifiSwitch.isOn = self.isShowingAvailableConnections
            enableWifiSwitch.addTarget(self, action: #selector(self.toggleBluetooth), for: .touchUpInside)
            cell.accessories = [
                .customView(configuration: .init(customView: enableWifiSwitch,
                                                 placement: .trailing()))
            ]

            cell.contentConfiguration = contentConfiguration
        }

        let availableConnectionsCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, BluetoothItem> { cell, indexPath, item in

            var contentConfiguration = UIListContentConfiguration.valueCell()
            contentConfiguration.text = item.title
            contentConfiguration.secondaryText = "Not connected"

            cell.contentConfiguration = contentConfiguration
        }

        // Diffable Data Source

        dataSource = UICollectionViewDiffableDataSource<Section, BluetoothItem>(collectionView: collectionView) {
            (collectionView, indexPath, item) -> UICollectionViewCell? in
            switch item {
            case .enable:
                return collectionView.dequeueConfiguredReusableCell(
                    using: enableBluetoothCellRegistration,
                    for: indexPath,
                    item: item)
            case .available:
                return collectionView.dequeueConfiguredReusableCell(
                    using: availableConnectionsCellRegistration,
                    for: indexPath,
                    item: item)
            }
        }
    }

    private func showAvailableConnections() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, BluetoothItem>()
        snapshot.appendSections([.enableBluetooth])
        snapshot.appendItems([.enable], toSection: .enableBluetooth)

        let availableConnections: [BluetoothItem] = [
            .available(title: "Bluetooth Connection 1"),
            .available(title: "Bluetooth Connection 2"),
            .available(title: "Bluetooth Connection 3"),
            .available(title: "Bluetooth Connection 4"),
            .available(title: "Bluetooth Connection 5"),
            .available(title: "Bluetooth Connection 6")
        ]
        snapshot.appendSections([.availableConnections])
        snapshot.appendItems(availableConnections, toSection: .availableConnections)

        dataSource?.apply(snapshot, animatingDifferences: true)
    }

    private func hideAvailableConnections() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, BluetoothItem>()
        snapshot.appendSections([.enableBluetooth, .availableConnections])

        snapshot.appendItems([.enable], toSection: .enableBluetooth)
        snapshot.appendItems([], toSection: .availableConnections)

        dataSource?.apply(snapshot, animatingDifferences: true)
    }


    @objc func toggleBluetooth() {
        isShowingAvailableConnections.toggle()
        isShowingAvailableConnections ? showAvailableConnections() : hideAvailableConnections()
    }

}

// MARK: - Sections

extension BluetoothSettingsViewController {

    enum Section {
        case enableBluetooth
        case availableConnections
    }

}
