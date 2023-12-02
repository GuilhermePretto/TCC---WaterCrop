import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:watercrop_app/model/safra.dart';
import '../model/talhao.dart';
import '../widgets/safra_widget.dart';
import '../widgets/navigation_widget.dart';

class SafrasPage extends StatefulWidget {
  final Talhao talhao;
  const SafrasPage({Key? key, required this.talhao}) : super(key: key);

  @override
  State<SafrasPage> createState() => _SafrasPageState();
}

Stream<QuerySnapshot> getSafraData(String fazendaId, String talhaoId) {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    final irrigacaoCollectionRef = FirebaseFirestore.instance
        .collection('usuarios')
        .doc(user.uid)
        .collection('fazendas')
        .doc(fazendaId)
        .collection('talhoes')
        .doc(talhaoId)
        .collection('safras');
    return irrigacaoCollectionRef.snapshots();
  } else {
    return const Stream.empty();
  }
}

class _SafrasPageState extends State<SafrasPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: getSafraData(widget.talhao.fazendaId, widget.talhao.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: const CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Erro: ${snapshot.error}');
          } else if (!snapshot.hasData) {
            return const Text('Documentos do usuário não encontrado.');
          }

          return Scaffold(
            appBar: AppBar(
              title: const Text('Safras'),
              surfaceTintColor: Colors.grey.shade900,
              actions: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            drawer: const Navigation(),
            body: snapshot.data!.docs.isNotEmpty
                ? ListView(
                    children: snapshot.data!.docs
                        .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data()! as Map<String, dynamic>;
                          Safra safra = Safra(
                            uid: document.id,
                            ano: data['ano'],
                            cultura: data['cultura'],
                            cultivar: data['cultivar'],
                            sow_day: data['sow_day'],
                            days_since_sow: data['days_since_sow'],
                            vget4_day: data['vget4_day'],
                            flower_day: data['flower_day'],
                            grain_fill_day: data['grain_fill_day'],
                            matur_day: data['matur_day'],
                            field_cap_1: data['field_cap_1'],
                            field_cap_2: data['field_cap_2'],
                            field_cap_3: data['field_cap_3'],
                            perm_with_point_1: data['perm_with_point_1'],
                            perm_with_point_2: data['perm_with_point_2'],
                            perm_with_point_3: data['perm_with_point_3'],
                            sow_root_prof: data['sow_root_prof'],
                            veget4_root_prof: data['veget4_root_prof'],
                            flower_root_prof: data['flower_root_prof'],
                            grain_fill_root_prof: data['grain_fill_root_prof'],
                            matur_root_prof: data['matur_root_prof'],
                            sow_cult_coeff: data['sow_cult_coeff'],
                            veget4_cult_coeff: data['veget4_cult_coeff'],
                            flower_cult_coeff: data['flower_cult_coeff'],
                            grain_fill_cult_coeff: data['grain_fill_cult_coeff'],
                            matur_cult_coeff: data['matur_cult_coeff'],
                            pivot_cap: data['pivot_cap'],
                            sow_pivot_optimal_limit: data['sow_pivot_optimal_limit'],
                            veget4_pivot_optimal_limit: data['veget4_pivot_optimal_limit'],
                            flower_pivot_optimal_limit: data['flower_pivot_optimal_limit'],
                            grain_pivot_optimal_limit: data['grain_pivot_optimal_limit'],
                            matur_pivot_optimal_limit: data['matur_pivot_optimal_limit'],
                            sow_critical_limit: data['sow_critical_limit'],
                            veget4_critical_limit: data['veget4_critical_limit'],
                            flower_critical_limit: data['flower_critical_limit'],
                            grain_critical_limit: data['grain_critical_limit'],
                            matur_critical_limit: data['matur_critical_limit'],
                            dados_meteorologicos: data['dados_meteorologicos'] != null ? data['dados_meteorologicos'] : [],
                            irrigation: data['irrigation'] != null ? data['irrigation'] : []
                          );
                          return SafraCard(
                            safra: safra,
                            talhao: widget.talhao,
                          );
                        })
                        .toList()
                        .cast())
                : const Center(
                    child: Text(
                        'Este talhão não possui nenhuma safra cadastrada')),
          );
        });
  }
}
