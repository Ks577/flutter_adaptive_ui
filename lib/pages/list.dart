import 'package:flutter/material.dart';
import 'package:week15_adaptive_butterflies/pages/detalis.dart';
import '../model/model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Butterfly? _selectedButterfly;
  List <Butterfly> butterflies = allButterflies;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade50,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade600,
        title:  const Text('Мир бабочек'),
        centerTitle: true,
      ),
        body:
      LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth  < 600) {
          return ButterflyListView(
              butterflies: butterflies,
              onTapItem: (Butterfly butterfly) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ButterflyDetailPage(butterfly)),
                );});};
        return Row(
          children: [
            Expanded(
              child: ButterflyListView(
                butterflies: butterflies,
                onTapItem: (Butterfly butterfly) {
                  setState(() {
                    _selectedButterfly = butterfly;
                  });},
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      color: Colors.blue,
                      width: 1.0,
                    ),
                  ),
                ),
                child: _selectedButterfly == null
                    ?
                   Text(
                    'Выберите бабочку из списка', style: TextStyle(fontSize: 10), textAlign: TextAlign.center,
                )
                    : ButterflyDetailView(
                  _selectedButterfly!,

                ),
              ),
            ),
          ],);
      }));
  }}


class ButterflyListView extends StatelessWidget {
  final List<Butterfly> butterflies;
  final Function(Butterfly) onTapItem;
  const ButterflyListView({super.key, required this.butterflies, required this.onTapItem, this.selectedName});
  final int? selectedName;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return
Padding(
    padding:EdgeInsets.only(top: 10),
      child:
ListView.builder(
                    itemCount: butterflies.length,
                    itemBuilder: (context, index) {
                      final butterfly = butterflies[index];

                      return
                        Stack(
                          children: [
                                Card(
                                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    color: Colors.white38,
                                    shadowColor: Colors.blue.shade400,
                                    elevation: 5,
                                child: ExpansionTile(
                                title:
                                    ListTile(
                                      key: Key('list_item_$index'),
                                      title:
                                      Text(
                                          textScaleFactor: mediaQuery.textScaleFactor.clamp(1.0, 1.5),
                                          butterfly.name, style:TextStyle(fontFamily: 'Pattaya', color: Colors.black38)),
                                      contentPadding:  const EdgeInsets.only(
                                          left: 100),
                                      onTap: () {
                                        onTapItem.call(butterfly);
                                      },

                      ),
                                  children: <Widget>[
                                ListTile(
                                    contentPadding: EdgeInsets.all(30),
                                title: Text( 
                                  butterfly.note, style: const TextStyle(fontSize: 18, color: Colors.white),
                      ))
                                ])),
                            Positioned(
                              top: 10,
                              left: 10,
                            child:
                              Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black54,
                                      blurRadius: 6.0,
                                      spreadRadius: 5.0,
                                    )
                                  ],
                                ),
                              child: ClipOval(
                                child: Image.network(
                                  butterfly.imageUrl, fit: BoxFit.cover,
                                  height: 100,
                                  width: 105,
                                ),
                              ),
                            ),
                      )]);
                    }));
  }
}
