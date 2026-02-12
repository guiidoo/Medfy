import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // ← Importante para controle de orientação
import 'package:flutter_application_1/Config/app_scroll_card.dart';
import 'package:flutter_application_1/Config/video_play_list.dart';
import 'package:flutter_application_1/pages/hub_page_view.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class EtapaMeditacao {
  final String titulo;
  final String descricao;

  EtapaMeditacao({required this.titulo, required this.descricao});
}

class PagEquilibrio extends StatefulWidget {
  const PagEquilibrio({super.key});

  @override
  State<PagEquilibrio> createState() => _PagEquilibrioState();
}

class _PagEquilibrioState extends State<PagEquilibrio> {
  final List<EtapaMeditacao> instrucoes = [
    EtapaMeditacao(
      titulo: "O Centro Silencioso",
      descricao:
          "O equilíbrio nasce quando você encontra um ponto interno que permanece firme mesmo quando tudo ao redor muda.",
    ),
    EtapaMeditacao(
      titulo: "Entre o Fazer e o Ser",
      descricao:
          "Viver em equilíbrio é alternar entre agir e simplesmente estar. Há momentos de movimento e momentos de pausa, e ambos são essenciais para a harmonia.",
    ),
    EtapaMeditacao(
      titulo: "O Corpo que Ensina",
      descricao:
          "O corpo inspira, expira, contrai e relaxa naturalmente. Segui-lo nos mostra que equilíbrio é fluidez, o vai e vem da vida acontecendo sem resistência.",
    ),
    EtapaMeditacao(
      titulo: "A Calma em Meio ao Caos",
      descricao:
          "Mesmo quando tudo parece instável, o equilíbrio pode permanecer dentro de você. Não depende das circunstâncias.",
    ),
    EtapaMeditacao(
      titulo: "O Retorno ao Essencial",
      descricao:
          "Equilíbrio é lembrar-se de quem você é. Não é buscar algo novo, mas retornar ao que sempre esteve aí: presença, serenidade e confiança, em sintonia com a vida.",
    ),
  ];

  final Color fundoClaro = const Color(0xFFEBE8E0);
  final Color verdePrincipal = const Color(0xFF7A9591);
  final Color verdeBotao = Colors.grey[400]!;
  final Color verdeContorno = const Color(0xFFA4A4A4);

  @override
  void initState() {
    super.initState();
    // 🔒 Bloqueia a tela apenas na vertical
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    // 🔄 Libera novamente ao sair da tela (boa prática)
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final largura = MediaQuery.of(context).size.width;
    final altura = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: verdePrincipal,
      body: SafeArea(
        child: Column(
          children: [
            // TOPO
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
              color: verdePrincipal,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: fundoClaro),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Encontre a harmonia entre corpo, mente e espírito através da meditação do equilíbrio.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: fundoClaro,
                      fontSize: largura * 0.040,
                      fontWeight: FontWeight.w500,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),

            // CORPO
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: fundoClaro,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // BOTÕES
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const HubPageView(initialIndex: 0),
                                  ),
                                  (route) => false,
                                );
                              },
                              child: _actionButton(
                                icon: CupertinoIcons.house_fill,
                                text: "Home",
                                backgroundColor: verdeBotao,
                                borderColor: verdeContorno,
                                iconTextColor: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const HubPageView(initialIndex: 2),
                                  ),
                                  (route) => false,
                                );
                              },
                              child: _actionButton(
                                icon: CupertinoIcons.music_note_2,
                                text: "relaxar",
                                backgroundColor: verdeBotao,
                                borderColor: verdeContorno,
                                iconTextColor: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),

                      Text(
                        "Passos para alcançar o equilíbrio interior",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: verdePrincipal,
                        ),
                      ),
                      const SizedBox(height: 20),

                      AppScrollCard<EtapaMeditacao>(
                        items: instrucoes,
                        height: altura * 0.35,
                        activeDotColor: verdePrincipal,
                        inactiveDotColor: Colors.grey[400]!,
                        itemBuilder: (etapa) {
                          return Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 6,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  etapa.titulo,
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: verdePrincipal,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  etapa.descricao,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    height: 1.4,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 30),

                      // 🎥 VÍDEOS
                      ...VideoPlayList.videoListEquilibrio.map((video) {
                        return YoutubeVideoCard(
                          videoUrl: video["videoUrl"]!,
                          title: video["title"]!,
                          subtitle: video["subtitle"]!,
                        );
                      }),

                      const SizedBox(height: 20),
                      const Center(
                        child: Text(
                          "Permaneça em equilíbrio, respirando com leveza e deixando a paz fluir através de cada instante.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            color: Colors.blueGrey,
                            height: 1.4,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionButton({
    required IconData icon,
    required String text,
    required Color backgroundColor,
    required Color borderColor,
    required Color iconTextColor,
  }) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor, width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: iconTextColor, size: 26),
          const SizedBox(width: 15),
          Text(
            text,
            style: TextStyle(
              color: iconTextColor,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}

// --- CARD DE VÍDEO ---
class YoutubeVideoCard extends StatefulWidget {
  final String videoUrl;
  final String title;
  final String subtitle;

  const YoutubeVideoCard({
    super.key,
    required this.videoUrl,
    required this.title,
    required this.subtitle,
  });

  @override
  State<YoutubeVideoCard> createState() => _YoutubeVideoCardState();
}

class _YoutubeVideoCardState extends State<YoutubeVideoCard> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);
    _controller =
        YoutubePlayerController(
          initialVideoId: videoId ?? "",
          flags: const YoutubePlayerFlags(autoPlay: false, enableCaption: true),
        )..addListener(() async {
          // 🔄 Detecta entrada e saída do modo tela cheia
          if (_controller.value.isFullScreen) {
            // 👉 Libera rotação horizontal ao entrar em tela cheia
            await SystemChrome.setPreferredOrientations([
              DeviceOrientation.landscapeLeft,
              DeviceOrientation.landscapeRight,
            ]);
          } else {
            // 🔒 Volta a travar na vertical ao sair
            await SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
              DeviceOrientation.portraitDown,
            ]);
          }
        });
  }

  @override
  void dispose() {
    _controller.dispose();
    // 🔒 Garante que volte à orientação normal
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
              ),
              const SizedBox(height: 8),
              Text(
                widget.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[700], fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
