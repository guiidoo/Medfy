import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/pages/sub_pages_meditar/meditacao_avancada/pag_mente_corpo.dart';
import 'package:flutter_application_1/widgets/custom_card_meditar.dart';
import 'package:flutter_application_1/pages/sub_pages_meditar/introducao/pag_respiracao.dart';
import 'package:flutter_application_1/pages/sub_pages_meditar/introducao/pag_aprenda_meditacao.dart';
import 'package:flutter_application_1/pages/sub_pages_meditar/introducao/pag_relaxar.dart';
import 'package:flutter_application_1/pages/sub_pages_meditar/novo_ciclo/pag_equilibrio.dart';
import 'package:flutter_application_1/pages/sub_pages_meditar/novo_ciclo/pag_proposito.dart';
import 'package:flutter_application_1/pages/sub_pages_meditar/novo_ciclo/pag_aceitacao.dart';
import 'package:flutter_application_1/pages/sub_pages_meditar/meditacao_avancada/pag_foco_atencao.dart';
import 'package:flutter_application_1/pages/sub_pages_meditar/meditacao_avancada/pag_calma_interior.dart';

class PagMeditar extends StatelessWidget {
  final bool temaEscuro;
  final VoidCallback? onTrocarTema;

  PagMeditar({super.key, this.temaEscuro = false, this.onTrocarTema});

  final Map<String, List<Map<String, dynamic>>> sections = {
    "Introdução-Meditação": [
      {
        "text": "Respiração",
        "page": PagRespiracao(),
        "image":
            "https://cdn.pixabay.com/photo/2018/08/16/02/01/purple-3609478_1280.jpg",
      },
      {
        "text": "Relaxamento",
        "page": PagRelaxar(),
        "image":
            "https://cdn.pixabay.com/photo/2017/12/17/21/44/drink-3025022_1280.jpg",
      },
      {
        "text": "Comece a Meditar",
        "page": PagAprendaMeditacao(),
        "image":
            "https://cdn.pixabay.com/photo/2020/06/29/17/41/meditate-5353620_1280.jpg",
      },
    ],
    "Meditação Novo Ciclo": [
      {
        "text": "Equilíbrio",
        "page": PagEquilibrio(),
        "image":
            "https://cdn.pixabay.com/photo/2019/10/01/20/13/stone-tower-4519290_1280.jpg",
      },
      {
        "text": "Propósito",
        "page": PagProposito(),
        "image":
            "https://cdn.pixabay.com/photo/2020/06/09/08/01/road-5277457_1280.jpg",
      },
      {
        "text": "Aceitação",
        "page": PagAceitacao(),
        "image":
            "https://cdn.pixabay.com/photo/2016/11/22/23/29/meditate-1851165_1280.jpg",
      },
    ],
    "Meditação Avançada": [
      {
        "text": "Foco e Atenção",
        "page": PagFocoAtencao(),
        "image":
            "https://cdn.pixabay.com/photo/2017/08/26/15/37/eye-2683414_1280.jpg",
      },
      {
        "text": "Calma Interior",
        "page": PagCalmaInterior(),
        "image":
            "https://cdn.pixabay.com/photo/2015/04/29/20/42/waterfall-746108_1280.jpg",
      },
      {
        "text": "Mente e Corpo",
        "page": PagMenteCorpo(),
        "image":
            "https://cdn.pixabay.com/photo/2025/02/21/11/06/woman-9421843_1280.jpg",
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    // 🔒 Bloquear orientação da tela apenas vertical
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    final largura = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFEBE8E0),
      body: SafeArea(
        child: ListView(
          children: [
            _buildCabecalho(largura),
            const SizedBox(height: 20),
            ...sections.entries.map((section) {
              return _buildSection(context, section.key, section.value);
            }).toList(),

            // Espaço reservado para o menu flutuante no final
            const SizedBox(height: 120), // ajuste conforme altura do menu
          ],
        ),
      ),
    );
  }

  Widget _buildCabecalho(double largura) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: largura * 0.06,
        vertical: largura * 0.05,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: largura * 0.07,
            backgroundColor: Colors.transparent,
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
    );
  }

  Widget _buildSection(
    BuildContext context,
    String sectionTitle,
    List<Map<String, dynamic>> items,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            sectionTitle,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 0.7,
            children: items.map((item) {
              return CustomCardMeditar(
                text: item["text"],
                imagePath: item["image"],
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => item["page"]),
                  );
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
