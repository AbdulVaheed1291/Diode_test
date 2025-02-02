import 'package:diode_test/viewmodel/cubit%20and%20state%20files/productordercubitandstate/productorder_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/orderpagewidgets/Custom_Orderhistorycard.dart';

class OrderAndCartPage extends StatelessWidget {
  const OrderAndCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: BlocProvider(
          create: (context) => ProductorderCubit(context),
          child: BlocBuilder<ProductorderCubit, ProductorderState>(
            builder: (context, state) {
              final cubit = context.read<ProductorderCubit>();
              final screenWidth = MediaQuery.of(context).size.width;
              final screenHeight = MediaQuery.of(context).size.height;

              return Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: screenHeight * 0.2, // Responsive height
                        child: Image.asset(
                          'assets/Rectangle 1 (1).png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Image.asset(
                          'assets/Frame 7 (1).png',
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: screenHeight * 0.05, // Adjust top position for responsiveness
                        left: 20,
                        right: 20,
                        child: Column(
                          children: [
                            const Text(
                              "Order History",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      onChanged: (value) {
                                        cubit.searchOrders(value);
                                      },
                                      decoration: InputDecoration(
                                        hintText: "What are you looking for ?",
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(
                                          color: Colors.grey.shade500,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    CupertinoIcons.slider_horizontal_3,
                                    color: Colors.grey.shade700,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const TabBar(
                    tabs: [
                      Tab(text: 'Cart'),  // Renamed Cart → Orders
                      Tab(text: 'Orders'),  // Renamed Order Management → Cart
                    ],
                    labelColor: Color(0xffCEAC6D),
                    unselectedLabelColor: Colors.grey,
                    indicator: BoxDecoration(),
                    dividerColor: Colors.transparent,
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        // Now shows orders
                        _buildCartSection(state),
                        _buildOrdersSection(state),// Now shows cart items
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  /// Builds the Orders Section (previously Cart)
  Widget _buildOrdersSection(ProductorderState state) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.remove_shopping_cart, size: 50, color: Colors.grey),
          SizedBox(height: 10),
          Text(
            'No orders yet',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the Cart Section (previously Order Management)
  Widget _buildCartSection(ProductorderState state) {
    return state is ProductorderLoading
        ? const Center(child: CircularProgressIndicator())
        : state is ProductorderLoaded
        ? state.orders.isEmpty
        ? const Center(
      child: Text(
        'No items in cart',
        style: TextStyle(
          color: Colors.grey,
          fontSize: 16,
        ),
      ),
    )
        : ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: state.orders.length,
      itemBuilder: (context, index) {
        final cartItem = state.orders[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: OrderHistoryCard(
            name: cartItem.name,
            ido: cartItem.id,
            price: double.parse(cartItem.price),
            date: DateTime.parse(
              cartItem.date.split('-').reversed.join('-'),
            ),
            imageUrl: cartItem.imageUrl,
            orderPlaced: false,
          ),
        );
      },
    )
        : state is ProductorderError
        ? Center(
      child: Text(
        (state as ProductorderError).message,
        style: const TextStyle(color: Colors.red),
      ),
    )
        : const SizedBox();
  }
}
