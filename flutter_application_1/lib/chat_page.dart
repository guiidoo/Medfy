import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/pages/hub_page_view.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage(this.text, this.isUser);
}

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;

  final Color verdePrincipal = const Color(0xFF7A9591);
  final Color inputBackgroundColor = const Color(0xFFD5E0D9);

  static const String _apiKey = "AIzaSyC6dDxQLHx8076s5YPNGQzauoS4gREw0Yk";

  Future<String> enviaChat(String prompt) async {
    final url = Uri.parse(
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash-001:generateContent?key=$_apiKey",
    );

    final instruction =
        '''
Mantenha uma abordagem gentil, respeitosa e suave, focada em relaxar o corpo e a mente do usuário.

Evite se aprofundar em temas pessoais do usuário. Se o usuário insistir em compartilhar algo pessoal, responda de forma educada e neutra, por exemplo:

“Entendo, mas aqui nosso foco é ajudar você a relaxar e meditar, trazendo mais presença e tranquilidade no momento.”

Caso o usuário traga temas fora do escopo da meditação ou do bem-estar emocional, responda com delicadeza e direcione a conversa para a prática meditativa:

“Obrigado por compartilhar, mas vamos focar em práticas que ajudam você a relaxar e cuidar do seu bem-estar agora.”

Sempre retorne o foco à meditação e ao autocuidado, ajudando o usuário a se conectar com o momento presente.

Oriente a prática de meditação por três fases (Introdução, Novo Ciclo, Avançada), conforme já descrito, usando linguagem clara e simples.

Recomende áudios da biblioteca Medfy com explicações curtas sobre seus benefícios, para apoiar a experiência do usuário.

Nunca faça julgamentos, diagnósticos ou aconselhamentos que extrapolem o papel de um guia meditativo.

Se for necessário, reafirme com gentileza os limites do aplicativo, sempre respeitando o usuário.


Introdução à Meditação
1. Técnicas de Respiração
A respiração é o ponto de partida da meditação. Quando você inspira profundamente pelo nariz e solta o ar lentamente pela boca, algo dentro de você começa a se alinhar. O ritmo da respiração conecta o corpo e a mente, acalma os pensamentos e restaura o equilíbrio interior.
A cada inspiração, permita-se absorver paz; a cada expiração, libere o peso do dia. Se sua mente se dispersar, volte o foco para o simples ato de respirar — é nele que mora o agora, e é nele que você reencontra a serenidade.
2. Como Relaxar
Antes de começar a meditar, encontre um espaço tranquilo e confortável. Feche os olhos, solte os ombros, o maxilar e as mãos. Sinta a tensão se desfazendo aos poucos, como se o corpo lembrasse o que é estar leve.
O relaxamento não é apenas físico, mas também emocional. Permita-se descansar das preocupações, dos julgamentos e das pressas. À medida que o corpo relaxa, a mente também se aquieta — e esse estado de entrega é o primeiro passo para a verdadeira paz interior.
3. Como Aprender a Meditar
Meditar é uma jornada, não um destino. No início, pode parecer difícil desacelerar os pensamentos, mas a meditação não exige perfeição — exige presença. Comece com alguns minutos por dia, sentado confortavelmente, apenas observando o ar entrar e sair.
Com o tempo, você perceberá que os pensamentos continuam vindo, mas já não o dominam. A mente aprende a observar, não a reagir. Meditar é aprender a estar inteiro em cada momento, e nesse estado simples, a vida se torna mais leve e clara.
 Novo Ciclo de Meditação
1. Aceitação
Aceitar é abrir espaço para a vida como ela é. Não significa concordar com tudo, mas reconhecer que cada emoção e experiência têm seu papel no nosso caminho. Quando você acolhe o que sente, sem tentar negar ou controlar, nasce um tipo novo de paz.
A aceitação é a base da transformação — é quando paramos de lutar contra o presente que começamos, de fato, a crescer. Respire fundo e diga a si mesmo: “Está tudo bem sentir o que sinto.” Esse é o primeiro passo para o equilíbrio interior.
2. Equilíbrio
Equilíbrio não é ausência de desafios, mas a sabedoria de permanecer sereno em meio a eles. É encontrar o ponto entre ação e pausa, entre força e entrega.
Na meditação, buscamos esse centro silencioso dentro de nós, onde nada falta e nada sobra. Quando o corpo respira em harmonia e a mente observa sem pressa, você percebe que o equilíbrio não é algo a ser conquistado, mas algo que sempre esteve em você — esperando para ser sentido.
3. Propósito
O propósito surge quando o coração se silencia e a mente aprende a escutar. Em meio à correria da vida, muitas vezes nos perdemos do que realmente importa.
A meditação nos convida a olhar para dentro, a reconhecer nossos valores e desejos mais sinceros. Quando a atenção se volta para o essencial, o caminho se torna mais claro. Descobrir seu propósito não é encontrar algo fora de si, mas despertar algo que sempre esteve aí — a vontade genuína de viver com sentido.
 Meditação Avançada
1. Mente e Corpo
A conexão entre mente e corpo é profunda. Cada pensamento cria uma sensação, e cada emoção deixa um reflexo físico. Quando aprendemos a respirar com consciência, ambos se alinham em harmonia.
Na prática avançada, a respiração se torna energia que flui por todo o corpo, e a mente, em vez de controlar, passa a observar com clareza. Esse estado de união traz vitalidade, foco e uma sensação de completude — o corpo se torna o templo da mente desperta.
2. Foco e Atenção
Foco é a arte de permanecer presente. Em um mundo cheio de distrações, manter a mente em um único ponto é um desafio que se conquista com treino e paciência.
Na meditação, o foco se fortalece quando observamos cada pensamento que surge, sem segui-lo. Voltamos, com suavidade, ao momento presente, à respiração, ao som, ao corpo. Aos poucos, a atenção deixa de ser esforço e se transforma em presença natural — um estado de clareza e lucidez interior.
3. Calma Interior
A calma interior é o espaço silencioso dentro de nós que nunca se agita, mesmo quando tudo ao redor muda. Ela não depende do ambiente, mas da forma como você se relaciona com o que acontece.
Quando a mente aprende a observar sem julgar, o coração encontra repouso. É nesse silêncio profundo que você percebe que a verdadeira paz não vem de fora — ela nasce dentro de você, e sempre esteve aí, esperando para ser redescoberta.

Mensagem do usuário: $prompt
''';

    final body = jsonEncode({
      "contents": [
        {
          "parts": [
            {"text": instruction},
          ],
        },
      ],
    });

    try {
      final httpClient = HttpClient();
      final request = await httpClient.postUrl(url);

      request.headers.contentType = ContentType.json;
      request.write(body);

      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();

      if (response.statusCode == 200) {
        final data = jsonDecode(responseBody);
        final text = data["candidates"]?[0]?["content"]?["parts"]?[0]?["text"];
        return text ?? "⚠️ Resposta vazia.";
      } else {
        return "Erro ${response.statusCode}: $responseBody";
      }
    } catch (e) {
      return "Erro de conexão: $e";
    }
  }

  void _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(text, true));
      _isLoading = true;
    });
    _controller.clear();

    final response = await enviaChat(text);

    setState(() {
      _messages.add(ChatMessage(response, false));
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: verdePrincipal,
        appBar: AppBar(
          backgroundColor: verdePrincipal,
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'Medfy',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: Stack(
          children: [
            // Ícone de fundo
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Opacity(
                  opacity: 0.08,
                  child: Transform.rotate(
                    angle: -0.3,
                    child: const Icon(
                      Icons.eco,
                      size: 400,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: media.size.width * 0.03,
                      vertical: media.size.height * 0.02,
                    ),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final msg = _messages[index];
                      return Align(
                        alignment: msg.isUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: media.size.width * 0.2,
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: media.size.height * 0.015,
                              horizontal: media.size.width * 0.04,
                            ),
                            margin: EdgeInsets.symmetric(
                              vertical: media.size.height * 0.008,
                            ),
                            decoration: BoxDecoration(
                              color: msg.isUser
                                  ? Color(0xFFD5E0D9).withOpacity(0.85)
                                  : Colors.white.withOpacity(0.85),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              msg.text,
                              style: TextStyle(
                                color: msg.isUser
                                    ? Colors.white
                                    : Colors.black87,
                                fontSize: media.size.width * 0.04,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                if (_isLoading)
                  Padding(
                    padding: EdgeInsets.all(media.size.height * 0.01),
                    child: const CircularProgressIndicator(),
                  ),
                // Input
                Container(
                  color: inputBackgroundColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: media.size.width * 0.03,
                    vertical: media.size.height * 0.015,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                            hintText: 'Digite sua mensagem...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: media.size.height * 0.015,
                              horizontal: media.size.width * 0.04,
                            ),
                          ),
                          onSubmitted: (_) => _sendMessage(),
                        ),
                      ),
                      SizedBox(width: media.size.width * 0.02),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: _isLoading ? null : _sendMessage,
                        color: Colors.black54,
                        iconSize: media.size.width * 0.08,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
