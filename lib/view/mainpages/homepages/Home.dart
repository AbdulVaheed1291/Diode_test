import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/apimodels/Api_Model.dart';
import '../../widgets/orderpagewidgets/Custom_Fooditems.dart';
import '../../widgets/Custom_Text.dart';
import '../../widgets/Custom_Trendingitems.dart';
import '../../widgets/Custom_Banner.dart';
import '../../../viewmodel/cubit and state files/allcubitandstate/all_cubit.dart';
import '../../../viewmodel/cubit and state files/allcubitandstate/all_state.dart';
import '../orderpages/Productorder_Page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    context.read<AllCubit>().getProducts();
  }

  bool flag = false;

  Future<void> _refreshData(BuildContext context) async {
    await context.read<AllCubit>().getProducts();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final paddingValue = screenWidth * 0.04;
    final titleFontSize = screenWidth * 0.06;
    final subtitleFontSize = screenWidth * 0.035;
    final iconSize = screenWidth * 0.045;
    final bannerHeight = screenHeight * 0.24;

    return Scaffold(
      appBar:
          AppBar(toolbarHeight: 1, backgroundColor: const Color(0xff356B69)),
      body: RefreshIndicator(
        color: const Color(0xff356B69),
        onRefresh: () => _refreshData(context),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              // Static Header Section
              Stack(
                children: [
                  Container(
                    height: bannerHeight,
                    width: double.infinity,
                    decoration: const BoxDecoration(color: Color(0xFF2E6A67)),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Image.asset('assets/Frame 7 (1).png',
                        fit: BoxFit.contain, width: screenWidth * 0.9),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(paddingValue),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("What are you craving\ntoday?",
                                style: TextStyle(
                                    fontSize: titleFontSize,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(CupertinoIcons.ant_circle_fill,
                                    color: Colors.white, size: iconSize),
                                const SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                      "19290 Al Fateh Grand Mosque Road, Bahrain",
                                      style: TextStyle(
                                          fontSize: subtitleFontSize,
                                          color: Colors.white),
                                      overflow: TextOverflow.ellipsis),
                                ),
                                Icon(CupertinoIcons.arrow_down_circle,
                                    color: Colors.white, size: iconSize),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: paddingValue),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: "What are you looking for?",
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(
                                            color: Colors.grey.shade500),
                                      ),
                                    ),
                                  ),
                                  Icon(CupertinoIcons.slider_horizontal_3,
                                      color: Colors.grey.shade700,
                                      size: iconSize),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // Dynamic Content Section with BlocBuilder
              BlocBuilder<AllCubit, AllState>(
                builder: (context, state) {
                  if (state is AllLoading) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.all(paddingValue),
                        child: const CircularProgressIndicator(
                          color: Color(0xff356B69),
                        ),
                      ),
                    );
                  } else if (state is AllSuccess) {
                    final products = state.products;

                    Product getProduct(int id) =>
                        products.firstWhere((product) => product.id == id);

                    final banners = [
                      getProduct(3).imageUrl,
                      getProduct(4).imageUrl,
                      getProduct(5).imageUrl
                    ];

                    final Bananabread = getProduct(15);
                    final cappuccino = getProduct(2);
                    final avocado = getProduct(20);
                    final chocolate = getProduct(18);

                    final circleItems = [
                      getProduct(4),
                      getProduct(5),
                      getProduct(6),
                      getProduct(16),
                      getProduct(8),
                      getProduct(9),
                      getProduct(10),
                      getProduct(11)
                    ];

                    return Column(
                      children: [
                        SizedBox(
                            height: bannerHeight,
                            child: BannerCarousel(banners: banners)),
                        Padding(
                          padding: EdgeInsets.all(paddingValue),
                          child: Row(
                            children: [
                              TextWidget(
                                  text: 'Trending',
                                  color: const Color(0xff356B69),
                                  fontSize: titleFontSize,
                                  fontWeight: FontWeight.w500),SizedBox(width: 5,),
                              Container(
                                height: 20,
                                child: Center(
                                  child: Text(
                                    "16",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                width: 33,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: Color(0xffCEAC6D)),
                              ),
                              const Spacer(),
                              TextWidget(
                                  text: 'View all  >',
                                  color: const Color(0xff356B69),
                                  fontSize: subtitleFontSize,
                                  fontWeight: FontWeight.w500),
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              _buildTrendingItem(Bananabread, context),
                              _buildTrendingItem(cappuccino, context),
                              _buildTrendingItem(avocado, context),
                              _buildTrendingItem(chocolate, context),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(paddingValue),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              spacing: 30,
                              children: circleItems
                                  .sublist(0, 4)
                                  .map((item) => FoodItems(
                                      imagePath: item.imageUrl,
                                      name: item.name))
                                  .toList(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(paddingValue),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              spacing: 30,
                              children: circleItems
                                  .sublist(4)
                                  .map((item) => FoodItems(
                                      imagePath: item.imageUrl,
                                      name: item.name))
                                  .toList(),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else if (state is AllFailure) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.all(paddingValue),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.error_outline,
                              color: Color(0xff356B69),
                              size: 60,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              state.errorMessage,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 24),

                          ],
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTrendingItem(Product product, BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProductorderPage(
            imagePath: product.imageUrl,
            title: product.name,
            rating: product.rating,
            price: product.price.toString(),
            time: product.makingTime,
            currency: product.currency,
          ),
        ));
      },
      child: TrendingItemCard(
        imageUrl: product.imageUrl,
        title: product.name,
        cost: 'BHD ${product.price}',
        userRating: product.rating.toString(),
        duration: product.makingTime,
        description: product.price.toString(),
      ),
    );
  }
}
