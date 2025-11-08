import 'package:flutter/material.dart';

void main() {
  runApp(const FlashcardApp());
}

class FlashcardApp extends StatelessWidget {
  const FlashcardApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flashcard Quiz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const FlashcardScreen(),
    );
  }
}

// Model class for Flashcard
class Flashcard {
  final String id;
  final String question;
  final String answer;

  Flashcard({
    required this.id,
    required this.question,
    required this.answer,
  });
}

class FlashcardScreen extends StatefulWidget {
  const FlashcardScreen({Key? key}) : super(key: key);

  @override
  State<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<Flashcard> _flashcards = [];
  int _learnedCount = 0;
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    _loadInitialFlashcards();
  }

  // Load initial flashcards
  void _loadInitialFlashcards() {
    _flashcards = [
      Flashcard(
        id: '1',
        question: 'What is Flutter?',
        answer: 'Flutter is an open-source UI toolkit by Google for building natively compiled applications.',
      ),
      Flashcard(
        id: '2',
        question: 'What is a Widget in Flutter?',
        answer: 'A Widget is a basic building block of Flutter UI. Everything in Flutter is a widget.',
      ),
      Flashcard(
        id: '3',
        question: 'What is setState()?',
        answer: 'setState() is a method that tells Flutter to rebuild the widget with updated state.',
      ),
      Flashcard(
        id: '4',
        question: 'What is Dart?',
        answer: 'Dart is the programming language used to write Flutter applications.',
      ),
      Flashcard(
        id: '5',
        question: 'What is a StatefulWidget?',
        answer: 'A StatefulWidget is a widget that has mutable state that can change over time.',
      ),
    ];
    _learnedCount = 0;
  }

  // Refresh the list with new flashcards
  Future<void> _refreshFlashcards() async {
    setState(() {
      _isRefreshing = true;
    });

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _loadInitialFlashcards();
      _isRefreshing = false;
    });

    // Rebuild the AnimatedList
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Quiz refreshed!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  // Remove a flashcard (mark as learned)
  void _removeFlashcard(int index) {
    final removedCard = _flashcards[index];

    setState(() {
      _flashcards.removeAt(index);
      _learnedCount++;
    });

    _listKey.currentState?.removeItem(
      index,
          (context, animation) => _buildFlashcardItem(removedCard, animation, index),
      duration: const Duration(milliseconds: 300),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Card marked as learned!'),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            _undoRemove(index, removedCard);
          },
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  // Undo remove action
  void _undoRemove(int index, Flashcard card) {
    setState(() {
      _flashcards.insert(index, card);
      _learnedCount--;
    });

    _listKey.currentState?.insertItem(index);
  }

  // Add a new flashcard
  void _addNewFlashcard() {
    showDialog(
      context: context,
      builder: (context) {
        String question = '';
        String answer = '';

        return AlertDialog(
          title: const Text('Add New Flashcard'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Question',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => question = value,
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Answer',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                onChanged: (value) => answer = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (question.isNotEmpty && answer.isNotEmpty) {
                  final newCard = Flashcard(
                    id: DateTime.now().toString(),
                    question: question,
                    answer: answer,
                  );

                  setState(() {
                    _flashcards.insert(0, newCard);
                  });

                  _listKey.currentState?.insertItem(0);
                  Navigator.pop(context);
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshFlashcards,
        child: CustomScrollView(
          slivers: [
            // Collapsing header with progress
            SliverAppBar(
              expandedHeight: 120,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  'Quiz Progress: $_learnedCount / ${_flashcards.length + _learnedCount}',
                  style: const TextStyle(fontSize: 16),
                ),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade400, Colors.blue.shade700],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          '${_flashcards.isEmpty ? 100 : ((_learnedCount / (_flashcards.length + _learnedCount)) * 100).toStringAsFixed(0)}%',
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Flashcard list
            _flashcards.isEmpty
                ? SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.check_circle, size: 80, color: Colors.green),
                    const SizedBox(height: 16),
                    const Text(
                      'All cards learned!',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text('Pull down to refresh and start again.'),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: _refreshFlashcards,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Refresh Quiz'),
                    ),
                  ],
                ),
              ),
            )
                : SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverAnimatedList(
                key: _listKey,
                initialItemCount: _flashcards.length,
                itemBuilder: (context, index, animation) {
                  return _buildFlashcardItem(_flashcards[index], animation, index);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewFlashcard,
        tooltip: 'Add Flashcard',
        child: const Icon(Icons.add),
      ),
    );
  }

  // Build individual flashcard item with animation
  Widget _buildFlashcardItem(Flashcard card, Animation<double> animation, int index) {
    return SizeTransition(
      sizeFactor: animation,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Dismissible(
          key: Key(card.id),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            _removeFlashcard(index);
          },
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.check, color: Colors.white, size: 32),
          ),
          child: FlashcardWidget(card: card),
        ),
      ),
    );
  }
}

// Individual Flashcard Widget
class FlashcardWidget extends StatefulWidget {
  final Flashcard card;

  const FlashcardWidget({Key? key, required this.card}) : super(key: key);

  @override
  State<FlashcardWidget> createState() => _FlashcardWidgetState();
}

class _FlashcardWidgetState extends State<FlashcardWidget> {
  bool _showAnswer = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _showAnswer = !_showAnswer;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _showAnswer ? Colors.blue.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
          border: Border.all(
            color: _showAnswer ? Colors.blue : Colors.grey.shade300,
            width: 2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.quiz,
                  color: Colors.blue.shade700,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Question',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const Spacer(),
                Icon(
                  _showAnswer ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                  size: 18,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              widget.card.question,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            AnimatedCrossFade(
              firstChild: const SizedBox(height: 8),
              secondChild: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.lightbulb,
                        color: Colors.amber.shade700,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Answer',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.card.answer,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ],
              ),
              crossFadeState: _showAnswer
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
            ),
            const SizedBox(height: 8),
            Text(
              _showAnswer ? 'Tap to hide answer' : 'Tap to reveal answer',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}