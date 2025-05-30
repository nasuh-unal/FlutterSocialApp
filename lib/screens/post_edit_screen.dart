import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../models/post_model.dart';
import '../providers/providers.dart';

class PostEditScreen extends ConsumerStatefulWidget {
  final int postId;

  PostEditScreen({required this.postId});

  @override
  ConsumerState<PostEditScreen> createState() => _PostEditScreenState();
}

class _PostEditScreenState extends ConsumerState<PostEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _bodyController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final postFuture = ref.read(postRepositoryProvider).getPostById(widget.postId);
    postFuture.then((post) {
      _titleController = TextEditingController(text: post.title);
      _bodyController = TextEditingController(text: post.body);
      setState(() {});
    }).catchError((_) {
      _titleController = TextEditingController();
      _bodyController = TextEditingController();
      setState(() {});
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      final updatedPost = Post(
        id: widget.postId,
        userId: 1, // Sabit kullanıcı id, gerçek projede değiştirilebilir
        title: _titleController.text,
        body: _bodyController.text,
      );
      await ref.read(postRepositoryProvider).updatePost(updatedPost);
      if (mounted) {
        context.pop();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Güncelleme başarısız: $e')));
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison
    if (_titleController == null || _bodyController == null) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      appBar: AppBar(title: Text('Gönderi Düzenle')),
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
                  : ElevatedButton(onPressed: _save, child: Text('Kaydet')),
            ],
          ),
        ),
      ),
    );
  }
}
