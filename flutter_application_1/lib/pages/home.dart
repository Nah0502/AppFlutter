import 'package:flutter/material.dart';
import '../services/firebase.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  bool _isExpanded = false;

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void _addCode() {
    if (_controller.text.isNotEmpty) {
      FirebaseService().createCode(_controller.text);
      _controller.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Code ajouté avec succès')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Code'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    maxLines: _isExpanded ? null : 1,
                    decoration: InputDecoration(
                      hintText: 'Ton code gojo',
                      suffixIcon: IconButton(
                        icon: Icon(_isExpanded ? Icons.compress : Icons.expand),
                        onPressed: _toggleExpanded,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addCode,
                  //onPressed: (){print(FirebaseService().codes);},
                ),
              ],
            ),
          ),
          Expanded(
            //child: Center(child: Text("Hello World"),)

            child: StreamBuilder(
              
              stream: FirebaseService().getCodes(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                  if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Container(
                  padding: const EdgeInsets.all(40),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    "Aucun message",
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  ),
                ),
              );
            }
                //return Center(child: Text("Hello World"));
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final code = snapshot.data!.docs[index]['code'] ?? "";
                    return Container(
                      margin: const EdgeInsets.all(8.0),
                      padding: const EdgeInsets.all(8.0),
                      color: Colors.black,
                      child: ListTile(
                        title: Text(
                          code,
                          style: const TextStyle(color: Colors.white),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.copy, color: Colors.white),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Code copié')),
                            );
                          },
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
    );
  }
}