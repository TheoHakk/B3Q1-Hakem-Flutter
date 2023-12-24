import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';


class Performance extends StatefulWidget {
  const Performance({super.key, required this.title});

  final String title;

  @override
  State<Performance> createState() => _Performance();
}

class _Performance extends State<Performance> {
  @override
  build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: _buildRadialTextPointer(),
          ),
        ],
      ),
    );
  }

  SfRadialGauge _buildRadialTextPointer() {
    const double objectif = 10.0;
    const double actual = 15.0;

    const double actualPointerValue = (actual / objectif) * 60;

    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
            showAxisLine: false,
            showLabels: false,
            showTicks: false,
            startAngle: 180,
            endAngle: 360,
            maximum: 120,
            canScaleToFit: true,
            radiusFactor: 0.79,
            pointers: const <GaugePointer>[
              NeedlePointer(
                  needleEndWidth: 5,
                  needleLength: 0.7,
                  value: actualPointerValue,
                  knobStyle: KnobStyle(knobRadius: 0)),
            ],
            ranges: <GaugeRange>[
              //ça va de 0 à 120
              GaugeRange(
                  startValue: 0,
                  endValue: 40,
                  startWidth: 0.45,
                  endWidth: 0.45,
                  sizeUnit: GaugeSizeUnit.factor,
                  color: const Color(0xFFDD3800)),
              GaugeRange(
                  startValue: 40.5,
                  endValue: 80,
                  startWidth: 0.45,
                  sizeUnit: GaugeSizeUnit.factor,
                  endWidth: 0.45,
                  color: const Color(0xFFFFDF10)),
              GaugeRange(
                  startValue: 80.5,
                  endValue: 120,
                  startWidth: 0.45,
                  endWidth: 0.45,
                  sizeUnit: GaugeSizeUnit.factor,
                  color: const Color(0xFF64BE00)),
            ]),
        RadialAxis(
          showAxisLine: false,
          showLabels: false,
          showTicks: false,
          startAngle: 180,
          endAngle: 360,
          maximum: 120,
          radiusFactor: 0.85,
          canScaleToFit: true,
          pointers: const <GaugePointer>[
            MarkerPointer(
                markerType: MarkerType.text,
                text: 'Insuffisant',
                value: 20.5,
                textStyle: GaugeTextStyle(
                    fontWeight: FontWeight.bold, fontFamily: 'Times'),
                offsetUnit: GaugeSizeUnit.factor,
                markerOffset: -0.12),
            MarkerPointer(
                markerType: MarkerType.text,
                text: 'Dans la moyenne',
                value: 60.5,
                textStyle: GaugeTextStyle(
                    fontWeight: FontWeight.bold, fontFamily: 'Times'),
                offsetUnit: GaugeSizeUnit.factor,
                markerOffset: -0.12),
            MarkerPointer(
                markerType: MarkerType.text,
                text: 'Bon !!',
                value: 100.5,
                textStyle: GaugeTextStyle(
                    fontWeight: FontWeight.bold, fontFamily: 'Times'),
                offsetUnit: GaugeSizeUnit.factor,
                markerOffset: -0.12)
          ],
        ),
      ],
    );
  }
}
