import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/color_manager.dart';
import '../../../../../config/styles_manager.dart';
import '../../../../../config/values_manager.dart';
import '../../../../../core/app/functions.dart';
import '../../../../home/presentation/widgets/general/cached_network_image_widget.dart';
import '../../../domain/entities/product_entities.dart';
import '../function.dart';

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
  late double totalProductPrice;
  @override
  void initState() {
    totalProductPrice = stringToDouble(widget.product.productPrice);
    super.initState();
  }

  @override
  void dispose() {
    cartList.forEach((product) {
      product.productCount = 1;
    });
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
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
                  SizedBox(height: AppSize.s4.h),
                  Text(
                    "${dp(totalProductPrice, 2)} ر.س",
                    style: getAlmaraiBoldStyle(
                      fontSize: AppSize.s16.sp,
                      color: ColorManager.primary,
                    ),
                    textAlign: TextAlign.start,
                    textDirection: TextDirection.rtl,
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
                            widget.product.productCount++;
                            totalProductPrice = widget.product.productCount *
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
                        widget.product.productCount.toString(),
                      ),
                    ),
                    CircleAvatar(
                      radius: AppSize.s20.r,
                      backgroundColor: ColorManager.primary,
                      child: IconButton(
                        onPressed: () {
                          if (widget.product.productCount > 1) {
                            setState(() {
                              widget.product.productCount--;
                              totalProductPrice = widget.product.productCount *
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
