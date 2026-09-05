import '../../domain/entities/producto.dart';
import '../models/producto_model.dart';

class ProductoMapper {
  static Producto toEntity(ProductoModel model) {
    return Producto(
      id: model.id,
      nombre: model.title,
      precio: model.price,
    );
  }

  static ProductoModel toModel(Producto entity) {
    return ProductoModel(
      id: entity.id,
      title: entity.nombre,
      price: entity.precio,
    );
  }
}
