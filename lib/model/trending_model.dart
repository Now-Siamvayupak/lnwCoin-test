import 'dart:convert';

class Trending {
  final String id;
  final int coinId;
  final String name;
  final String symbol;
  final int marketCapRank;
  final String thumb;
  final double price;
  final String marketCap;
  final String totalVolume;

  Trending({
    required this.id,
    required this.coinId,
    required this.name,
    required this.symbol,
    required this.marketCapRank,
    required this.thumb,
    required this.price,
    required this.marketCap,
    required this.totalVolume,
  });

  factory Trending.fromJson(Map<String, dynamic> json) {
    return Trending(
      id: json['item']['id'] ?? 'N/A',
      coinId: json['item']['coin_id'] ?? 0,
      name: json['item']['name'] ?? 'Unknown',
      symbol: json['item']['symbol'] ?? '',
      marketCapRank: json['item']['market_cap_rank'] ?? 0,
      thumb: json['item']['thumb'] ?? '',
      price: json['item']['data']['price'] ?? 0.0,
      marketCap: json['item']['data']['market_cap'] ?? 'Unknown',
      totalVolume: json['item']['data']['total_volume'] ?? 'Unknown',
    );
  }
}

List<Trending> parseCoins(String responseBody) {
  final parsed = json.decode(responseBody)['coins'].cast<Map<String, dynamic>>();
  return parsed.map<Trending>((json) => Trending.fromJson(json)).toList();
}
