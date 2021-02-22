//
//  MultipleLayoutsFactory.swift
//  ModernCollectionViews
//
//  Created by Alonso on 2/22/21.
//

import UIKit

protocol MultipleLayoutsFactoryProtocol {

    func makeCollectionViewLayout() -> UICollectionViewLayout

}

struct MultipleLayoutsViewFactory: MultipleLayoutsFactoryProtocol {

    func makeCollectionViewLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionNumber, env -> NSCollectionLayoutSection? in
            switch sectionNumber {
            case .zero:
                return self.gridSection()
            case let number where number % 2 == 0:
                return self.sidebarListSection(env)
            case let number where number % 2 != 0:
                return self.insetGroupedListSection(env)
            default:
                return nil
            }
        }
    }

    private func gridSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(0.3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitem: item, count: 3)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous

        return section
    }

    private func insetGroupedListSection(_ env: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        var config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)

        config.trailingSwipeActionsConfigurationProvider = { indexPath in
            let actionHandler: UIContextualAction.Handler = { action, view, completion in
                completion(true)
            }

            let checkAction = UIContextualAction(style: .normal, title: "Check", handler: actionHandler)
            checkAction.image = UIImage(systemName: "checkmark")
            checkAction.backgroundColor = .systemGreen

            let editAction = UIContextualAction(style: .normal, title: "Edit") { _, _, completion in
                completion(true)
            }
            editAction.image = UIImage(systemName: "pencil.circle")

          return UISwipeActionsConfiguration(actions: [checkAction, editAction])
        }

        return NSCollectionLayoutSection.list(using: config, layoutEnvironment: env)
    }

    private func sidebarListSection(_ env: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let config = UICollectionLayoutListConfiguration(appearance: .sidebarPlain)

        return NSCollectionLayoutSection.list(using: config, layoutEnvironment: env)
    }

}
