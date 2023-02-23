import 'package:flutter/material.dart';
import 'WaveWidget.dart';
import 'CustomConfig.dart';

class WaveDemoHomePage extends StatefulWidget {
  WaveDemoHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WaveDemoHomePageState createState() => _WaveDemoHomePageState();
}

class _WaveDemoHomePageState extends State<WaveDemoHomePage> {
  _buildCard({
    Config config,
    Color backgroundColor = Colors.transparent,
    DecorationImage backgroundImage,
    double height = 300.0,
  }) {
    return Container(
      height: height,
      width: double.infinity,
      child: WaveWidget(
        config: config,
        backgroundColor: backgroundColor,
        backgroundImage: backgroundImage,
        size: Size(double.infinity, double.infinity),
        waveAmplitude: 0,
      ),
    );
  }

  MaskFilter _blur;
  final List<MaskFilter> _blurs = [
    null,
    MaskFilter.blur(BlurStyle.normal, 10.0),
    MaskFilter.blur(BlurStyle.inner, 10.0),
    MaskFilter.blur(BlurStyle.outer, 10.0),
    MaskFilter.blur(BlurStyle.solid, 16.0),
  ];
  int _blurIndex = 0;
  MaskFilter _nextBlur() {
    if (_blurIndex == _blurs.length - 1) {
      _blurIndex = 0;
    } else {
      _blurIndex = _blurIndex + 1;
    }
    _blur = _blurs[_blurIndex];
    return _blurs[_blurIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 10.0,
        backgroundColor: Colors.blueGrey[800],
        actions: <Widget>[
          IconButton(
            icon: Icon(_blur == null ? Icons.blur_off : Icons.blur_on),
            onPressed: () {
              setState(() {
                _blur = _nextBlur();
              });
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildCard(
            backgroundColor: Colors.transparent,
            config: CustomConfig(
              // gradients: [
              //   [Colors.red, Color(0xEEF44336)],
              //   [Colors.red[800], Color(0x77E57373)],
              //   [Colors.orange, Color(0x66FF9800)],
              //   [Colors.yellow, Color(0x55FFEB3B)]
              // ],
              // durations: [35000, 19440, 10800, 6000],
              // heightPercentages: [0.25, 0.33, 0.41, 0.43],
              gradients: [
                //[Colors.red, Color(0xEEF44336)],
                //[Colors.red[800], Color(0x77E57373)],
                [Colors.transparent,Colors.transparent],
                [Colors.transparent,Colors.transparent],
                [Colors.orange, Color(0x66FF9800)],
                [Colors.yellow, Color(0x55FFEB3B)]
              ],
              durations: [35000, 19440, 19400, 6000],
              heightPercentages: [0.25, 0.33, 0.38, 0.45],
              blur: _blur,
              gradientBegin: Alignment.bottomLeft,
              gradientEnd: Alignment.topRight,
            ),
          ),
        ],
      ),
    );
  }
}