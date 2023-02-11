import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/color_manager.dart';
import '../../../../../config/styles_manager.dart';
import '../../../../../config/values_manager.dart';
import '../../../domain/entities/product_entities.dart';
import '../../../../home/presentation/widgets/general/cached_network_image_widget.dart';
import '../function.dart';


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
                offset: Offset(0, 2),
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
                  textDirection: TextDirection.rtl,
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
