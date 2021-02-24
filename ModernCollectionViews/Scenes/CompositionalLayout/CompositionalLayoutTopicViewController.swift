//
//  CompositionalLayoutTopicViewController.swift
//  ModernCollectionViews
//
//  Created by Alonso on 10/4/20.
//

import UIKit

final class CompositionalLayoutTopicViewController: UICollectionViewController {
    
    private let factory: CompositionalLayoutTopicViewFactoryProtocol
    
    weak var coordinator: CompositionalLayoutTopicCoordinatorProtocol?

    private var layouts: [LayoutProtocol] {
        return factory.makeCollectionViewLayouts()
    }

    private var currentLayoutIndex = 0 {
        didSet {
            if currentLayoutIndex > layouts.count - 1 {
                currentLayoutIndex = 0
            }
        }
    }
    
    // MARK: - Initializers
    
    init(factory: CompositionalLayoutTopicViewFactoryProtocol) {
        self.factory = factory
        super.init(collectionViewLayout: UICollectionViewLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Compositional layout"
        collectionView.backgroundColor = .systemBackground

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .fastForward, target: self,
            action: #selector(updateLayout))
        
        configureCollectionView()
    }
    
    // MARK: - Private
    
    private func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.register(cellType: NumberedCollectionViewCell.self)

        let initialLayout = layouts[0]
        navigationItem.prompt = initialLayout.title
        collectionView.collectionViewLayout = initialLayout.makeLayout()
    }

    // MARK: - Selectors

    @objc private func updateLayout() {
        currentLayoutIndex += 1
        let layout = layouts[currentLayoutIndex]
        navigationItem.prompt = layout.title
        collectionView.setCollectionViewLayout(layout.makeLayout(), animated: true)
    }
    
    // MARK: - UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: NumberedCollectionViewCell.self, for: indexPath)
        cell.number = indexPath.row
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return collectionView.dequeueReusableView(with: UICollectionReusableView.self, kind: kind, for: indexPath)
    }

}

// MARK: - Sections

extension CompositionalLayoutTopicViewController {

    enum Section {
        case main
    }

}
