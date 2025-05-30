import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../models/post_model.dart';
import '../providers/providers.dart';

class PostCreateScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<PostCreateScreen> createState() => _PostCreateScreenState();
}

class _PostCreateScreenState extends ConsumerState<PostCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  Future<void> _createPost() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      final newPost = Post(
        userId: 1, // Sabit kullanıcı id, gerçek projede değiştirilebilir
        id: 0, // Sunucu tarafından atanacak
        title: _titleController.text,
        body: _bodyController.text,
      );
      await ref.read(postRepositoryProvider).createPost(newPost);
      if (mounted) {
        context.pop();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Gönderi oluşturulamadı: $e')));
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Yeni Gönderi Oluştur')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Başlık'),
                validator: (v) => v == null || v.isEmpty ? 'Başlık boş olamaz' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _bodyController,
                decoration: InputDecoration(labelText: 'İçerik'),
                maxLines: 5,
                validator: (v) => v == null || v.isEmpty ? 'İçerik boş olamaz' : null,
              ),
              SizedBox(height: 24),
              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(onPressed: _createPost, child: Text('Oluştur')),
            ],
          ),
        ),
      ),
    );
  }
}
