import UIKit
import Flutter
import WalletCore
import BigInt

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    var chatChanel: FlutterMethodChannel?
       
       private let TYPE_BSC = "BINANCE"
       private let TYPE_POLYGON = "POLYGON"
       private let TYPE_NEAR = "NEAR"
       private let TYPE_WALLET_SEED_PHRASE = "SEED_PHRASE"
       private let TYPE_WALLET_PRIVATE_KEY = "PRIVATE_KEY"
       
       override func application(
           _ application: UIApplication,
           didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
       ) -> Bool {
           
           let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
           let chatChanel = FlutterMethodChannel(name: "flutter/trust_wallet", binaryMessenger: controller.binaryMessenger)
           chatChanel.setMethodCallHandler({
               (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
               self.handleMethodCall(call: call, result : result)
           })
           
           self.chatChanel = chatChanel
           
           GeneratedPluginRegistrant.register(with: self)
           return super.application(application, didFinishLaunchingWithOptions: launchOptions)
       }
}
extension AppDelegate {
    
    private func handleMethodCall(call: FlutterMethodCall, result: FlutterResult) {
        guard self.chatChanel != nil else {return}
        
        if call.method == "getListWallet" {
            if let arguments = call.arguments as? [String: Any], let chainType = arguments["chainType"] as? String {
                result(getListWallet(chainType: chainType))
            }
        }
        
        if call.method == "importWallet" {
            if let arguments = call.arguments as? [String: Any], let type = arguments["type"] as? String, let content = arguments["content"] as? String, let walletName = arguments["walletName"] as? String {
                result(importWallet(type: type, content: content,walletName: walletName))
            }
        }
        
        if call.method == "chooseWallet" {
            if let arguments = call.arguments as? [String: Any], let walletName = arguments["walletName"] as? String {
                result(chooseWallet(walletName: walletName))
            }
        }
        
        if call.method == "generateWallet" {
            result(generateWallet())
        }
        
        if call.method == "eraseWallet" {
            if let arguments = call.arguments as? [String: Any], let walletName = arguments["walletName"] as? String {
                result(deleteWallet(walletName: walletName))
            }
        }
        
        if call.method == "updateWalletName" {
            if let arguments = call.arguments as? [String: Any], let walletNameOld = arguments["walletNameOld"] as? String, let walletNameNew = arguments["walletNameNew"] as? String {
                result(updateWalletName(newName: walletNameNew, oldName: walletNameOld))
            }
        }
        
        if call.method == "exportWallet" {
            if let arguments = call.arguments as? [String: Any], let walletAddress = arguments["walletAddress"] as? String {
                result(exportWallet(address: walletAddress))
            }
        }
        
        if call.method == "deleteAllWallet" {
            result(deleteWalletByLogout())
        }
        
        if call.method == "signTransactionToken" {
            if let arguments = call.arguments as? [String: Any], let walletAddress = arguments["walletAddress"] as? String, let toAddress = arguments["toAddress"] as? String, let tokenAddress = arguments["tokenAddress"] as? String, let nonce = arguments["nonce"] as? String, let chainId = arguments["chainId"] as? String, let chainType = arguments["chainType"] as? String, let gasPrice = arguments["gasPrice"] as? String, let gasLimit = arguments["gasLimit"] as? String, let amount = arguments["amount"] as? String, let gasFee = arguments["gasFee"] as? String, let symbol = arguments["symbol"] as? String {
                result(signTransactionToken(walletAddress: walletAddress, tokenAddress: tokenAddress, toAddress: toAddress, nonce: nonce, chainId: chainId, gasPrice: gasPrice, gasLimit: gasLimit, amount: amount, gasFee: gasFee, symbol: symbol, chainType: chainType))
            }
        }
        
        if call.method == "signTransactionNearToken" {
            if let arguments = call.arguments as? [String: Any], let walletAddress = arguments["walletAddress"] as? String, let signerId = arguments["signerId"] as? String, let receiverId = arguments["receiverId"] as? String, let nonce = arguments["nonce"] as? String, let blockHash = arguments["blockHash"] as? String, let deposit = arguments["deposit"] as? String{
                result(signTransactionNearToken(walletAddress: walletAddress, signerId: signerId, receiverId: receiverId, nonce: nonce,blockHash: blockHash, deposit: deposit))
            }
        }

        if call.method == "signTransferSignNearOtherToken" {
            if let arguments = call.arguments as? [String: Any], let walletAddress = arguments["walletAddress"] as? String, let signerId = arguments["signerId"] as? String, let receiverId = arguments["receiverId"] as? String, let nonce = arguments["nonce"] as? String, let blockHash = arguments["blockHash"] as? String, let args = arguments["args"] as? String, let methodName = arguments["methodName"] as? String {
                result(signTransactionNearOtherToken(walletAddress: walletAddress, signerId: signerId, receiverId: receiverId, nonce: nonce,blockHash: blockHash, args: args, methodName: methodName))
            }
        }
        result(FlutterMethodNotImplemented)
    }

    private func getListWallet(chainType: String) -> [[String: Any]] {
        var coinType = CoinType.smartChain
        switch (chainType.uppercased()) {
        case "BINANCE":
            coinType = .smartChain
            break
        case "POLYGON":
            coinType = .polygon
            break
        case "NEAR":
            coinType = .near
            break
        default:
            coinType = .smartChain
        }
        var listParam = [[String: Any]]()
        SharedPreference.shared.getListWallet().sorted{$0.walletIndex < $1.walletIndex}.forEach { walletModel in
            if (coinType.rawValue == walletModel.coinType) {
                var data = [String: Any]()
                data["walletName"] = walletModel.walletName
                data["walletAddress"] = walletModel.walletAddress
                data["indexWallet"] = walletModel.walletIndex
                data["isSelectWallet"] = walletModel.isSelectWallet
                listParam.append(data)
            }
        }
        chatChanel?.invokeMethod("getListWalletCallBack", arguments: listParam)
        return listParam
    }

    private func generateWallet() -> [[String: Any]]{
        var listParam = [[String: Any]]()
        var hasMapBSC: [String: Any] = [:]
        var listWallet = [WalletModel]()
        listWallet.append(contentsOf: SharedPreference.shared.getListWallet())
        let sizeListWallet = listWallet.isEmpty ? 0 : listWallet.count / 3
        let indexWallet = sizeListWallet + 1

        let walletName = "".handleNameWallet(listWallet: listWallet)
        let wallet = HDWallet(strength: 128, passphrase: "")
        let seedPhrase = wallet?.mnemonic
        hasMapBSC["walletName"] = walletName
        hasMapBSC["walletAddress"] = wallet?.getAddressForCoin(coin: .smartChain)
        hasMapBSC["seedPhrase"] = seedPhrase
        listParam.append(hasMapBSC)


        chatChanel?.invokeMethod("generateWalletCallBack", arguments: listParam)
        return listParam
    }

    private func importWallet(type: String, content: String, walletName: String) -> [String: Any] {
        var hasMap: [String: Any] = [:]
        var listWallet = [WalletModel]()
        listWallet.append(contentsOf: SharedPreference.shared.getListWallet())
        let sizeListWallet = listWallet.isEmpty ? 0 : listWallet.count / 3
        let walletSmartChainModel = walletSeedPhraseByCoinType(typeWallet: type, coinType: CoinType.smartChain, content: content, sizeListWallet: sizeListWallet,walletName: walletName,listwallet: listWallet)
        let walletPolygonModel = walletSeedPhraseByCoinType(typeWallet: type, coinType: CoinType.polygon, content: content, sizeListWallet: sizeListWallet,walletName: walletName,listwallet: listWallet)
        let walletNearModel = walletSeedPhraseByCoinType(typeWallet: type, coinType: CoinType.near, content: content, sizeListWallet: sizeListWallet,walletName: walletName,listwallet: listWallet)
        guard let walletSmartChainModel = walletSmartChainModel, let walletPolygonModel = walletPolygonModel, let walletNearModel = walletNearModel else {
            hasMap["code"] = 402
            chatChanel?.invokeMethod("importWalletCallBack", arguments: hasMap)
            return hasMap
        }
        let isDuplicateWallet = (listWallet.first(where: {$0.walletAddress == walletSmartChainModel.walletAddress || $0.walletAddress == walletPolygonModel.walletAddress || $0.walletAddress == walletNearModel.walletAddress})) == nil
        if (isDuplicateWallet) {
            listWallet.append(walletSmartChainModel)
            listWallet.append(walletPolygonModel)
            listWallet.append(walletNearModel)
            for it in listWallet {
                it.isSelectWallet = it.walletAddress == walletSmartChainModel.walletAddress || it.walletAddress == walletPolygonModel.walletAddress || it.walletAddress == walletNearModel.walletAddress
            }
            SharedPreference.shared.saveListWallet(listWallet: listWallet)
            var listWalletToFlutter = [WalletModelToFlutter]()
            listWalletToFlutter.append(WalletModelToFlutter(walletName: walletSmartChainModel.walletName, walletAddress: walletSmartChainModel.walletAddress))
            listWalletToFlutter.append(WalletModelToFlutter(walletName: walletPolygonModel.walletName, walletAddress: walletPolygonModel.walletAddress))
            listWalletToFlutter.append(WalletModelToFlutter(walletName: walletNearModel.walletName, walletAddress: walletNearModel.walletAddress))
            var listFlutterWalletParam = [[String: Any]]()
            listWalletToFlutter.forEach { walletModel in
                listFlutterWalletParam.append(walletModel.toDict())
            }
            hasMap["code"] = 200
            hasMap["data"] = listFlutterWalletParam
            chatChanel?.invokeMethod("importWalletCallBack", arguments: hasMap)
        } else {
            hasMap["code"] = 401
            hasMap["data"] = ""
            chatChanel?.invokeMethod("importWalletCallBack", arguments: hasMap)
        }
        return hasMap
    }

    private func walletSeedPhraseByCoinType(typeWallet: String, coinType: CoinType, content: String, sizeListWallet: Int,walletName: String, listwallet: [WalletModel]) -> WalletModel? {
        let indexWallet = sizeListWallet + 1
        let walletName = walletName != "" ? walletName : "".handleNameWallet(listWallet: listwallet)
        switch (typeWallet) {
        case TYPE_WALLET_SEED_PHRASE:
            let wallet = HDWallet(mnemonic: content, passphrase: "")
            if let wallet = wallet {
                let walletAddress = wallet.getAddressForCoin(coin: coinType)
                let privateKey = (wallet.getKeyForCoin(coin: coinType).data).hexEncodedString()
                return WalletModel(walletName: walletName, walletAddress: walletAddress, walletIndex: indexWallet, coinType: Int(coinType.rawValue), privateKey: privateKey)
            } else {
                return nil
            }
        case TYPE_WALLET_PRIVATE_KEY:
            if let privateKeyData = content.hexadecimal {
                let privateKey = PrivateKey(data: privateKeyData)
                if let privKey = privateKey {
                    let publicKey = coinType != CoinType.near ? privKey.getPublicKeySecp256k1(compressed: false) : privKey.getPublicKeyEd25519()
                    let address = AnyAddress(publicKey: publicKey, coin: coinType)
                    return WalletModel(walletName: walletName, walletAddress: "\(address)", walletIndex: indexWallet, coinType: Int(coinType.rawValue), privateKey: content)
                } else {
                    return nil
                }
            } else {
                return nil
            }
        default:
            return nil
        }
        return nil
    }

    func chooseWallet(walletName: String) -> [String: Any] {
        var hasMap: [String: Any] = [:]
        var listWallet = [WalletModel]()
        listWallet.append(contentsOf: SharedPreference.shared.getListWallet())
        for wallet in listWallet {
            wallet.isSelectWallet = wallet.walletName == walletName
        }
        SharedPreference.shared.saveListWallet(listWallet: listWallet)
        hasMap["isSuccess"] = true
        chatChanel?.invokeMethod("chooseWalletCallBack", arguments: hasMap)
        return hasMap
    }

    func deleteWallet(walletName: String) -> [String: Any] {
        var hasMap: [String: Any] = [:]
        var listWallet = [WalletModel]()
        var listWalletToFlutter = [WalletModelToFlutter]()
        listWallet.append(contentsOf: SharedPreference.shared.getListWallet())
        while(listWallet.firstIndex(where: {$0.walletName == walletName}) != nil){
            if let index = listWallet.firstIndex(where: {$0.walletName == walletName}) {
                listWalletToFlutter.append(WalletModelToFlutter(walletName: listWallet[index].walletName, walletAddress: listWallet[index].walletAddress))
                listWallet.remove(at: index)
            }
        }
        SharedPreference.shared.saveListWallet(listWallet: listWallet)

        var listFlutterWalletParam = [[String: Any]]()
        listWalletToFlutter.forEach { walletModel in
            listFlutterWalletParam.append(walletModel.toDict())
        }
        hasMap["isSuccess"] = true
        hasMap["dataDelete"] = listFlutterWalletParam
        chatChanel?.invokeMethod("eraseWalletCallBack", arguments: hasMap)
        return hasMap
    }

    func updateWalletName(newName: String, oldName: String) -> [String: Any] {
        var hasMap: [String: Any] = [:]
        var listWallet = [WalletModel]()
        listWallet.append(contentsOf: SharedPreference.shared.getListWallet())
        var isSuccess = false
        for wallet in listWallet {
            if (wallet.walletName.trimmingCharacters(in: .whitespacesAndNewlines) == oldName.trimmingCharacters(in: .whitespacesAndNewlines)) {
                wallet.walletName = newName.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }
        SharedPreference.shared.saveListWallet(listWallet: listWallet)
        isSuccess = true
        hasMap["isSuccess"] = isSuccess
        chatChanel?.invokeMethod("updateWalletNameCallBack", arguments: hasMap)
        return hasMap
    }

    func exportWallet(address: String) -> [String: Any] {
        var hasMap: [String: Any] = [:]
        let list = SharedPreference.shared.getListWallet()
        for wallet in list {
            if (wallet.walletAddress == address) {
                hasMap["walletAddress"] = wallet.walletAddress
                hasMap["privateKey"] = wallet.privateKey
            }
        }
        chatChanel?.invokeMethod("exportWalletCallBack", arguments: hasMap)
        return hasMap
    }

    func deleteWalletByLogout() -> [String: Any] {
        SharedPreference.shared.clearAll()
        let hasMap = ["isSuccess": true]
        chatChanel?.invokeMethod("deleteAllWalletCallBack", arguments: hasMap)
        return hasMap
    }

    private func signTransactionToken(walletAddress: String,
                                      tokenAddress: String,
                                      toAddress: String,
                                      nonce: String,
                                      chainId: String,
                                      gasPrice: String,
                                      gasLimit: String,
                                      amount: String, gasFee: String, symbol: String, chainType: String) -> [String: Any] {
        let isNativeCoin = symbol.uppercased() == "BNB" || symbol.uppercased() == "MATIC"
        var coinType = CoinType.smartChain
        switch (chainType.uppercased()) {
        case "BINANCE":
            coinType = .smartChain
            break
        case "POLYGON":
            coinType = .polygon
            break
        case "NEAR":
            coinType = .near
            break
        default:
            coinType = .smartChain
        }
        var param = [String: Any]()
        let walletModel = SharedPreference.shared.getListWallet().first(where: {$0.walletAddress == walletAddress})
        if let walletModel = walletModel, !walletModel.privateKey.isEmpty {
            if let privateKey = PrivateKey(data: walletModel.privateKey.hexadecimal!) {
                let nativeTransaction = EthereumTransaction.Transfer.with {
                    $0.amount = BigInt(amount.handleAmount(decimal: 18))!.serialize()
                }
                let trc20Transaction = EthereumTransaction.ERC20Transfer.with {
                    $0.to = toAddress
                    $0.amount = BigInt(amount.handleAmount(decimal: 18))!.serialize()
                }
                let signerInput = isNativeCoin ? EthereumSigningInput.with {
                    $0.nonce = BigInt(nonce)!.serialize()
                    $0.chainID = BigInt(chainId)!.serialize()
                    $0.gasPrice = BigInt(gasPrice.handleAmount(decimal: 9))!.serialize()
                    $0.gasLimit = BigInt(gasLimit)!.serialize()
                    $0.toAddress = isNativeCoin ? toAddress : tokenAddress
                    $0.privateKey = privateKey.data
                    $0.transaction = EthereumTransaction.with {
                        $0.transfer = nativeTransaction
                    }
                } : EthereumSigningInput.with {
                    $0.nonce = BigInt(nonce)!.serialize()
                    $0.chainID = BigInt(chainId)!.serialize()
                    $0.gasPrice = BigInt(gasPrice.handleAmount(decimal: 9))!.serialize()
                    $0.gasLimit = BigInt(gasLimit)!.serialize()
                    $0.toAddress = isNativeCoin ? toAddress : tokenAddress
                    $0.privateKey = privateKey.data
                    $0.transaction = EthereumTransaction.with {
                        $0.erc20Transfer = trc20Transaction
                    }
                }
                let output: EthereumSigningOutput = AnySigner.sign(input: signerInput, coin: coinType)
                let value = output.encoded.hexString
                param["isSuccess"] = true
                param["signedTransaction"] = value
            } else {
                param["isSuccess"] = false
                param["signedTransaction"] = ""
            }
        } else {
            param["isSuccess"] = false
            param["signedTransaction"] = ""
        }
        param["walletAddress"] = walletAddress
        param["toAddress"] = toAddress
        param["tokenAddress"] = tokenAddress
        param["nonce"] = nonce
        param["chainId"] = chainId
        param["chainType"] = chainType
        param["gasPrice"] = gasPrice
        param["gasLimit"] = gasLimit
        param["gasFee"] = gasFee
        param["amount"] = amount
        param["symbol"] = symbol
        chatChanel?.invokeMethod("signTransactionTokenCallBack", arguments: param)
        return param
    }

    private func handleNearAmount(deposit: String) -> [UInt8] {
        var bytes = [UInt8](BigInt(deposit)!.serialize())
        var reverse: [UInt8] = bytes.reversed()
        repeat {
            reverse.append(0)
        } while reverse.count < 16
        return reverse
    }

    private func signTransactionNearToken(walletAddress: String,
                                      signerId: String,
                                      receiverId: String,
                                      nonce: String,
                                      blockHash: String,
                                      deposit: String) -> [String: Any] {
        let coinType = CoinType.near
        var param = [String: Any]()
        let walletModel = SharedPreference.shared.getListWallet().first(where: {$0.walletAddress == walletAddress})
        if let walletModel = walletModel, !walletModel.privateKey.isEmpty {
            if let privateKey = PrivateKey(data: walletModel.privateKey.hexadecimal!) {

                let transaction = NEARTransfer.with{
                    $0.deposit = Data(handleNearAmount(deposit: deposit))
                }
                let signingInput = NEARSigningInput.with {
                    $0.signerID = signerId
                    $0.nonce = UInt64(nonce)!
                    $0.receiverID = receiverId
                    $0.actions = [NEARAction.with {
                        $0.transfer = transaction
                    }]
                    $0.blockHash = Base58.decodeNoCheck(string: blockHash)!

                    $0.privateKey = privateKey.data
                }
                let output: NEARSigningOutput = AnySigner.sign(input: signingInput, coin: coinType)
                let value = output.signedTransaction.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
                param["isSuccess"] = true
                param["signedTransaction"] = value
            } else {
                param["isSuccess"] = false
                param["signedTransaction"] = ""
            }
        } else {
            param["isSuccess"] = false
            param["signedTransaction"] = ""
        }
        chatChanel?.invokeMethod("signTransactionNearTokenCallBack", arguments: param)
        return param
    }

    private func signTransactionNearOtherToken(walletAddress: String,
                                      signerId: String,
                                      receiverId: String,
                                      nonce: String,
                                               blockHash: String, args: String, methodName: String) -> [String: Any] {
        let coinType = CoinType.near
        var param = [String: Any]()
        let walletModel = SharedPreference.shared.getListWallet().first(where: {$0.walletAddress == walletAddress})
        if let walletModel = walletModel, !walletModel.privateKey.isEmpty {
            if let privateKey = PrivateKey(data: walletModel.privateKey.hexadecimal!) {

//                let transaction = NEARTransfer.with{
//                    $0.deposit = Data(handleNearAmount(deposit: deposit))
//                }
                let functionCall = NEARFunctionCall.with{
                    $0.methodName = methodName
                    $0.args = args.hexadecimal!
                    $0.deposit = Data(hexString: "01000000000000000000000000000000")!
                    $0.gas = UInt64(300000000000000)
                }

                let signingInput = NEARSigningInput.with {
                    $0.signerID = signerId
                    $0.nonce = UInt64(nonce)!
                    $0.receiverID = receiverId
                    $0.actions = [NEARAction.with {
                        $0.functionCall = functionCall
                    }]
                    $0.blockHash = Base58.decodeNoCheck(string: blockHash)!
                    $0.privateKey = privateKey.data
                }
                let output: NEARSigningOutput = AnySigner.sign(input: signingInput, coin: coinType)
                let value = output.signedTransaction.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
                param["isSuccess"] = true
                param["signedTransaction"] = value
            } else {
                param["isSuccess"] = false
                param["signedTransaction"] = ""
            }
        } else {
            param["isSuccess"] = false
            param["signedTransaction"] = ""
        }
        chatChanel?.invokeMethod("signTransferSignNearOtherTokenCallBack", arguments: param)
        return param
    }
}

extension Data {
    struct HexEncodingOptions: OptionSet {
        let rawValue: Int
        static let upperCase = HexEncodingOptions(rawValue: 1 << 0)
    }
    
    func hexEncodedString(options: HexEncodingOptions = []) -> String {
        let format = options.contains(.upperCase) ? "%02hhX" : "%02hhx"
        return self.map { String(format: format, $0) }.joined()
    }
}

extension String {
    
    subscript(_ range: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
        let end = index(start, offsetBy: min(self.count - range.lowerBound,
                                             range.upperBound - range.lowerBound))
        return String(self[start..<end])
    }
    
    subscript(_ range: CountablePartialRangeFrom<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
        return String(self[start...])
    }
    
    var hexadecimal: Data? {
        var data = Data(capacity: count / 2)
        
        let regex = try! NSRegularExpression(pattern: "[0-9a-f]{1,2}", options: .caseInsensitive)
        regex.enumerateMatches(in: self, range: NSRange(startIndex..., in: self)) { match, _, _ in
            let byteString = (self as NSString).substring(with: match!.range)
            let num = UInt8(byteString, radix: 16)!
            data.append(num)
        }
        
        guard data.count > 0 else { return nil }
        
        return data
    }
    

    func handleNameWallet(listWallet :[WalletModel]) -> String {
        var index = 1
        var nameFilter : String
        while(true) {
            nameFilter = "Account \(index)"
            if(listWallet.first(where:{$0.walletName == nameFilter}) == nil){
                return nameFilter
            }
            index+=1
        }
    }
    
    func handleAmount(decimal: Int) -> String {
        let parts = self.split(separator: ".")
        if self.isEmpty {
            return "0"
        } else {
            if parts.count == 1 {
                var buffer = ""
                var size = 0
                while (size < decimal) {
                    buffer = buffer + "0"
                    size+=1
                }
                return self + buffer
            } else if (parts.count > 1) {
                if parts[1].count >= decimal {
                    let part = String(parts[1])
                    return parts[0] + String(part[0..<decimal])
                } else {
                    let valueAmount = parts[0]
                    let valueDecimal = parts[1]
                    var buffer = ""
                    var size = valueDecimal.count
                    while (size < decimal) {
                        buffer = buffer + "0"
                        size+=1
                    }
                    return valueAmount + valueDecimal + buffer
                }
            } else {
                return "0"
            }
        }
    }
}

extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }
    
    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }
    
    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
}
