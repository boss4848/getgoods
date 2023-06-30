import 'package:flutter/material.dart';
import 'package:getgoods/src/constants/colors.dart';
import 'package:getgoods/src/constants/constants.dart';
import 'package:getgoods/src/pages/login/widgets/appbar.dart';
import 'package:getgoods/src/pages/store_analytics/widgets/overall_bar.dart';
import 'package:getgoods/src/pages/store_analytics/widgets/productrank_info.dart';
import 'package:getgoods/src/pages/store_analytics/widgets/stat_chart2.dart';
import 'package:getgoods/src/pages/store_analytics/widgets/summary_income.dart';
import 'package:getgoods/src/services/api_service.dart';

class StoreAnalyticsPage extends StatefulWidget {
  final String shopId;
  const StoreAnalyticsPage({
    super.key,
    required this.shopId,
  });

  @override
  State<StoreAnalyticsPage> createState() => _StoreAnalyticsPageState();
}

class _StoreAnalyticsPageState extends State<StoreAnalyticsPage> {
  @override
  void initState() {
    super.initState();
    getStats();
  }

  dynamic stats = {
    "sold": '',
    "income": '',
    "totalNetIncome": '',
    'email': '',
    'shopName': ''
  };

  getStats() async {
    final url = '${ApiConstants.baseUrl}/transactions/stats/${widget.shopId}';
    final res = await ApiService.request(
      'GET',
      url,
      requiresAuth: true,
    );

    final updatedStats = res['data'];
    print('stats: $updatedStats');

    stats = {
      "sold": updatedStats['sold'].toString(),
      "income": updatedStats['income'].toString(),
      "totalNetIncome": updatedStats['totalNetIncome'].toString(),
      'email': updatedStats['email'].toString(),
      'shopName': updatedStats['shopName'].toString()
    };

    print(updatedStats['sold']);
    print(updatedStats['income']);
    print(updatedStats['totalNetIncome']);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: primaryColor,
      child: SafeArea(
          child: Column(
        children: [
          const TitleAppBar(titleName: 'Store Analytics'),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/logo_2.png'),
                  radius: 40,
                ),
                Text(
                  stats['shopName'] ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'SFTHONBURI',
                  ),
                ),
                Text(
                  stats['email'] ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'SFTHONBURI',
                  ),
                ),
                const SizedBox(
                  height: defaultpadding,
                ),
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(defaultpadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Overall Store Analytics',
                          style: TextStyle(
                            color: primaryTextColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'SFTHONBURI',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(defaultpadding / 4),
                          child: OverAllStoreBar(
                            orders: stats['sold'],
                            revenues: stats['income'],
                          ),
                        ),
                        const SizedBox(
                          height: defaultpadding,
                        ),
                        // const Text(
                        //   'Weekly Revenue Accumulated',
                        //   style: TextStyle(
                        //     color: primaryTextColor,
                        //     fontSize: 20,
                        //     fontWeight: FontWeight.w700,
                        //     fontFamily: 'SFTHONBURI',
                        //   ),
                        // ),
                        // const LineChartSample2(),
                        // const SizedBox(
                        //   height: defaultpadding,
                        // ),
                        // const Text(
                        //   'Product Ranking',
                        //   style: TextStyle(
                        //     color: primaryTextColor,
                        //     fontSize: 20,
                        //     fontWeight: FontWeight.w700,
                        //     fontFamily: 'SFTHONBURI',
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.all(defaultpadding / 4),
                        //   child: ProductRankInfo(),
                        // ),
                        // const SizedBox(
                        //   height: defaultpadding,
                        // ),
                        const Text(
                          'Total Monthly Income Summary',
                          style: TextStyle(
                            color: primaryTextColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'SFTHONBURI',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(defaultpadding / 4),
                          child: SummaryIncomeInfo(
                            soldItems: stats['sold'] ?? '',
                            totalIncome: stats['income'] ?? '',
                            totalNetIncome: stats['totalNetIncome'] ?? '',
                          ),
                        ),
                        const SizedBox(
                          height: 600,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ))
        ],
      )),
    ));
  }
}
