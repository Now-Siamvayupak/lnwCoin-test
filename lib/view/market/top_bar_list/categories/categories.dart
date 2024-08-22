import 'package:flutter/material.dart';
import 'package:lnwCoin/model/category.dart';
import 'package:lnwCoin/service/coingecko/coingecko_api.dart';
import 'package:lnwCoin/utils/extensions/lottie_extension.dart';
import 'package:lnwCoin/view/market/top_bar_list/categories/coin.dart';
import 'package:lottie/lottie.dart';
import 'package:intl/intl.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage>
    with TickerProviderStateMixin {
  late Future<List<dynamic>> _categoriesFuture;
  late AnimationController _animationController;

  // Future<List<dynamic>?> trackerData() async {
  //   String apiEndpoint = "https://api.coingecko.com/api/v3/coins/categories";
  //   var url = Uri.parse(apiEndpoint);
  //   var response = await http.get(url);
  //   if (response.statusCode == 200) {
  //     var res = response.body;
  //     cryptoList = cryptoTrackerFromJson(res);
  //     setState(() {
  //       cryptoList;
  //     });
  //     return cryptoList;
  //   } else {
  //     return null;
  //   }
  // }

  @override
  void initState() {
    print("categories_view");
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3000));
    _categoriesFuture = CoinGeckoApi()
        .fetchCategories(); // Ensure the future is initialized here
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: _categoriesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: LottieBuilder.asset(
              LottieEnum.loading.lottiePath,
              height: 80,
              width: 80,
              repeat: true,
              animate: true,
              controller: _animationController,
              onLoaded: (p0) {
                _animationController.forward();
              },
            ),
          );
        } else if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var categoryJson = snapshot.data![index] as Map<String, dynamic>;
              var category = CryptoCategory.fromJson(
                  categoryJson); // Correctly converts to CryptoCategory
              return CryptoCategoryCard(
                category: category,
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return Center(child: Text('No categories available'));
        }
      },
    );
  }
}

class CryptoCategoryCard extends StatelessWidget {
  final CryptoCategory category;

  const CryptoCategoryCard({
    Key? key,
    required this.category,
  }) : super(key: key);

  String getFormattedMarketCap(num marketCap) {
    return NumberFormat('#,##0', 'en_US').format(marketCap);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Cate_coin_page(category: category),
          ),
        );
      },
      child: Card(
        color: Color(0x1E2A38).withOpacity(0.5), // Dark card background
        margin: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    category.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Theme(
                            data: ThemeData.dark().copyWith(
                              dialogBackgroundColor:
                                  Colors.grey[900], // Dark background
                              textTheme: TextTheme(
                                titleLarge: TextStyle(
                                    color: Colors.white,
                                    fontWeight:
                                        FontWeight.bold), // Title text style
                                bodyMedium: TextStyle(
                                    color:
                                        Colors.white70), // Content text style
                              ),
                              dialogTheme: DialogTheme(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                            child: AlertDialog(
                              title: Text(category.name),
                              content: Text(
                                category.content
                              ),
                              actions: [
                                TextButton(
                                  child: Text('Close'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Icon(
                      Icons.info_outline,
                      color: Colors.white,
                      size: 20, // Adjust the size of the icon
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'Market Cap: \$${getFormattedMarketCap(category.marketCap)}',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '24h Change: ${category.marketCapChange24h.toStringAsFixed(2)}%',
                style: TextStyle(
                  color: category.marketCapChange24h >= 0
                      ? Colors.green
                      : Colors.red,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: List<String>.from(category.top3Coins).map((url) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Image.network(
                      url,
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
