import 'package:flutter/material.dart';
import 'package:red_zone/common/widgets/custom_shapes/curved_edges/curved_edges.dart';

class TPreviousDisasterCurvedEdgeWidget extends StatelessWidget {
  const TPreviousDisasterCurvedEdgeWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TCustomCurvedEdges(),
      child: child,
    );
  }
}
