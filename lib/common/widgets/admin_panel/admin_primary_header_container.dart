import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../custom_shapes/containers/circular_container.dart';
import '../custom_shapes/curved_edges/curved_edges_widget.dart';

class TAdminPrimaryHeaderContainer extends StatelessWidget {
  const TAdminPrimaryHeaderContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TCustomCurvedWidget(
      child: Container(
        color: Colors.red.shade800,
        padding: const EdgeInsets.only(bottom: 0),

        /// -- If [size.isFinite': is not true.in stack] error occurred -> Read README.md file
        //constraints: const BoxConstraints(minHeight: 400),

        child: Stack(
          children: [
            Positioned(top: -150, right: -250, child: TCircularContainer(backgroundColor: TColors.textWhite.withOpacity(0.1))),
            Positioned(top: 100, right: -300, child: TCircularContainer(backgroundColor: TColors.textWhite.withOpacity(0.1))),
            child,
          ],
        ),
      ),
    );
  }
}
