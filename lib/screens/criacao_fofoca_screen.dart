import 'package:flutter/material.dart';
import '../../models/acessorio.dart';
import '../screens/tela_teste_screen.dart';

class CriacaoFofocaScreen extends StatefulWidget {
  const CriacaoFofocaScreen({super.key});

  @override
  State<CriacaoFofocaScreen> createState() => _CriacaoFofocaScreenState();
}

class _CriacaoFofocaScreenState extends State<CriacaoFofocaScreen> {
  final _formKey = GlobalKey<FormState>();

  Acessorio? _selecionadoCabeca;
  bool _corFoiEscolhida = false;
  double _hue = 0;
  bool _mostrarErroCor = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('../assets/fundo.png', fit: BoxFit.cover),
          ),

          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 20,
                ),
                child: Form(
                  key: _formKey,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xffa1c9ff),
                      border: Border.all(
                        width: 4,
                        color: const Color(0xff0047ab),
                      ),
                      borderRadius: BorderRadius.zero,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset('../assets/fofoca_texto.png', height: 120),

                        const SizedBox(height: 10),

                        // previa
                        SizedBox(
                          height: 150,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                  HSVColor.fromAHSV(
                                    1.0,
                                    _hue,
                                    1.0,
                                    1.0,
                                  ).toColor(),
                                  BlendMode.modulate,
                                ),
                                child: Image.asset(
                                  'assets/fofoca_mascara.png',
                                  height: 400,
                                  width: 400,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Image.asset(
                                'assets/fofoca_detalhes.png',
                                height: 400,
                                width: 400,
                                fit: BoxFit.cover,
                              ),
                              // Acessório Selecionado
                              if (_selecionadoCabeca != null)
                                Image.asset(
                                  'assets/acessorios/${_selecionadoCabeca!.nome.toLowerCase()}.png',
                                  height: 400,
                                  width: 400,
                                  fit: BoxFit.cover,
                                ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        //  NOME
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "NOME",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff0047ab),
                            ),
                          ),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'digite aqui...',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Insira o nome!';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 15),

                        //  COR
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "COR",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xff0047ab),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                // Fundo com Gradiente de Cores (Matriz de Matiz)
                                Container(
                                  height: 12,
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 2,
                                    ),
                                    gradient: const LinearGradient(
                                      colors: [
                                        Colors.red,
                                        Colors.yellow,
                                        Colors.green,
                                        Colors.cyan,
                                        Colors.blue,
                                        Color(0xFFFF00FF),
                                        Colors.red,
                                      ],
                                    ),
                                  ),
                                ),
                                // Slider Customizado
                                SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    trackHeight:
                                        0, // Esconde a linha padrão do slider
                                    thumbColor: Colors.white,
                                    overlayColor: Colors.transparent,
                                    thumbShape: const SquareSliderThumbShape(
                                      thumbRadius: 12,
                                    ), // Bolinha Quadrada!
                                  ),
                                  child: Slider(
                                    value: _hue,
                                    min: 0,
                                    max: 360,
                                    onChanged: (value) {
                                      setState(() {
                                        _hue = value;
                                        _corFoiEscolhida = true;
                                        _mostrarErroCor = false;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            if (_mostrarErroCor)
                              const Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Text(
                                  "Selecione uma cor!",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                          ],
                        ),

                        const SizedBox(height: 15),

                        //  ACESSÓRIO
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "ACESSÓRIO",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff0047ab),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children:
                              listaAcessorios
                                  .where((a) => a.categoria == 'cabeca')
                                  .map(
                                    (acessorio) => ChoiceChip(
                                      label: Text(acessorio.nome),
                                      selected: _selecionadoCabeca == acessorio,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero,
                                      ),
                                      onSelected: (selected) {
                                        setState(() {
                                          _selecionadoCabeca =
                                              selected ? acessorio : null;
                                        });
                                      },
                                    ),
                                  )
                                  .toList(),
                        ),

                        const SizedBox(height: 30),

                        //botao CRIAR FOFOCA
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff0047ab),
                              foregroundColor: Colors.white,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 15),
                            ),
                            onPressed: () {
                              bool formOk = _formKey.currentState!.validate();
                              if (!_corFoiEscolhida) {
                                setState(() => _mostrarErroCor = true);
                              }

                              if (formOk && _corFoiEscolhida) {
                                // Pega o nome que o usuário digitou no TextFormField (precisamos adicionar um controller ou salvar o valor)
                                // Como o código original não salvava o nome, vamos mandar um genérico por enquanto
                                // ou você pode adicionar um TextEditingController no TextFormField para pegar o nome real.

                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => const TelaTesteScreen(
                                          nomeFofoca: "Sua Foquinha",
                                        ),
                                  ),
                                );
                              }
                            },
                            child: const Text('criar fofoca'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SquareSliderThumbShape extends SliderComponentShape {
  final double thumbRadius;

  const SquareSliderThumbShape({this.thumbRadius = 10.0});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) =>
      Size.fromRadius(thumbRadius);

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;
    final paint =
        Paint()
          ..color = sliderTheme.thumbColor ?? Colors.white
          ..style = PaintingStyle.fill;

    canvas.drawRect(
      Rect.fromCenter(
        center: center,
        width: thumbRadius * 2,
        height: thumbRadius * 2,
      ),
      paint,
    );

    final strokePaint =
        Paint()
          ..color = Colors.black
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2;

    canvas.drawRect(
      Rect.fromCenter(
        center: center,
        width: thumbRadius * 2,
        height: thumbRadius * 2,
      ),
      strokePaint,
    );
  }
}
