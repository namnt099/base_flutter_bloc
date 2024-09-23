class AppConstants {
  static String appName = 'Hola';
  static String baseUrl = 'https://arctx-dev-apigw.aequitas.dev/';
  static String contractDepositBSC =
      '0x87856BCfb62572e938047490dbE559bAd4FdFE95';
  static String contractDepositPolygon =
      '0x1aac836e42560a64d51fE53724f9D40Aa3A9A1B1';
  static String contractDepositNear = 'coral-exchangepoint.testnet';
  static String bscRpc = 'https://data-seed-prebsc-1-s1.binance.org:8545';
  static String polygonRpc = 'https://rpc.ankr.com/polygon_mumbai';
  static String nearRpc = 'https://rpc.testnet.near.org';
  static String bscChainId = '97';
  static String polygonChainId = '80001';
  static String nearChainId = 'testnet';
  static String contractCrlBSC = '0x8178636166a4962ec28d0e12aebdca4ef0690cf2';
  static String contractCrlPolygon =
      '0xC96254ab1B8Ec4711CD3C6c97A14766175296ffc';
  static String contractCrlNear = 'coral-ft.testnet';
  static String bscScan = 'https://testnet.bscscan.com';
  static String nearScan = 'https://explorer.testnet.near.org/transactions/';
  static String polygonScan = 'https://mumbai.polygonscan.com';
  static String bscSmartContract = '0x0000000000000000000000000000000000000000';
  static String polygonSmartContract =
      '0x0000000000000000000000000000000000001010';
  static List<SecretKeyKind> secretKeysKind = [
    SecretKeyKind.private,
    SecretKeyKind.seed
  ];
  static List<ChainKind> chainKind = [
    ChainKind.btc,
    ChainKind.tron,
    ChainKind.eth
  ];
}

enum AppMode { LIGHT, DARK }

enum ServerType { DEV, QA, STAGING, PRODUCT }

enum SecretKeyKind {
  private('Private key', 'PRIVATE_KEY'),
  seed('Seed phrase', 'SEED_PHRASE');

  const SecretKeyKind(this.key, this.value);
  final String key;
  final String value;
  @override
  String toString() => key;
}

enum ChainKind {
  btc('Bitcoin'),
  tron('Tron'),
  eth('Ethereum');

  const ChainKind(this.key);
  final String key;

  @override
  String toString() => key;
}

const int BIG_INT = 1000000000000000000;
const int BIG_INT_9 = 1000000000;

const String NEAR_DEPOSIT = '1000000000000000000000000';
