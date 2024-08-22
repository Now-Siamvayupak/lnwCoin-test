import 'dart:convert';

class Market {
  String symbol;
  String lastPrice;
  String priceChangePercent;

  Market({
    required this.symbol,
    required this.lastPrice,
    required this.priceChangePercent,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'symbol': symbol});
    result.addAll({'price': lastPrice});
    result.addAll({'priceChangePercent': priceChangePercent});

    return result;
  }

  factory Market.fromMap(Map<String, dynamic> map) {
    return Market(
      symbol: map['symbol'] ?? '',
      lastPrice: map['lastPrice'] ?? '',
      priceChangePercent: map['priceChangePercent'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Market.fromJson(String source) => Market.fromMap(json.decode(source));
}

const List<String> coinLogos = [
  "BTCUSDT",
  "ADAUSDT",
  "ATOMUSDT",
  "AVAXUSDT",
  "BNBUSDT",
  "BUSDUSDT",
  "DARUSDT",
  "DOGEUSDT",
  "ETHUSDT",
  "FETUSDT",
  "FTMUSDT",
  "LINKUSDT",
  "LTCUSDT",
  "MATICUSDT",
  "NEARUSDT",
  "OPUSDT",
  "SANDUSDT",
  "SCUSDT",
  "SHIBUSDT",
  "SOLUSDT",
  "STORJUSDT",
  "TRXUSDT",
  "WAVEUSDT",
  "XRPUSDT",
  "EOSUSDT",
  "ETCUSDT",
  "VETUSDT",
  "USDCUSDT",
  "WAVESUSDT",
  "ZILUSDT",
  "ZRXUSDT",
  "THETAUSDT",
  "ENJUSDT",
  "TFUELUSDT",
  "ONEUSDT",
  "ALGOUSDT",
  "DUSKUSDT",
  "ANKRUSDT",
  "COSUSDT",
  "MTLUSDT",
  "KEYUSDT",
  "CHZUSDT",
  "RENUSDT",
  "RVNUSDT",
  "HBARUSDT",
  "NKNUSDT",
  "STXUSDT",
  "KAVAUSDT",
  "ARPAUSDT",
  "IOTXUSDT",
  "CTXCUSDT",
  "BCHUSDT",
  "EURUSDT",
  "OGNUSDT",
  "COTIUSDT",
  "MDTUSDT",
  "KNCUSDT",
  "COMPUSDT",
  "SNXUSDT",
  "VTHOUSDT",
  "DGBUSDT",
  "MKRUSDT",
  "KMDUSDT",
  "CRVUSDT",
  "OCEANUSDT",
  "DOTUSDT",
  "LUNAUSDT",
  "RSRUSDT",
  "TRBUSDT",
  "EGLDUSDT",
  "RUNEUSDT",
  "BELUSDT",
  "UNIUSDT",
  "ORNUSDT",
  "XVSUSDT",
  "AAVEUSDT",
  "FILUSDT",
  "INJUSDT",
  "AKROUSDT",
  "AXSUSDT",
  "ROSEUSDT",
  "SKLUSDT",
  "GRTUSDT",
  "CELOUSDT",
  "TRUUSDT",
  "CKBUSDT",
  "TWTUSDT",
  "CAKEUSDT",
  "BADGERUSDT",
  "OMUSDT",
  "LINAUSDT",
  "PERPUSDT",
  "CFXUSDT",
  "BURGERUSDT",
  "ICPUSDT",
  "ARUSDT",
  "MASKUSDT",
  "LPTUSDT",
  "XVGUSDT",
  "BONDUSDT",
  "MINAUSDT",
  "RAYUSDT",
  "MBOXUSDT",
  "GHSTUSDT",
  "XECUSDT",
  "DYDXUSDT",
  "GALAUSDT",
  "ILVUSDT",
  "YGGUSDT",
  "FIDAUSDT",
  "FRONTUSDT",
  "BETAUSDT",
  "LAZIOUSDT",
  "AUCTIONUSDT",
  "BNXUSDT",
  "MOVRUSDT",
  "KP3RUSDT",
  "JASMYUSDT",
  "AMPUSDT",
  "RNDRUSDT",
  "SANTOSUSDT",
  "BICOUSDT",
  "FXSUSDT",
  "HIGHUSDT",
  "OOKIUSDT",
  "JOEUSDT",
  "IMXUSDT",
  "WOOUSDT",
  "TUSDT",
  "GMTUSDT",
  "APEUSDT",
  "MOBUSDT",
  "REIUSDT",
  "LDOUSDT",
  "LEVERUSDT",
  "LUNCUSDT",
  "POLYXUSDT",
  "APTUSDT",
  "HOOKUSDT",
  "MAGICUSDT",
  "SYNUSDT",
  "VIBUSDT",
  "LQTYUSDT",
  "PROMUSDT",
  "IDUSDT",
  "ARBUSDT",
  "RDNTUSDT",
  "EDUUSDT",
  "SUIUSDT",
  "PEPEUSDT",
  "FLOKIUSDT",
  "COMBOUSDT",
  "MAVUSDT",
  "PENDLEUSDT",
  "ARKMUSDT",
  "WLDUSDT",
  "FDUSDUSDT",
  "SEIUSDT",
  "CYBERUSDT",
  "TIAUSDT",
  "MEMEUSDT",
  "ORDIUSDT",
  "BEAMXUSDT",
  "VANRYUSDT",
  "JTOUSDT",
  "1000SATSUSDT",
  "BONKUSDT",
  "ACEUSDT",
  "NFPUSDT",
  "AIUSDT",
  "XAIUSDT",
  "MANTAUSDT",
  "ALTUSDT",
  "JUPUSDT",
  "PYTHUSDT",
  "RONINUSDT",
  "DYMUSDT",
  "PIXELUSDT",
  "STRKUSDT",
  "PORTALUSDT",
  "PDAUSDT",
  "AXLUSDT",
  "WIFUSDT",
  "METISUSDT",
  "AEVOUSDT",
  "BOMEUSDT",
  "ETHFIUSDT",
  "ENAUSDT",
  "WANUSDT",
  "USDTTRY",
  "USDTBRL",
  "HIFIUSDT",
  "AGIXUSDT",
];

const List<String> owncoinLogos = [
  "ATIDUSDT",
  "AYCUSDT",
  "BIADUSDT",
  "BTADUSDT",
  "CCCUSDT",
  "CGDUSDT",
  "CHDUSDT",
  "CHGDUSDT",
  "CHGPCUSDT",
  "CHPCUSDT",
  "DINCUSDT",
  "DNCUSDT",
  "FNGUSDT",
  "FTDUSDT",
  "GMDUSDT",
  "HMIDUSDT",
  "IPCUSDT",
  "JWCUSDT",
  "KHPNUSDT",
  "KPCUSDT",
  "KPPUSDT",
  "LOSCUSDT",
  "MDCUSDT",
  "MHTUSDT",
  "MIDUSDT",
  "MKCUSDT",
  "MKDUSDT",
  "MNDUSDT",
  "MNYUSDT",
  "NKPUSDT",
  "NTNUSDT",
  "OMCUSDT",
  "PAIUSDT",
  "PDCUSDT",
  "PKDUSDT",
  "PKSCUSDT",
  "PLIDUSDT",
  "PLNGCUSDT",
  "PLODUSDT",
  "PMCUSDT",
  "PMJCUSDT",
  "PNCUSDT",
  "PPDCUSDT",
  "PPDUSDT",
  "PRCUSDT",
  "PTNUSDT",
  "PYDUSDT",
  "PYKTUSDT",
  "RCWCUSDT",
  "REDUSDT",
  "RMKUSDT",
  "RRUUSDT",
  "RSRUSDT",
  "RYCUSDT",
  "SABUSDT",
  "SATIUSDT",
  "SAYUSDT",
  "SBDUSDT",
  "SDSUSDT",
  "SFACUSDT",
  "SFCUSDT",
  "SGDUSDT",
  "SIDUSDT",
  "SISPCUSDT",
  "SKDUSDT",
  "SMNCUSDT",
  "SNDUSDT",
  "SNUCUSDT",
  "SRJUSDT",
  "SSDUSDT",
  "SSMCUSDT",
  "STGUSDT",
  "STWCUSDT",
  "SUVCUSDT",
  "SVLDUSDT",
  "SVYPUSDT",
  "SWCUSDT",
  "SWTCUSDT",
  "TBMUSDT",
  "TDDUSDT",
  "THCUSDT",
  "THDKUSDT",
  "TKCUSDT",
  "TKDUSDT",
  "TLDUSDT",
  "TLNUSDT",
  "TNGUSDT",
  "TTCUSDT",
  "TWECUSDT",
  "TYCUSDT",
  "UDSCUSDT",
  "VYDUSDT",
  "YIMUSDT",
  "YNGUSDT"
];
