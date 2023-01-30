import 'package:asrar_app/config/styles_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/color_manager.dart';
import '../../../../config/values_manager.dart';
import '../../domain/entities/product_entities.dart';

List<ProductEntities> productsSelectedList = [];

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
    productsSelectedList.clear();
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
          productsSelectedList.add(widget.product);
        } else {
          productsSelectedList.remove(widget.product);
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
            Flexible(
              flex: 4,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.s20.r),
                  boxShadow: [
                    BoxShadow(
                      color: ColorManager.grey,
                      blurRadius: 2.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: CachedNetworkImage(
                  imageUrl: widget.product.productImageUrl,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSize.s20.r),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(
                      color: ColorManager.primary,
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error,
                    color: ColorManager.error,
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(vertical: AppSize.s10.h),
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
            Flexible(
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

class ProductSelectedWidget extends StatefulWidget {
  const ProductSelectedWidget({
    super.key,
    required this.product,
  });
  final ProductEntities product;
  @override
  State<ProductSelectedWidget> createState() => _ProductSelectedWidgetState();
}

class _ProductSelectedWidgetState extends State<ProductSelectedWidget> {
  int _counter = 1;
  late double totalPrice;
  @override
  void initState() {
    totalPrice = double.parse(widget.product.productPrice);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.s90.h,
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
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.s20.r),
                boxShadow: [
                  BoxShadow(
                    color: ColorManager.grey,
                    blurRadius: 2.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: CachedNetworkImage(
                imageUrl: widget.product.productImageUrl,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.s20.r),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(
                    color: ColorManager.primary,
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(
                  Icons.error,
                  color: ColorManager.error,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(
                vertical: AppSize.s12.h,
                horizontal: AppSize.s5.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    widget.product.productName,
                    style: getAlmaraiBoldStyle(
                      fontSize: AppSize.s18.sp,
                      color: ColorManager.primary,
                    ),
                    maxLines: 3,
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                  SizedBox(height: AppSize.s5.h),
                  Text(
                    totalPrice.toStringAsFixed(2),
                    style: getAlmaraiBoldStyle(
                      fontSize: AppSize.s16.sp,
                      color: ColorManager.primary,
                    ),
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.visible,
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
                            _counter++;
                            totalPrice +=
                                double.parse(widget.product.productPrice);
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
                              _counter--;
                              totalPrice -=
                                  double.parse(widget.product.productPrice);
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
