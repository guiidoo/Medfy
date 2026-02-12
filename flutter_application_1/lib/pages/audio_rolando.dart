import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_application_1/Config/app_colors.dart';

class AudioRolando extends StatefulWidget {
  final String url;
  final String nome;
  final String categoria;
  final String? img;

  const AudioRolando({
    super.key,
    required this.url,
    required this.nome,
    required this.categoria,
    this.img,
  });

  @override
  State<AudioRolando> createState() => _AudioRolandoState();
}

class _AudioRolandoState extends State<AudioRolando> {
  final AudioPlayer _player = AudioPlayer();
  bool tocando = false;
  Duration duracao = Duration.zero;
  Duration posicao = Duration.zero;

  final Color verdePrincipal = const Color(0xFF7A9591);

  @override
  void initState() {
    super.initState();
    _iniciar();
  }

  Future<void> _iniciar() async {
    _player.onDurationChanged.listen((d) {
      setState(() => duracao = d);
    });

    _player.onPositionChanged.listen((p) {
      setState(() => posicao = p);
    });

    _player.onPlayerComplete.listen((event) async {
      await _player.seek(Duration.zero);
      await _player.resume();
      setState(() => posicao = Duration.zero);
    });

    await _player.play(UrlSource(widget.url));
    setState(() => tocando = true);
  }

  Future<void> _playPause() async {
    if (tocando) {
      await _player.pause();
    } else {
      await _player.resume();
    }
    setState(() => tocando = !tocando);
  }

  String formatarTempo(Duration d) {
    String doisDigitos(int n) => n.toString().padLeft(2, '0');
    final min = doisDigitos(d.inMinutes.remainder(60));
    final sec = doisDigitos(d.inSeconds.remainder(60));
    return "$min:$sec";
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 224, 240, 224),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: widget.img != null && widget.img!.isNotEmpty
                  ? NetworkImage(widget.img!)
                  : const AssetImage("assets/fundo.jpg") as ImageProvider,
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,

                child: Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(top: 40, left: 20),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      widget.categoria,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // 🔹 Imagem de fundo

                      // 🔹 Título do áudio
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          widget.nome,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // 🔹 Player (slider + botões)
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        padding: const EdgeInsets.symmetric(
                          vertical: 30,
                          horizontal: 20,
                        ),
                        decoration: BoxDecoration(
                          color: verdePrincipal.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Column(
                          children: [
                            Slider(
                              value: posicao.inSeconds.toDouble(),
                              max: duracao.inSeconds.toDouble() > 0
                                  ? duracao.inSeconds.toDouble()
                                  : 1,
                              activeColor: AppColors.amareloMenu,
                              inactiveColor: Colors.white54,
                              onChanged: (value) async {
                                final pos = Duration(seconds: value.toInt());
                                await _player.seek(pos);
                              },
                            ),
                            Text(
                              "${formatarTempo(posicao)} / ${formatarTempo(duracao)}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 20),
                            IconButton(
                              icon: Icon(
                                tocando
                                    ? Icons.pause_circle
                                    : Icons.play_circle,
                                size: 80,
                                color: Colors.white,
                              ),
                              onPressed: _playPause,
                            ),
                            const SizedBox(height: 20),
                            TextButton.icon(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                              label: const Text(
                                "Voltar",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 50), // espaço extra pro final
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
