//
//  DiffableDataSourceTopicViewController.swift
//  ModernCollectionViews
//
//  Created by Alonso on 10/4/20.
//

import UIKit

final class DiffableDataSourceTopicViewController: UIViewController {
    
    enum Section {
        case main
    }
    
    private var topicView: DiffableDataSourceTopicView!
    private let factory: DiffableDataSourceTopicViewFactoryProtocol
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Int>!
    private var currentSnapshot: NSDiffableDataSourceSnapshot<Section, Int>!
    
    private let numbers = Array(0..<100)
    
    weak var  coordinator: DiffableDataSourceTopicCoordinatorProtocol?
    
    // MARK: - Initializers
    
    init(factory: DiffableDataSourceTopicViewFactoryProtocol) {
        self.factory = factory
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Lifycycle
    
    override func loadView() {
        topicView = DiffableDataSourceTopicView()
        view = topicView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "UICollectionViewDiffableDataSource"
        configureCollectionView()
        configureSegmentedControl()
    }
    
    private func configureCollectionView() {
        let collectionView = topicView.collectionView
        
        collectionView.register(cellType: NumberedCollectionViewCell.self)
        collectionView.collectionViewLayout = factory.makeCollectionViewLayout()
        
        configureCollectionViewDataSource()
    }
    
    private func configureSegmentedControl() {
        let segmentedControl = topicView.segmentedControl

        let all = UIAction(title: "All") { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.updateUI(with: strongSelf.numbers)
        }
        segmentedControl.setAction(all, forSegmentAt: 0)

        let even = UIAction(title: "Even") { [weak self] _ in self?.updateUI(with: self!.numbers.evenNumbers) }
        segmentedControl.setAction(even, forSegmentAt: 1)

        let odd = UIAction(title: "Odd") { [weak self] _ in self?.updateUI(with: self!.numbers.oddNumbers) }
        segmentedControl.setAction(odd, forSegmentAt: 2)
    }
    
    // MARK: - Diffable Data Source
    
    private func configureCollectionViewDataSource() {
        let collectionView = topicView.collectionView
        
        dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: collectionView) {
            (collectionView, indexPath, number) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(with: NumberedCollectionViewCell.self,
                                                          for: indexPath)
            cell.number = number
            return cell
        }
        updateUI(with: numbers, animated: false)
    }
    
    // MARK: - Diffable Data Source Snapshot
    
    private func updateUI(with numbers: [Int], animated: Bool = true) {
        currentSnapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        currentSnapshot.appendSections([.main])
        currentSnapshot.appendItems(numbers, toSection: .main)
        
        dataSource.apply(currentSnapshot, animatingDifferences: animated)
    }

}
