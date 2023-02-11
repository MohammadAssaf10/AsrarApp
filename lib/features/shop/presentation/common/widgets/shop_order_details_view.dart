import 'package:asrar_app/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/color_manager.dart';
import '../../../../../config/strings_manager.dart';
import '../../../../../config/styles_manager.dart';
import '../../../../../config/values_manager.dart';
import '../../../../home/presentation/widgets/general/cached_network_image_widget.dart';
import '../../../domain/entities/shop_order_entities.dart';

class ShopOrederDetailsView extends StatelessWidget {
  const ShopOrederDetailsView(this.shopOrder);
  final ShopOrderEntities shopOrder;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${AppStrings.orderNumber.tr(context)} ${shopOrder.shopOrderId.toString()}"),
      ),
      body: ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: shopOrder.products.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: AppSize.s90.h,
            margin: EdgeInsets.symmetric(
              horizontal: AppSize.s8.w,
              vertical: AppSize.s8.h,
            ),
            decoration: ShapeDecoration(
              color: ColorManager.white,
              shape: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(
                  AppSize.s18.r,
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: CachedNetworkImageWidget(
                    image: shopOrder.products[index].productImageUrl,
                    shapeBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(
                        AppSize.s18.r,
                      ),
                    ),
                    offset: Offset(0, 0),
                    height: MediaQuery.of(context).size.height,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: AppSize.s5.w,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${AppStrings.productName.tr(context)}: ${shopOrder.products[index].productName}",
                          style: getAlmaraiBoldStyle(
                            fontSize: AppSize.s17.sp,
                            color: ColorManager.primary,
                          ),
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: AppSize.s5.h),
                        Text(
                          "${AppStrings.productPrice.tr(context)}: ${shopOrder.products[index].productPrice} ر.س",
                          style: getAlmaraiBoldStyle(
                            fontSize: AppSize.s17.sp,
                            color: ColorManager.primary,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: AppSize.s5.h),
                        Text(
                          "${AppStrings.number.tr(context)}: ${shopOrder.products[index].productCount}",
                          style: getAlmaraiBoldStyle(
                            fontSize: AppSize.s17.sp,
                            color: ColorManager.primary,
                          ),
                          textAlign: TextAlign.start,
                          textDirection: TextDirection.rtl,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
