import 'package:flutter/material.dart';
import 'features/catalogo/domain/entities/producto.dart';
import 'features/catalogo/domain/repositories/producto_repository.dart';
import 'features/catalogo/presentation/viewmodels/catalogo_viewmodel.dart';
import 'features/catalogo/presentation/views/catalogo_page.dart';
import 'shared/theme/app_theme.dart';

class MockProductoRepository implements ProductoRepository {
  @override
  Future<List<Producto>> obtenerProductos() async {
    await Future.delayed(const Duration(seconds: 1));
    return const [
      Producto(id: '1', nombre: 'Laptop Gamer UPT i7 16GB', precio: 4500.0),
      Producto(id: '2', nombre: 'Smartphone Android 14 OLED', precio: 1800.0),
      Producto(id: '3', nombre: 'Audífonos Inalámbricos Pro', precio: 350.0),
      Producto(id: '4', nombre: 'Monitor 4K 27" IPS 144Hz', precio: 1250.0),
      Producto(id: '5', nombre: 'Teclado Mecánico RGB Red', precio: 280.0),
    ];
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = MockProductoRepository();
    final viewModel = CatalogoViewModel(repository: repository)..cargarProductos();

    return MaterialApp(
      title: 'Catálogo SI-988 - Grupo 03',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: CatalogoPage(viewModel: viewModel),
    );
  }
}
