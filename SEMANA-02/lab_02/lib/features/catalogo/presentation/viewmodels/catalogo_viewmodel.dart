import 'package:flutter/foundation.dart';
import '../../domain/entities/producto.dart';
import '../../domain/repositories/producto_repository.dart';
import '../states/ui_state.dart';

class CatalogoViewModel extends ChangeNotifier {
  final ProductoRepository repository;

  UiState<List<Producto>> _state = UiStateLoading();
  UiState<List<Producto>> get state => _state;

  CatalogoViewModel({required this.repository});

  Future<void> cargarProductos() async {
    _state = UiStateLoading();
    notifyListeners();

    try {
      final productos = await repository.obtenerProductos();
      if (productos.isEmpty) {
        _state = UiStateEmpty();
      } else {
        _state = UiStateSuccess(productos);
      }
    } catch (e) {
      _state = UiStateError(
        'Error al obtener productos: ${e.toString()}',
        retry: () => cargarProductos(),
      );
    }
    notifyListeners();
  }
}
