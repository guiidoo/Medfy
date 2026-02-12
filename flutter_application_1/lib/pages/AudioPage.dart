import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_application_1/Config/play_list.dart';
import 'audio_rolando.dart';
import '../widgets/custom_card.dart';

class AudioPage extends StatefulWidget {
  final bool temaEscuro;
  final VoidCallback? onTrocarTema;

  const AudioPage({super.key, this.temaEscuro = false, this.onTrocarTema});

  @override
  State<AudioPage> createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? audioTocando;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final largura = MediaQuery.of(context).size.width;
    final altura = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFEBE8E0),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: largura * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCabecalho(largura),
                SizedBox(height: altura * 0.01),
                _buildCategoria("Natureza", PlayList.naturezaList, altura),
                SizedBox(height: altura * 0.03),
                _buildCategoria(
                  "Ruidos terapêuticos",
                  PlayList.musicasList,
                  altura,
                ),
                SizedBox(height: altura * 0.03),
                Container(
                  margin: EdgeInsets.only(bottom: 200),
                  child: _buildCategoria(
                    "Meditação",
                    PlayList.meditationList,
                    altura,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCabecalho(double largura) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: largura * 0.02,
        vertical: largura * 0.05,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: largura * 0.07,
            backgroundColor: Colors.transparent,
          ),
          SizedBox(width: largura * 0.1),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Silencie o mundo.",
                style: TextStyle(
                  color: const Color(0xFFA0C8C0),
                  fontSize: largura * 0.045,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Ouça a si mesmo.",
                style: TextStyle(
                  color: const Color(0xFF748D88),
                  fontSize: largura * 0.06,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      offset: const Offset(1.5, 1.5),
                      blurRadius: 3,
                      color: Colors.blue[200]!,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Agora recebe 'altura' para usar no SizedBox adicionado ao final de cada card
  Widget _buildCategoria(
    String titulo,
    List<Map<String, String>> lista,
    double altura,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titulo,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        // Ajustei a altura para comportar também o SizedBox(height: altura * 0.20) de cada item
        SizedBox(
          height: 150,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: lista.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final item = lista[index];
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomCard(
                    text: item["text"]!,
                    img: item["img"],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AudioRolando(
                            url: item["url"]!,
                            nome: item["text"]!,
                            categoria: titulo,
                            img: item["img"],
                          ),
                        ),
                      );
                    },
                  ),
                  // adicionado no final de cada card, como você pediu
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
