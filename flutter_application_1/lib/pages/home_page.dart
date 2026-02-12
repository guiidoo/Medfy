import 'dart:async';
import 'package:flutter_application_1/chat_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Config/play_list.dart';
import '../widgets/custom_card.dart';
import '../widgets/custom_card_meditar.dart';
import 'audio_rolando.dart';

// Import das páginas de meditação
import 'package:flutter_application_1/pages/sub_pages_meditar/introducao/pag_respiracao.dart';
import 'package:flutter_application_1/pages/sub_pages_meditar/introducao/pag_relaxar.dart';
import 'package:flutter_application_1/pages/sub_pages_meditar/introducao/pag_aprenda_meditacao.dart';
import 'package:flutter_application_1/pages/sub_pages_meditar/meditacao_avancada/pag_mente_corpo.dart';

// 1. CONSTANTES DE COR DECLARADAS GLOBALMENTE (OU EM UM TEMA)
// Este é o local correto para as constantes para evitar erros de compilação
const Color _cardColor = Color(0xFFC5E0D7); // Verde pastel claro e suave
const Color _primaryTextColor = Color(
  0xFF3B5249,
); // Verde escuro para texto (Alto contraste)
const Color _ctaColor = Color(
  0xFF5A7F75,
); // Um verde-médio para destaque da ação
const Color _appNameColor = Color(0xFF4A4A4A); // Cor para o texto "Medfy"

class HomePage extends StatefulWidget {
  final bool temaEscuro;
  final VoidCallback? onTrocarTema;

  // O construtor foi ajustado para usar chaves e a palavra-chave super.key
  const HomePage({super.key, this.temaEscuro = false, this.onTrocarTema});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final double cardHeight = 150;

  final List<Map<String, dynamic>> meditarIntroCards = [
    {
      "text": "Respiração",
      "page": const PagRespiracao(),
      "image":
          "https://cdn.pixabay.com/photo/2018/08/16/02/01/purple-3609478_1280.jpg",
    },
    {
      "text": "Relaxamento",
      "page": const PagRelaxar(),
      "image":
          "https://cdn.pixabay.com/photo/2017/12/17/21/44/drink-3025022_1280.jpg",
    },
    {
      "text": "Comece a Meditar",
      "page": const PagAprendaMeditacao(),
      "image":
          "https://cdn.pixabay.com/photo/2020/06/29/17/41/meditate-5353620_1280.jpg",
    },
  ];

  // 2. WIDGET QUE CONSTRÓI O CARD DE CHAT DA IA (Função auxiliar)
  Widget _buildAiChatCard(double largura) {
    return Padding(
      // Padding externo que controla a margem do card na tela
      padding: EdgeInsets.symmetric(horizontal: largura * 0.05, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Texto "Medfy"
          const Text(
            "Medfy",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              // Usamos a cor _appNameColor definida globalmente
              color: _appNameColor,
            ),
          ),
          const SizedBox(height: 12),

          // CARD PRINCIPAL: Usando Card e InkWell para um design mais bonito
          Card(
            elevation: 4.0, // Sombra suave (cria efeito de flutuação)
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16), // Bordas arredondadas
            ),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              // Adiciona o efeito visual de toque (ripple/splash)
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    // Certifique-se de que ChatPage está importada
                    builder: (context) => const ChatPage(),
                  ),
                );
              },
              // Container interno para cor e layout
              child: Container(
                width: double.infinity,
                color: _cardColor, // Cor pastel do card
                padding: const EdgeInsets.all(18), // Padding interno uniforme

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 2. Linha do Ícone e Texto Principal
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Ícone (Bem-estar/Meditação) para enriquecer o visual
                        Icon(Icons.spa_rounded, color: _ctaColor, size: 24),
                        const SizedBox(width: 12),
                        Expanded(
                          child: const Text(
                            'Tire dúvidas sobre meditação e áudios.',
                            style: TextStyle(
                              color: _primaryTextColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // 3. CTA (Chamada para Ação) em Destaque
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Toque para conversar",
                          style: TextStyle(
                            color: _ctaColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 16,
                          color: _ctaColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double largura = MediaQuery.of(context).size.width;
    double altura = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFEBE8E0),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cabeçalho
              Padding(
                padding: EdgeInsets.all(largura * 0.05),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: widget.onTrocarTema,
                      child: CircleAvatar(
                        radius: largura * 0.07,
                        backgroundColor: Colors.transparent,
                        backgroundImage: const AssetImage('assets/logo.png'),
                      ),
                    ),
                    SizedBox(width: largura * 0.03),
                    Padding(
                      padding: EdgeInsets.only(left: largura * 0.05),
                      child: Column(
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
                    ),
                  ],
                ),
              ),

              SizedBox(height: altura * 0.02),

              // Imagem principal
              Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.zero,
                    child: Image.network(
                      'https://img.freepik.com/fotos-premium/uma-rosa-esta-florescendo-no-jardim_553012-2774.jpg',
                      width: double.infinity,
                      height: altura * 0.25,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: double.infinity,
                          height: altura * 0.25,
                          color: Colors.grey[300],
                          alignment: Alignment.center,
                          child: const Text(
                            'Erro ao carregar imagem',
                            style: TextStyle(color: Colors.black54),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 105,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "Entre o som e o nada.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: largura * 0.04,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: altura * 0.04),

              // Categoria: Introdução à Meditação (CustomCardMeditar)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: largura * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Introdução à Meditação",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: cardHeight,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 12),
                        itemCount: meditarIntroCards.length,
                        itemBuilder: (context, index) {
                          final item = meditarIntroCards[index];
                          return CustomCardMeditar(
                            text: item["text"]!,
                            imagePath: item["image"]!,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => item["page"]!,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: altura * 0.04),

              // Categoria: Ruídos Terapêuticos (CustomCard)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: largura * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Ruídos terapêuticos",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: cardHeight,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 12),
                        itemCount: PlayList.musicasList.length,
                        itemBuilder: (context, index) {
                          final item = PlayList.musicasList[index];
                          return CustomCard(
                            text: item["text"]!,
                            img: item["img"],
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => AudioRolando(
                                    url: item["url"]!,
                                    nome: item["text"]!,
                                    categoria: "Ruídos terapêuticos",
                                    img: item["img"],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: altura * 0.04),

              _buildAiChatCard(largura),

              SizedBox(height: altura * 0.20),
            ],
          ),
        ),
      ),
    );
  }
}
