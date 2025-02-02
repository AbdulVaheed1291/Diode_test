import 'package:diode_test/viewmodel/cubit%20and%20state%20files/productordercubitandstate/productorder_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/Custom_Text.dart';
import '../../widgets/Custom_Thinline.dart';
import '../../widgets/orderpagewidgets/Custom_OrderIncrementbutton.dart';
import '../../widgets/Custom_Container.dart';

class ProductorderPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final double rating;
  final String currency;
  final String price;
  final String time;

  const ProductorderPage({
    super.key,
    required this.imagePath,
    required this.title,
    required this.rating,
    required this.currency,
    required this.price,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff356B69),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16.0, vertical: 8.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(context),
                    const SizedBox(height: 20),
                    _buildProductImage(constraints),
                    const SizedBox(height: 50),
                    _buildSizeSection(),
                    const SizedBox(height: 30),
                    _buildDividerWithTitle("$title Options"),
                    _buildMilkOptions(constraints),
                    const SizedBox(height: 30),
                    _buildDividerWithTitle("Count"),
                    const CustomOrderincrementbutton(),
                    const SizedBox(height: 30),
                    _buildAddToCartButton(context),
                    const SizedBox(height: 16), // Bottom padding
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        Expanded(
          child: Center(
            child: TextWidget(
              text: title,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.settings, color: Colors.white),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildProductImage(BoxConstraints constraints) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: NetworkImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -30,
          left: 20,
          right: 20,
          child: _buildProductInfoCard(),
        ),
      ],
    );
  }

  Widget _buildProductInfoCard() {
    return Container(
      height: 102,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Column for Title, Rating, and Price
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  TextWidget(
                    text: title,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  SizedBox(width: 125,),

                  const Icon(Icons.favorite_border, color: Colors.grey),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 16),
                  Text(
                    '$rating ',
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  SizedBox(width: 90,),

                  Text(
                    time,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                '$currency $price',
                style: const TextStyle(color: Color(0xFFDEB887)),
              ),
            ],
          ),
          // Pushes the favorite icon & time to the right

          const SizedBox(height: 5),
        ],
      ),
    );
  }

  Widget _buildSizeSection() {
    return Column(
      children: [
        const TextWidget(
          fontSize: 16,
          text: "Cup Size",
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildSizeOption('Small'),
            _buildSizeOption('Medium'),
            _buildSizeOption('Large'),
          ],
        ),
      ],
    );
  }

  Widget _buildSizeOption(String size) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          "assets/Vector.png",
          height: 36,
          width: 28,
        ),
        const SizedBox(height: 12),
        CustomCont(
          width: 75,
          text: size,
        ),
      ],
    );
  }

  Widget _buildDividerWithTitle(String title) {
    return Column(
      children: [
        const ThinLine(lineWidth: double.infinity),
        const SizedBox(height: 20),
        TextWidget(
          fontSize: 16,
          text: title,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildMilkOptions(BoxConstraints constraints) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Convert the calculated width to an integer
        int buttonWidth = ((constraints.maxWidth - 40) / 3).round();
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomCont(width: buttonWidth, text: 'Regular'),
            CustomCont(width: buttonWidth, text: 'Skimmed'),
            CustomCont(width: buttonWidth, text: 'Whole'),
          ],
        );
      },
    );
  }

  Widget _buildAddToCartButton(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: const Color(0xffCEAC6D),
      ),
      child: BlocProvider(
        create: (context) => ProductorderCubit(context),
        child: BlocBuilder<ProductorderCubit, ProductorderState>(
          builder: (context, state) {
            final ordercubit = context.read<ProductorderCubit>();
            return Row(
              children: [
                /// "Add to Cart" Container
                Expanded(
                  flex: 2,
                  child: InkWell(
                    onTap: state is ProductorderLoaded &&
                        state.orders.any((item) => item.name == title)
                        ? null  // Disable the button if item is already in cart
                        : () {
                      ordercubit.addOrder(
                        name: title,
                        price: price,
                        imageUrl: imagePath,
                      );
                    },
                    child: Container(
                      height: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(32),
                          bottomLeft: Radius.circular(32),
                        ),
                        color: state is ProductorderLoaded &&
                            state.orders.any((item) => item.name == title)
                            ? const Color(0xffB8955D).withOpacity(0.6)  // Dimmed color when disabled
                            : const Color(0xffB8955D),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        state is ProductorderLoaded &&
                            state.orders.any((item) => item.name == title)
                            ? "Added to cart"
                            : "Add to cart",
                        style: TextStyle(
                          color: state is ProductorderLoaded &&
                              state.orders.any((item) => item.name == title)
                              ? Colors.white.withOpacity(0.7)  // Dimmed text when disabled
                              : Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

                /// Price Container
                Expanded(
                  flex: 2,
                  child: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(32),
                        bottomRight: Radius.circular(32),
                      ),
                      color: const Color(0xffCEAC6D),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      price,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}