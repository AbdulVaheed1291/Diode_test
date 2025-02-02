import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../viewmodel/cubit and state files/productordercubitandstate/productorder_cubit.dart';

class OrderHistoryCard extends StatelessWidget {
  final String name;
  final double price;
  final DateTime date;
  final String? imageUrl;
  final bool? orderPlaced;
  final String? ido;

  const OrderHistoryCard({
    Key? key,
    required this.name,this .ido,
    required this.price,
    required this.date,
    this.imageUrl,
    this.orderPlaced,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(height:150 ,width:353 ,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          // Image container
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: imageUrl != null
                  ? DecorationImage(
                image: NetworkImage(imageUrl!),
                fit: BoxFit.cover,
              )
                  : null,
              color: Colors.grey.shade200,
            ),
          ),
          const SizedBox(width: 12),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(color: Color(0xff356B69),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'BHD ${price.toStringAsFixed(3)}',
                  style: const TextStyle(color:  Color(0xffCEAC6D),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  DateFormat('dd-MM-yyyy | HH:mm a').format(date),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
                if (orderPlaced != null)
                  Text(
                    orderPlaced! ? 'Order placed' : 'Order pending',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xff6E8382),
                    ),
                  ),
              ],
            ),
          ),

          // Arrow icon
          Column(
            children: [
              const Icon(
                Icons.chevron_right,
                color: Color(0xffCEAC6D),
              ),
              SizedBox(height: 80),
              InkWell(
                  onTap: () {
                    // Store the cubit before showing dialog
                    final cubit = context.read<ProductorderCubit>();

                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext dialogContext) { // Note the different context
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Are you sure you want to remove this item from cart?',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () => Navigator.of(dialogContext).pop(),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.grey.shade200,
                                        foregroundColor: Colors.black,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                      child: Text('Cancel'),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        // Use the stored cubit instead of trying to access it from dialog context
                                        if (ido != null) {
                                          cubit.removeOrder(ido!);
                                        }
                                        Navigator.of(dialogContext).pop();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xffCEAC6D),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                      child: Text(
                                        'Remove',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Icon(Icons.delete_outline, size: 15)
              ),
            ],
          ),

        ],
      ),
    );
  }
}