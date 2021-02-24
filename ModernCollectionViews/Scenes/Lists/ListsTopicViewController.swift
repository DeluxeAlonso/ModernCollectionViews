//
//  ListsTopicViewController.swift
//  ModernCollectionViews
//
//  Created by Alonso on 10/5/20.
//

import UIKit

final class ListsTopicViewController: UICollectionViewController {

    typealias Appearance = UICollectionLayoutListConfiguration.Appearance

    private var appearances: [Appearance] = [.grouped, .insetGrouped, .plain]

    private var currentAppearanceIndex = 0 {
        didSet {
            if currentAppearanceIndex > appearances.count - 1 {
                currentAppearanceIndex = 0
            }
        }
    }

    private var currentAppearance: Appearance {
        appearances[currentAppearanceIndex]
    }
    
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
        collectionView.backgroundColor = .systemBackground
        
        setupNavigationBar()
        setupCollectionView()
    }
    
    // MARK: - Private
    
    private func setupNavigationBar() {
        title = "Lists"
        navigationItem.prompt = currentAppearance.title
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .fastForward, target: self,
            action: #selector(updateContentAppearance))
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.register(cellType: UICollectionViewListCell.self)

        collectionView.collectionViewLayout = makeCollectionViewLayout(using: currentAppearance)
    }
    
    private func makeCollectionViewLayout(using appearance: UICollectionLayoutListConfiguration.Appearance) -> UICollectionViewLayout {
        let configuration = UICollectionLayoutListConfiguration(appearance: appearance)
        return UICollectionViewCompositionalLayout.list(using: configuration)
    }

    // MARK: - Selectors

    @objc private func updateContentAppearance() {
        currentAppearanceIndex += 1

        let layout = self.makeCollectionViewLayout(using: currentAppearance)
        collectionView.setCollectionViewLayout(layout, animated: true) { [weak self] _ in
            guard let self = self else { return }
            self.navigationItem.prompt = self.currentAppearance.title
        }
    }

}

// MARK: - UICollectionViewDataSource

extension ListsTopicViewController {

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = Section.allCases[section]
        return section.items.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: UICollectionViewListCell.self,
                                                      for: indexPath)

        let section = Section.allCases[indexPath.section]
        let item = section.items[indexPath.row]

        let tableviewCell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
        tableviewCell.textLabel?.text = "Row \(item)"
        tableviewCell.detailTextLabel?.text = "Value"
        tableviewCell.imageView?.image = UIImage(systemName: "applelogo")

        var contentConfiguration = UIListContentConfiguration.valueCell()
        contentConfiguration.text = "Row \(item)"
        contentConfiguration.secondaryText = "Value"
        contentConfiguration.image = UIImage(systemName: "applelogo")

        cell.contentConfiguration = contentConfiguration

        return cell
    }

}

// MARK: - Sections

extension ListsTopicViewController {

    enum Section: CaseIterable {
        case main
        case secondary

        var items: [Int] {
            switch self {
            case .main:
                return Array(0..<10)
            case .secondary:
                return Array(11..<40)
            }
        }
    }

}
