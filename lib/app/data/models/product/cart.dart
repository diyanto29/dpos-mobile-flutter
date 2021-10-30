import 'package:equatable/equatable.dart';
import 'package:warmi/app/data/models/discount/discount.dart';
import 'package:warmi/app/data/models/product/product.dart';

abstract class Cart extends Equatable{
  DataProduct? dataProduct;
  int? qty;
  int? subTotal;
  DataDiscount? discount;

}


class CartModel implements Cart{
  @override
  DataProduct? dataProduct;

  @override
  DataDiscount? discount;

  @override
  int? qty;

  @override
  int? subTotal;

  CartModel({this.dataProduct, this.discount, this.qty, this.subTotal});

  @override
  // TODO: implement props
  List<Object?> get props => [dataProduct];

  @override
  // TODO: implement stringify
  bool? get stringify => false;
}