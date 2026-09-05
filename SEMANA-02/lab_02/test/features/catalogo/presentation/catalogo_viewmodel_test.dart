import 'package:flutter_test/flutter_test.dart';
import 'package:lab_02/features/catalogo/domain/entities/producto.dart';
import 'package:lab_02/features/catalogo/domain/repositories/producto_repository.dart';
import 'package:lab_02/features/catalogo/presentation/states/ui_state.dart';
import 'package:lab_02/features/catalogo/presentation/viewmodels/catalogo_viewmodel.dart';

class FakeProductoRepository implements ProductoRepository {
  List<Producto>? respuesta;
  Object? errorSimulado;

  FakeProductoRepository({this.respuesta, this.errorSimulado});

  @override
  Future<List<Producto>> obtenerProductos() async {
    if (errorSimulado != null) {
      throw errorSimulado!;
    }
    return respuesta ?? [];
  }
}

void main() {
  group('CatalogoViewModel Unit Tests (Sin Emulador)', () {
    test('1. Emite Loading y luego Success cuando el repositorio retorna datos', () async {
      final fakeRepo = FakeProductoRepository(
        respuesta: [const Producto(id: '1', nombre: 'Laptop Gamer UPT', precio: 4500.0)],
      );
      final vm = CatalogoViewModel(repository: fakeRepo);

      expect(vm.state, isA<UiStateLoading>());
      await vm.cargarProductos();
      expect(vm.state, isA<UiStateSuccess<List<Producto>>>());
      
      final successState = vm.state as UiStateSuccess<List<Producto>>;
      expect(successState.data.length, 1);
      expect(successState.data.first.nombre, 'Laptop Gamer UPT');
    });

    test('2. Emite Empty cuando el repositorio retorna una lista vacía', () async {
      final fakeRepo = FakeProductoRepository(respuesta: []);
      final vm = CatalogoViewModel(repository: fakeRepo);

      await vm.cargarProductos();
      expect(vm.state, isA<UiStateEmpty<List<Producto>>>());
    });

    test('3. Emite Error con acción de reintento cuando ocurre un fallo', () async {
      final fakeRepo = FakeProductoRepository(errorSimulado: Exception('Falla de red'));
      final vm = CatalogoViewModel(repository: fakeRepo);

      await vm.cargarProductos();
      expect(vm.state, isA<UiStateError<List<Producto>>>());

      final errorState = vm.state as UiStateError<List<Producto>>;
      expect(errorState.retry, isNotNull);
    });
  });
}
