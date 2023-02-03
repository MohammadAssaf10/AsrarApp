import 'package:asrar_app/config/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/color_manager.dart';
import '../../../../../config/values_manager.dart';
import '../../../domain/entities/product_entities.dart';
import '../../../../../core/app/functions.dart';
import '../general/cached_network_image_widget.dart';

List<ProductEntities> cartList = [];
double totalProductsPrice = 0;

class ProductWidget extends StatefulWidget {
  ProductWidget({
    super.key,
    required this.product,
  });
  final ProductEntities product;

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  void dispose() {
    cartList.clear();
    super.dispose();
  }

  bool isSelect = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isSelect = !isSelect;
        });
        if (isSelect == true) {
          cartList.add(widget.product);
        } else {
          cartList.remove(widget.product);
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: AppSize.s20.w,
          vertical: AppSize.s8.h,
        ),
        decoration: BoxDecoration(
          color: ColorManager.white,
          border: Border.all(
            color: isSelect ? ColorManager.lightPrimary : ColorManager.grey,
            width: AppSize.s2.w,
          ),
          borderRadius: BorderRadius.circular(AppSize.s20.r),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: CachedNetworkImageWidget(
                image: widget.product.productImageUrl,
                shapeBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorManager.transparent,
                  ),
                  borderRadius: BorderRadius.circular(
                    AppSize.s20.r,
                  ),
                ),
                offset: Offset(0,2),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: AppSize.s12.h),
                child: Text(
                  widget.product.productName,
                  textAlign: TextAlign.center,
                  style: getAlmaraiBoldStyle(
                    fontSize: AppSize.s15.sp,
                    color: ColorManager.darkGrey,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.visible,
                ),
              ),
            ),
            Container(
              height: AppSize.s1_5.h,
              color: ColorManager.grey,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: ColorManager.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(AppSize.s20.r),
                    bottomRight: Radius.circular(AppSize.s20.r),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  "${widget.product.productPrice} ر.س",
                  style: getAlmaraiBoldStyle(
                    fontSize: AppSize.s22.sp,
                    color: ColorManager.darkPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class cartWidget extends StatefulWidget {
  const cartWidget({
    super.key,
    required this.product,
  });
  final ProductEntities product;
  @override
  State<cartWidget> createState() => _cartWidgetState();
}

class _cartWidgetState extends State<cartWidget> {
  int _counter = 1;
  late double totalProductPrice;
  @override
  void initState() {
    totalProductPrice = double.parse(widget.product.productPrice);
    totalProductsPrice += totalProductPrice;
    super.initState();
  }

  @override
  void dispose() {
    totalProductsPrice = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.s110.h,
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        horizontal: AppSize.s10.w,
        vertical: AppSize.s8.h,
      ),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(
          AppSize.s20.r,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: CachedNetworkImageWidget(
              image: widget.product.productImageUrl,
              shapeBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: ColorManager.transparent,
                ),
                borderRadius: BorderRadius.circular(
                  AppSize.s20.r,
                ),
              ),
              offset: Offset(0, 0),
              height: MediaQuery.of(context).size.height,
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: AppSize.s5.w,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      bottom: AppSize.s5.h,
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      widget.product.productName,
                      style: getAlmaraiBoldStyle(
                        fontSize: AppSize.s18.sp,
                        color: ColorManager.primary,
                      ),
                      textAlign: TextAlign.start,
                      maxLines: 4,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "${dp(totalProductPrice, 2)} ر.س",
                      style: getAlmaraiBoldStyle(
                        fontSize: AppSize.s16.sp,
                        color: ColorManager.primary,
                      ),
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Material(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: AppSize.s5.h,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: AppSize.s20.r,
                      backgroundColor: ColorManager.primary,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            ++_counter;
                            totalProductPrice = _counter *
                                stringToDouble(widget.product.productPrice);
                            totalProductsPrice = totalProductsPrice +
                                stringToDouble(widget.product.productPrice);
                          });
                        },
                        icon: Icon(
                          Icons.add,
                          color: ColorManager.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppSize.s5.w),
                      child: Text(
                        "$_counter",
                      ),
                    ),
                    CircleAvatar(
                      radius: AppSize.s20.r,
                      backgroundColor: ColorManager.primary,
                      child: IconButton(
                        onPressed: () {
                          if (_counter > 1) {
                            setState(() {
                              --_counter;
                              totalProductPrice = _counter *
                                  stringToDouble(widget.product.productPrice);
                              totalProductsPrice = totalProductsPrice -
                                  stringToDouble(widget.product.productPrice);
                            });
                          }
                        },
                        icon: Icon(
                          Icons.remove,
                          color: ColorManager.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
