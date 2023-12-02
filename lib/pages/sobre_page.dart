import 'package:flutter/material.dart';
import 'package:watercrop_app/widgets/navigation_widget.dart';

class SobrePage extends StatefulWidget {
  const SobrePage({super.key});

  @override
  State<SobrePage> createState() => _SobrePageState();
}

class _SobrePageState extends State<SobrePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre'),
        surfaceTintColor: Colors.grey.shade900,
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      drawer: const Navigation(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [ 
                Image.asset(
                  'assets/app/imagem.png',
                  //height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.topCenter,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'WATER CROP\n',
                    style: TextStyle(
                      fontSize: 50,
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0, bottom: 10.0),
              child: Text(
                'O aplicativo de Balanço Hídrico é uma ferramenta essencial para agricultores, hidrologistas, engenheiros ambientais e todos aqueles interessados em gerir eficazmente os recursos hídricos. Através de um design intuitivo e baseado em dados científicos rigorosos, nosso aplicativo proporciona aos usuários uma visão clara e compreensível do balanço hídrico de um ambiente específico.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 14),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0, bottom: 10.0),
              child: Text(
                'O que é Balanço Hídrico?',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0, bottom: 10.0),
              child: Text(
                'O balanço hídrico é uma ferramenta utilizada para avaliar a disponibilidade e a demanda por água numa determinada área. Ele analisa a quantidade de água que entra e sai de um sistema, seja uma bacia hidrográfica, uma área agrícola, ou mesmo um país, considerando parâmetros como precipitação, evapotranspiração, infiltração, escoamento e armazenamento de água no solo.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 14),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0, bottom: 10.0),
              child: Text(
                'Funcionalidades',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'Roboto'),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0, bottom: 10.0),
              child: Text.rich(
                TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: 'Nosso aplicativo fornece as seguintes funcionalidades: \n', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: '1. Monitoramento em Tempo Real: ', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: 'O aplicativo coleta e exibe dados de diversas fontes, fornecendo uma visão em tempo real do balanço hídrico da área de interesse.\n'),
                    TextSpan(text: '2. Simulações: ', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: 'Com a função de simulação, os usuários podem prever o balanço hídrico futuro com base em diferentes cenários, como mudanças no clima ou nas práticas de uso da terra.\n'),
                    TextSpan(text: '3. Análise de Dados Históricos: ', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: 'O aplicativo armazena dados históricos para permitir análises de tendências a longo prazo e a comparação de anos úmidos e secos.\n'),
                    TextSpan(text: '4. Alertas: ', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: 'Os usuários podem configurar alertas para serem notificados quando certos limites são atingidos, como a capacidade de armazenamento de água em reservatórios.\n'),
                    TextSpan(text: '5. Ferramentas de Planejamento: ', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: 'Com as ferramentas de planejamento, os usuários podem projetar a melhor maneira de utilizar a água disponível, considerando a demanda atual e futura.\n'),
                    TextSpan(text: '6. Integração: ', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: 'O aplicativo pode ser integrado a outras plataformas digitais para um gerenciamento de recursos hídricos ainda mais eficiente.\n'),
                  ],
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      )
      
        
    );
  }
}