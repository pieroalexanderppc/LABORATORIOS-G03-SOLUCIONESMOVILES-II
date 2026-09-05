import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab_02/features/catalogo/domain/entities/producto.dart';
import 'package:lab_02/features/catalogo/domain/repositories/producto_repository.dart';
import 'package:lab_02/features/catalogo/presentation/viewmodels/catalogo_viewmodel.dart';
import 'package:lab_02/features/catalogo/presentation/views/catalogo_page.dart';

class SyncProductoRepository implements ProductoRepository {
  @override
  Future<List<Producto>> obtenerProductos() async {
    return [const Producto(id: '1', nombre: 'Laptop Gamer UPT', precio: 4500.0)];
  }
}

void main() {
  testWidgets('Carga inicial del catalogo muestra el titulo', (WidgetTester tester) async {
    final repo = SyncProductoRepository();
    final vm = CatalogoViewModel(repository: repo);

    await tester.pumpWidget(MaterialApp(home: CatalogoPage(viewModel: vm)));
    expect(find.text('Catálogo de Productos'), findsOneWidget);
  });
}
