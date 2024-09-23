import Foundation

class WalletModelToFlutter {
    var walletName = ""
    var walletAddress = ""
    
    init(walletName: String, walletAddress: String) {
        self.walletName = walletName
        self.walletAddress = walletAddress
    }
    
    func toDict() -> [String: Any] {
        return [
            "walletName": walletName,
            "walletAddress": walletAddress,
        ]
    }
}

class WalletModel {
    var walletName = ""
    var walletAddress = ""
    var walletIndex = 0
    var privateKey = ""
    var coinType = 0
    var isSelectWallet = false
    
    init(walletName: String, walletAddress: String, walletIndex: Int, coinType: Int, privateKey: String, isSelectWallet: Bool = false) {
        self.walletName = walletName
        self.walletAddress = walletAddress
        self.walletIndex = walletIndex
        self.coinType = coinType
        self.privateKey = privateKey
        self.isSelectWallet = isSelectWallet
    }
    
    init(param: [String: Any]) {
        self.walletName = param["walletName"] as! String
        self.walletAddress = param["walletAddress"] as! String
        self.walletIndex = param["walletIndex"] as! Int
        self.coinType = param["coinType"] as! Int
        self.privateKey = param["privateKey"] as! String
        self.isSelectWallet = param["isSelectWallet"] as! Bool
    }
    
    func toDict() -> [String: Any] {
        return [
            "walletName": walletName,
            "walletAddress": walletAddress,
            "walletIndex": walletIndex,
            "coinType": coinType,
            "privateKey": privateKey,
            "isSelectWallet": isSelectWallet,
        ]
    }
    
    func toWalletParam() -> [String: Any] {
        return [
            "walletName": walletName,
            "walletAddress": walletAddress,
            "isSelectWallet": isSelectWallet,
        ]
    }
}
