import Foundation

class SharedPreference {
    static let shared = SharedPreference()
    
    let userDefault = UserDefaults.standard
    
    func getListWallet() -> [WalletModel] {
        let listParam = userDefault.object(forKey: "listWallet") as? [[String: Any]] ?? []
        var listWallet = [WalletModel]()
        listParam.forEach { walletParam in
            listWallet.append(WalletModel(param: walletParam))
        }
        return listWallet
    }
    
    func saveListWallet(listWallet: [WalletModel]) {
        var listParam = [[String: Any]]()
        listWallet.forEach { wallet in
            listParam.append(wallet.toDict())
        }
        userDefault.set(listParam, forKey: "listWallet")
    }
    
    func clearAll() {
        userDefault.set([], forKey: "listWallet")
    }
}
