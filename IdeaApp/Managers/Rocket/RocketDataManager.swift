
//import Foundation
//import RocketData
//
//enum RelationKeys {
//    case feed(Int)
//    case user(Int)
//}
//
//enum ChangeAction {
//    case delete
//    case append
//    case update
//}
//
//class RocketDataManager {
//    static let shared = RocketDataManager()
//
//    func postNotificationForNewModel<T: SimpleModel>(model: T, key: RelationKeys, action: ChangeAction) {
//        switch key {
//        case .user(let userId):
//            let followeeDataProvider = CollectionDataProvider<T>()
//            followeeDataProvider.fetchDataFromCache(withCacheKey: CollectionCacheKey.followees(userId).cacheKey(), completion: { (_, _) in
//                switch action {
//                case .append:
//                    if let index = followeeDataProvider.data.index(where: { $0.modelIdentifier == model.modelIdentifier }) {
//                        followeeDataProvider.update(model, at: index)
//                    } else {
//                        followeeDataProvider.append([model])
//                    }
//                case .delete:
//                    if let index = followeeDataProvider.data.index(where: { $0.modelIdentifier == model.modelIdentifier }) {
//                        followeeDataProvider.remove(at: index)
//                    } else {
//                        break
//                    }
//                case .update:
//                    followeeDataProvider.dataModelManager.updateModel(model)
//                }
//            })
//        default:
//            break
//        }
//    }
//}

