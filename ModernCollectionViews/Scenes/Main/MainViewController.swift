//
//  MainViewController.swift
//  ModernCollectionViews
//
//  Created by Alonso on 10/4/20.
//

import UIKit

final class MainViewController: UICollectionViewController {
    
    private let factory: MainViewFactoryProtocol
    private var dataSource: UICollectionViewDiffableDataSource<MainViewSection, Topic>!
    
    weak var coordinator: MainCoordinatorProtocol?
    
    // MARK: - Initializers
    
    init(factory: MainViewFactoryProtocol) {
        self.factory = factory
        super.init(collectionViewLayout: UICollectionViewLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "What's new in collection views?"
        
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
        var config = UICollectionLayoutListConfiguration(appearance: .grouped)
        config.headerMode = .supplementary
        
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        collectionView.collectionViewLayout = layout
    }
    
    private func configureCollectionViewDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Topic> { cell, indexPath, item in
            var content = UIListContentConfiguration.sidebarCell()
            
            content.text = item.title
            content.secondaryText = item.subtitle
            content.textToSecondaryTextVerticalPadding = 4
            content.secondaryTextProperties.numberOfLines = 0
            
            cell.contentConfiguration = content
        }
        
        dataSource = UICollectionViewDiffableDataSource<MainViewSection, Topic>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: Topic) -> UICollectionViewCell? in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                    for: indexPath, item: identifier)
            cell.accessories = [.disclosureIndicator()]
            return cell
        }
        
        dataSource.supplementaryViewProvider = { (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            let headerView = collectionView.dequeueReusableView(with: SectionHeaderView.self,
                                                                kind: UICollectionView.elementKindSectionHeader,
                                                                for: indexPath)
            headerView.titleLabel.text = self.factory.sections[indexPath.section].title
            return headerView
        }
    }
    
    private func updateUI() {
        let sections = factory.sections
        var snapshot = NSDiffableDataSourceSnapshot<MainViewSection, Topic>()
        snapshot.appendSections(sections)
        sections.forEach { snapshot.appendItems($0.topics, toSection: $0) }
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
    
    // MARK: - UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        guard let topic = factory.topic(for: indexPath.row, at: indexPath.section) else {
            return
        }
        coordinator?.showTopic(topic)
    }

}
