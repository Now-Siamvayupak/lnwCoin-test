import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lnwCoin/model/derivatives_model.dart';

import 'package:lnwCoin/service/coingecko/coingecko_api.dart';
import 'package:lnwCoin/utils/extensions/lottie_extension.dart';
import 'package:lottie/lottie.dart';
import 'package:auto_size_text/auto_size_text.dart';

class DerivativesPage extends StatefulWidget {
  const DerivativesPage({super.key});

  @override
  State<DerivativesPage> createState() => _DerivativesPageState();
}

class _DerivativesPageState extends State<DerivativesPage>
    with TickerProviderStateMixin {
  late Future<List<dynamic>> _deFuture;
  late AnimationController _animationController;
  @override
  void initState() {
    print("Derivatives_view");
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3000));
    _deFuture =
        CoinGeckoApi().fetchde(); // Ensure the future is initialized here
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
      future: _deFuture,
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
          return Column(
            children: [
              Container(
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Card(
                    color: const Color.fromARGB(53, 30, 42, 56),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Expanded(
                            flex: 5,
                            child: Center(
                              child: Text(
                                'Exchange',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Center(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    '24h Open',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                      width:
                                          4), // Add some space between the text and the icon
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Theme(
                                            data: ThemeData.dark().copyWith(
                                              dialogBackgroundColor: Colors
                                                  .grey[900], // Dark background
                                              textTheme: const TextTheme(
                                                titleLarge: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight
                                                        .bold), // Title text style
                                                bodyMedium: TextStyle(
                                                    color: Colors
                                                        .white70), // Content text style
                                              ),
                                              dialogTheme: DialogTheme(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                              ),
                                            ),
                                            child: AlertDialog(
                                              title: const Text(
                                                  '24-Hour Open Interest\n(in billions)',
                                                  style: TextStyle(fontSize: 20),),
                                              content: const Text(
                                                "This metric reflects the total value of outstanding derivative contracts (such as futures and options) that have not been settled. It provides insights into the market's liquidity and how much money is currently at stake in derivatives trading. Higher open interest indicates greater liquidity and participation, which can mean more opportunities and stability for traders.",
                                              ),
                                              actions: [
                                                TextButton(
                                                  child: const Text('Close'),
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
                                    child: const Icon(
                                      Icons.info_outline,
                                      color: Colors.white,
                                      size: 16, // Adjust the size of the icon
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Center(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const AutoSizeText(
                                    '24h Volume',
                                    style: TextStyle(
                                      // fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    maxLines: 1, // Set max lines to maintain a single-line text
                                    minFontSize: 12, // Minimum font size
                                  ),
                                  const SizedBox(
                                      width:
                                          4), // Add some space between the text and the icon
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Theme(
                                            data: ThemeData.dark().copyWith(
                                              dialogBackgroundColor: Colors
                                                  .grey[900], // Dark background
                                              textTheme: const TextTheme(
                                                titleLarge: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight
                                                        .bold), // Title text style
                                                bodyMedium: TextStyle(
                                                    color: Colors
                                                        .white70), // Content text style
                                              ),
                                              dialogTheme: DialogTheme(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                              ),
                                            ),
                                            child: AlertDialog(
                                              title: const Text(
                                                  '24-Hour Volume Information\n(in billions)',
                                                  style: TextStyle(fontSize: 20),),
                                              content: const Text(
                                                'This represents the total amount of currency traded within the last 24 hours. This metric is crucial as it shows the overall activity level of the market, helping traders understand the market’s vibrancy and the potential for significant price movements. A higher trade volume often suggests a high interest in the market, potentially leading to price volatility.',
                                              ),
                                              actions: [
                                                TextButton(
                                                  child: const Text('Close'),
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
                                    child: const Icon(
                                      Icons.info_outline,
                                      color: Colors.white,
                                      size: 16, // Adjust the size of the icon
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    print(snapshot.data![index]);
                    var dataJson =
                        Map<String, dynamic>.from(snapshot.data![index]);
                    var data = DerivativesModel.fromJson(
                        dataJson); // Correctly converts to CryptoCategory
                    return NftCard(
                      data: data,
                    );
                  },
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return const Center(child: Text('No categories available'));
        }
      },
    );
  }
}

class NftCard extends StatelessWidget {
  final DerivativesModel data;

  const NftCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: InkWell(
          onTap: () {},
          child: Card(
              color: const Color(0x1E2A38).withOpacity(0.5),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                        flex: 5,
                        child: Center(
                          child: Row(
                            children: [
                              SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: Image.network(data.image)),
                              const SizedBox(
                                width: 10,
                              ),
                              SplitTextWidget(
                                text: data.name,
                                splitLength: 20,
                              ),
                            ],
                          ),
                        )),
                    Expanded(
                      flex: 3,
                      child: Center(
                        child: Text(
                          "\₿${NumberFormat('#,##0.##', 'en_US').format(data.openInterestBtc)}",
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 3,
                        child: Container(
                          height: 30,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              '\₿${NumberFormat('#,##0.##', 'en_US').format(data.tradeVolume24hBtc)}',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                            ),
                          ),
                        )),
                  ],
                ),
              )),
        ));
  }
}

class SplitTextWidget extends StatelessWidget {
  final String text;
  final int splitLength;

  const SplitTextWidget({Key? key, required this.text, this.splitLength = 20})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      _splitTextWithCondition(text, splitLength),
      style: const TextStyle(
          fontWeight: FontWeight.w600, color: Colors.white, fontSize: 12),
    );
  }

  String _splitTextWithCondition(String text, int maxLength) {
    // This function inserts newline characters at spaces if the preceding text is longer than maxLength
    List<String> words = text.split(' ');
    String result = '';
    String currentLine = '';

    for (String word in words) {
      if ((currentLine + word).length > maxLength) {
        result += (result.isEmpty ? '' : '\n') + currentLine.trim();
        currentLine = '';
      }
      currentLine += word + ' ';
    }

    if (currentLine.isNotEmpty) {
      result += (result.isEmpty ? '' : '\n') + currentLine.trim();
    }

    return result;
  }
}
