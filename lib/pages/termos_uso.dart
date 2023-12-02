import 'package:flutter/material.dart';

class TermosUso extends StatefulWidget {
  const TermosUso({super.key});

  @override
  State<TermosUso> createState() => _TermosUsoState();
}

class _TermosUsoState extends State<TermosUso> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Termos de uso'),
        surfaceTintColor: Colors.grey,
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Atualizado em abril de 2024\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Bem-vindo ao nosso serviço! Estes termos de uso regem o uso do nosso website e todos os serviços relacionados oferecidos por nós.\n',
                textAlign: TextAlign.justify
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                '1. Aceitação dos termos: Ao acessar ou utilizar nosso website, você concorda em cumprir e ficar vinculado a estes termos de uso. Se você não concorda com qualquer parte destes termos, por favor, não utilize nosso website.',
                textAlign: TextAlign.justify
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                '2. Uso do website: Você é responsável por qualquer atividade realizada em nosso website sob sua conta. Ao usar nosso website, você concorda em não:\n' 
                ' - Violentar qualquer lei ou regulamento aplicável;\n'
                ' - Realizar atividades fraudulentas ou prejudiciais;\n' 
                ' - Interferir com a segurança ou integridade do nosso website;\n' 
                ' - Acessar dados ou informações de outros usuários sem autorização.',
                textAlign: TextAlign.justify,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                '3. Propriedade intelectual: Todos os direitos de propriedade intelectual relacionados ao conteúdo e recursos disponibilizados em nosso website são de nossa propriedade ou licenciados para nós. Você concorda em não utilizar, copiar, modificar ou distribuir qualquer conteúdo sem nossa autorização prévia por escrito.',
                textAlign: TextAlign.justify 
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text.rich(
                TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: '4. Limitação de responsabilidade: ', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: 'Não nos responsabilizamos por qualquer dano direto, indireto, incidental, consequencial ou especial resultante do uso ou incapacidade de uso do nosso website. Isso inclui danos causados por falhas técnicas, vírus, interrupções de serviço ou condutas de terceiros.\n'),
                    TextSpan(text: '5. Privacidade: ', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: 'Nossa política de privacidade descreve como coletamos, usamos e protegemos suas informações pessoais. Ao utilizar nosso website, você concorda com nossa política de privacidade.\n'),
                    TextSpan(text: '6. Alterações nos termos de uso: ', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: 'Reservamos o direito de modificar ou atualizar estes termos de uso a qualquer momento, sem aviso prévio. É responsabilidade do usuário revisar regularmente os termos de uso. O uso contínuo do website após as modificações constitui aceitação dessas alterações.\n'),
                  ],
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        )),
    );
  }
}