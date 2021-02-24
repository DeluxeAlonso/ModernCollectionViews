//
//  OddEvenNumbersViewController.swift
//  ModernCollectionViews
//
//  Created by Alonso on 10/4/20.
//

import UIKit
import Combine

final class OddEvenNumbersViewController: UIViewController {
    
    enum Section {
        case main
    }
    
    private var topicView: OddEvenNumbersView!
    private let viewModel: OddEvenNumbersViewModelProtocol
    private let factory: OddEvenNumbersViewFactoryProtocol
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Int>!
    private var currentSnapshot: NSDiffableDataSourceSnapshot<Section, Int>!
    
    private var cancellables: Set<AnyCancellable> = []
    
    weak var coordinator: OddEvenNumbersCoordinatorProtocol?
    
    // MARK: - Initializers

    init(viewModel: OddEvenNumbersViewModelProtocol,
         factory: OddEvenNumbersViewFactoryProtocol) {
        self.viewModel = viewModel
        self.factory = factory
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Lifycycle
    
    override func loadView() {
        topicView = OddEvenNumbersView()
        view = topicView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Odd/Even numbers"
        
        configureUI()
        configureBindings()
        
        viewModel.selectAllNumbers()
    }
    
    private func configureUI() {
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

        let all = UIAction(title: "All") { [weak self] _ in self?.viewModel.selectAllNumbers() }
        segmentedControl.setAction(all, forSegmentAt: 0)

        let even = UIAction(title: "Even") { [weak self] _ in self?.viewModel.selectEvenNumbers() }
        segmentedControl.setAction(even, forSegmentAt: 1)

        let odd = UIAction(title: "Odd") { [weak self] _ in self?.viewModel.selectOddNumbers() }
        segmentedControl.setAction(odd, forSegmentAt: 2)
    }
    
    // MARK: - Reactive Behaviour
    
    private func configureBindings() {
        viewModel.numbersPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] (numbers) in
                self?.updateUI(with: numbers)
            }.store(in: &cancellables)
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
    }
    
    // MARK: - Diffable Data Source Snapshot
    
    private func updateUI(with numbers: [Int], animated: Bool = true) {
        currentSnapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        currentSnapshot.appendSections([.main])
        currentSnapshot.appendItems(numbers, toSection: .main)
        
        dataSource.apply(currentSnapshot, animatingDifferences: animated)
    }

}
