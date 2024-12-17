import 'package:flutter/material.dart';
import '../model/product.dart';
import '../logic/favorites_provider.dart';
import 'package:provider/provider.dart';
import '../logic/cart_provider.dart';

class ProductDetailsPage extends StatelessWidget {
  final Product product;

  const ProductDetailsPage({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Товар'),
        actions: [
          // ... existing code ...
          Consumer<FavoritesProvider>(
            builder: (context, favoritesProvider, child) {
              return IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: favoritesProvider.isFavorite(product) ? Colors.red : Colors.grey,
                ),
                onPressed: () {
                  favoritesProvider.toggleFavorite(product);
                },
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Provider.of<CartProvider>(context, listen: false).addItem(product);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Товар добавлен в корзину'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Изображение товара
            SizedBox(
              width: double.infinity,
              height: 600,
              child: Image.asset(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Название товара
                  Text(
                    product.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Описание товара
                  Text(
                    product.description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Цена
                  Text(
                    '${product.price} ₽',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Кнопка удаления
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Логика удаления товара
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Подтверждение'),
                            content: const Text('Вы уверены, что хотите удалить этот товар?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Отмена'),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Здесь добавить логику удаления
                                  Navigator.pop(context); // Закрыть диалог
                                  Navigator.pop(context); // Вернуться на предыдущий экран
                                },
                                child: const Text(
                                  'Удалить',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        'Удалить товар',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}