import 'package:flutter/material.dart';
import 'package:flutter_audio_waveforms/flutter_audio_waveforms.dart';
import 'package:flutter_audio_waveforms/waveforms/rectangle_waveform/active_waveform_painter.dart';
import 'package:flutter_audio_waveforms/waveforms/rectangle_waveform/inactive_waveform_painter.dart';

class RectangleWaveform extends AudioWaveform {
  const RectangleWaveform({
    Key? key,
    required List<double> samples,
    required double height,
    required double width,
    required Duration maxDuration,
    required Duration elapsedDuration,
    this.activeColor = Colors.red,
    this.inactiveColor = Colors.blue,
    this.activeGradient,
    this.inactiveGradient,
    this.borderWidth = 1.0,
    this.activeBorderColor = Colors.white,
    this.inactiveBorderColor = Colors.white,
    bool showActiveWaveform = true,
    bool absolute = false,
    bool invert = false,
  }) : super(
          key: key,
          samples: samples,
          height: height,
          width: width,
          maxDuration: maxDuration,
          elapsedDuration: elapsedDuration,
          showActiveWaveform: showActiveWaveform,
          absolute: absolute,
          invert: invert,
        );
  final Color activeColor;
  final Color inactiveColor;
  final Gradient? activeGradient;
  final Gradient? inactiveGradient;
  final double borderWidth;
  final Color activeBorderColor;
  final Color inactiveBorderColor;

  @override
  AudioWaveformState<RectangleWaveform> createState() =>
      _RectangleWaveformState();
}

class _RectangleWaveformState extends AudioWaveformState<RectangleWaveform> {
  @override
  Widget build(BuildContext context) {
    if (widget.samples.isEmpty) {
      return const SizedBox.shrink();
    }
    final processedSamples = this.processedSamples;
    final activeSamples = this.activeSamples;
    final activeIndex = this.activeIndex;
    final showActiveWaveform = this.showActiveWaveform;
    final waveformAlign = this.waveformAlign;

    return Stack(
      children: [
        RepaintBoundary(
          child: CustomPaint(
            size: Size(widget.width, widget.height),
            isComplex: true,
            painter: RectangleInActiveWaveformPainter(
              samples: processedSamples,
              color: widget.inactiveColor,
              gradient: widget.inactiveGradient,
              waveformAlign: waveformAlign,
              borderColor: widget.inactiveBorderColor,
              borderWidth: widget.borderWidth,
              sampleWidth: sampleWidth,
            ),
          ),
        ),
        if (showActiveWaveform)
          CustomPaint(
            size: Size(widget.width, widget.height),
            isComplex: true,
            painter: RectangleActiveWaveformPainter(
              samples: processedSamples,
              activeIndex: activeIndex,
              color: widget.activeColor,
              activeSamples: activeSamples,
              gradient: widget.activeGradient,
              waveformAlign: widget.waveformAlign,
              borderColor: widget.activeBorderColor,
              borderWidth: widget.borderWidth,
              sampleWidth: sampleWidth,
            ),
          ),
      ],
    );
  }
}
