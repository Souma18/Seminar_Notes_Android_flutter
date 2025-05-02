import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/NoteProvider.dart';
import '../model/Note.dart';
import 'NoteDetailScreen.dart';
import 'TrashScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = Provider.of<NoteProvider>(context);
    final filteredNotes =
        provider.activeNotes.where((note) {
          final titleMatch = note.title.toLowerCase().contains(
            _searchQuery.toLowerCase(),
          );
          final contentMatch = note.content.toLowerCase().contains(
            _searchQuery.toLowerCase(),
          );
          return titleMatch || contentMatch;
        }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Notes"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const TrashScreen()),
                ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SearchBar(
              hintText: "Search notes...",
              leading: const Icon(Icons.search),
              onChanged: (value) => setState(() => _searchQuery = value),
              elevation: WidgetStateProperty.all(1.0),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: filteredNotes.length,
                itemBuilder: (context, index) {
                  final note = filteredNotes[index];
                  return Card(
                    elevation: 1,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () async {
                        if (note.passNote != null) {
                          final isCorrect = await _checkPassword(context, note);
                          if (!isCorrect) return;
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => NoteDetailScreen(note: note),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        note.title,
                                        style: theme.textTheme.titleMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    if (note.passNote != null)
                                      Icon(
                                        Icons.lock_outline,
                                        size: 18,
                                        color: theme.colorScheme.primary,
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Expanded(
                                  child:
                                      note.passNote != null
                                          ? Center(
                                            child: Icon(
                                              Icons.lock,
                                              size: 36,
                                              color: theme.colorScheme.primary
                                                  .withOpacity(0.3),
                                            ),
                                          )
                                          : Text(
                                            note.content,
                                            style: theme.textTheme.bodyMedium,
                                            overflow: TextOverflow.fade,
                                          ),
                                ),
                              ],
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: IconButton(
                                icon: Icon(
                                  Icons.delete_outline,
                                  size: 20,
                                  color: theme.colorScheme.primary,
                                ),
                                onPressed:
                                    () => _showDeleteDialog(
                                      context,
                                      note,
                                      provider,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const NoteDetailScreen()),
            ),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _showDeleteDialog(
    BuildContext context,
    Note note,
    NoteProvider provider,
  ) async {
    await showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            icon: const Icon(Icons.delete_outline, size: 32),
            iconColor: Theme.of(context).colorScheme.error,
            title: const Text("Xóa ghi chú"),
            content: const Text(
              "Bạn chắc chắn muốn xóa ghi chú này? Hành động này không thể hoàn tác.",
            ),
            actionsAlignment: MainAxisAlignment.spaceBetween,
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.onSurface,
                ),
                child: const Text("HỦY"),
              ),
              FilledButton.tonal(
                onPressed: () {
                  provider.deleteNote(note);
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text("Đã xóa ghi chú"),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  );
                },
                style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.errorContainer,
                  foregroundColor:
                      Theme.of(context).colorScheme.onErrorContainer,
                ),
                child: const Text("XÓA"),
              ),
            ],
          ),
    );
  }

  Future<bool> _checkPassword(BuildContext context, Note note) async {
    final passwordController = TextEditingController();
    bool isAuthenticated = false;

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (ctx) => AlertDialog(
            icon: const Icon(Icons.lock_outline, size: 32),
            iconColor: Theme.of(context).colorScheme.primary,
            title: const Text("Mở khóa ghi chú"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Nhập mật khẩu...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                  ),
                ),
                const SizedBox(height: 8),
                if (note.passNote != null && note.passNote!.isNotEmpty)
                  Text(
                    "Ghi chú này được bảo vệ bằng mật khẩu",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text("HỦY"),
              ),
              FilledButton(
                onPressed: () {
                  if (passwordController.text == note.passNote) {
                    isAuthenticated = true;
                    Navigator.pop(ctx);
                  } else {
                    ScaffoldMessenger.of(ctx).showSnackBar(
                      SnackBar(
                        content: const Text("Mật khẩu không đúng"),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    );
                  }
                },
                child: const Text("XÁC NHẬN"),
              ),
            ],
          ),
    );

    return isAuthenticated;
  }
}
