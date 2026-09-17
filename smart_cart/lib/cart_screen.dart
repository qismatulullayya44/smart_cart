import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool _showDetails = false;

  final Color darkBlue = const Color(0xFF1A365D);
  final Color primaryBlue = const Color(0xFF2B6CB0);
  final Color lightBg = const Color(0xFFE1EEF9);
  final Color cardBg = const Color(0xFFD0E1F9);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      backgroundColor: lightBg,
      appBar: AppBar(
        backgroundColor: lightBg,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: darkBlue, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Keranjangku',
          style: TextStyle(color: darkBlue, fontWeight: FontWeight.bold, fontSize: 20), // Lebih besar
        ),
      ),
      body: cartProvider.items.isEmpty
          ? Center(
              child: Text(
                'Keranjang Anda masih kosong',
                style: TextStyle(color: darkBlue, fontSize: 16, fontWeight: FontWeight.w500),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: cardBg,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: primaryBlue.withAlpha(80)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Total Pembayaran',
                                        style: TextStyle(color: darkBlue, fontWeight: FontWeight.bold, fontSize: 14),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'RP ${cartProvider.totalAmount.toInt()}',
                                        style: TextStyle(
                                          fontSize: 22, // Angka total lebih menonjol
                                          fontWeight: FontWeight.bold,
                                          color: darkBlue,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: lightBg,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: primaryBlue.withAlpha(80)),
                                    ),
                                    child: Icon(Icons.account_balance_wallet_outlined, color: darkBlue, size: 28),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${cartProvider.items.length} item',
                                    style: TextStyle(fontSize: 13, color: darkBlue),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        _showDetails = !_showDetails;
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          'Lihat Detail',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: primaryBlue,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Icon(
                                          _showDetails ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_right,
                                          size: 18,
                                          color: primaryBlue,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              if (_showDetails) ...[
                                const SizedBox(height: 12),
                                ...cartProvider.items.values.map(
                                  (item) => Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 3),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${item.title} (x${item.quantity})',
                                          style: TextStyle(fontSize: 13, color: darkBlue),
                                        ),
                                        Text(
                                          'RP ${(item.price * item.quantity).toInt()}',
                                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: darkBlue),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: cartProvider.items.length,
                          itemBuilder: (context, index) {
                            final item = cartProvider.items.values.toList()[index];
                            final productId = cartProvider.items.keys.toList()[index];
                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: cardBg,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: primaryBlue.withAlpha(80)),
                              ),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: SizedBox(
                                      width: 60,
                                      height: 60,
                                      child: Image.network(
                                        item.imageUrl,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Container(
                                            color: lightBg,
                                            child: Icon(Icons.broken_image, color: darkBlue),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              item.title,
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: darkBlue),
                                            ),
                                            IconButton(
                                              padding: EdgeInsets.zero,
                                              constraints: const BoxConstraints(),
                                              icon: Icon(Icons.delete_outline, color: darkBlue.withAlpha(180), size: 22),
                                              onPressed: () => cartProvider.removeItem(productId),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          'RP ${item.price.toInt()}',
                                          style: TextStyle(
                                            color: primaryBlue,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: lightBg,
                                            borderRadius: BorderRadius.circular(6),
                                            border: Border.all(color: primaryBlue.withAlpha(60)),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text('-', style: TextStyle(fontSize: 15, color: darkBlue)),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                                child: Text(
                                                  '${item.quantity}',
                                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: darkBlue),
                                                ),
                                              ),
                                              Text('+', style: TextStyle(fontSize: 15, color: darkBlue)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: lightBg,
                    border: Border(top: BorderSide(color: primaryBlue.withAlpha(50))),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total (${cartProvider.items.length} item)',
                            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: darkBlue),
                          ),
                          Text(
                            'RP ${cartProvider.totalAmount.toInt()}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: darkBlue,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        height: 46,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: darkBlue,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            'Checkout',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {},
        type: BottomNavigationBarType.fixed,
        backgroundColor: lightBg,
        selectedItemColor: darkBlue,
        unselectedItemColor: darkBlue.withAlpha(140),
        selectedLabelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: 'Kategori',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}