import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/pages/pagina_produto.dart';

class ProdutoCard extends StatelessWidget {
  final String produtoId; // ID do documento no Firestore

  const ProdutoCard({super.key, required this.produtoId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('produtos')
          .doc(produtoId)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Center(child: Text("Produto não encontrado"));
        }

        var produto = snapshot.data!.data() as Map<String, dynamic>;

        // Decodifica a imagem Base64
        Uint8List? imagemBytes;
        try {
          imagemBytes = base64Decode(produto['imagem']);
        } catch (_) {}

        return IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => PaginaProduto(null, produtoId)),
            );
          },
          icon: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 230, 230, 230),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  imagemBytes != null
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.memory(
                      imagemBytes,
                      height: 150,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                  )
                      : const SizedBox(
                    height: 150,
                    child: Center(child: Icon(Icons.image, size: 50)),
                  ),
                  SizedBox(height: 10),
                  Text(
                    produto['nome'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    " ${produto['preco'].toStringAsFixed(2)}Cc",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
