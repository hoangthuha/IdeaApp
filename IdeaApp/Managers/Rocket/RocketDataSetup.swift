import Foundation
import RocketData

extension DataModelManager {
    static let sharedInstance = DataModelManager(cacheDelegate: RocketDataCacheDelegate())
}

extension DataProvider {
    convenience init() {
        self.init(dataModelManager: DataModelManager.sharedInstance)
    }
}

extension CollectionDataProvider {
    convenience init() {
        self.init(dataModelManager: DataModelManager.sharedInstance)
    }
}
