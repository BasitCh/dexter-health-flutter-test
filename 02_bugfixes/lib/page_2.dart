import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // Add this import for compute
import 'dart:isolate'; // Added for compute

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> with TickerProviderStateMixin {
  final Stopwatch _operationTimer = Stopwatch();
  int _transactionCount = 0;
  String _status = 'System ready';

  final Map<String, dynamic> _transactionCache = {};
  final List<Timer> _activeTimers = [];
  final List<Future> _pendingOperations = [];

  bool _isProcessing = false;
  late AnimationController _progressController;
  late AnimationController _rotationController;

  bool _databaseLocked = false;
  bool _fileLocked = false;
  final List<Completer> _lockQueue = [];

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(duration: const Duration(seconds: 10), vsync: this);
    _rotationController = AnimationController(duration: const Duration(seconds: 2), vsync: this)..repeat();
  }

  Future<void> _performDataSync() async {
    if (_isProcessing) return;
    setState(() {
      _isProcessing = true;
      _status = 'Initializing...';
      _operationTimer.reset();
      _operationTimer.start();
    });
    _progressController.forward();
    await _startDatabaseOperation();
    await _startFileOperation();
    await _startBackgroundSync();
    await Future.delayed(const Duration(milliseconds: 100));
    await _createDeadlock();
    setState(() {
      _isProcessing = false;
      _status = 'System ready';
    });
  }

  Future<void> _startDatabaseOperation() async {
    setState(() {
      _status = 'Operation A in progress...';
    });
    await compute(_heavyDatabaseWork, null);
  }

  static void _heavyDatabaseWork(dynamic _) {
    int result = 0;
    for (int i = 0; i < 5000000; i++) {
      result += i * i;
      if (i % 1000000 == 0) {
        // Simulate progress update (no-op in isolate)
      }
    }
  }

  Future<void> _startFileOperation() async {
    setState(() {
      _status = 'Operation B in progress...';
    });
    await compute(_heavyFileWork, null);
  }

  static void _heavyFileWork(dynamic _) {
    String data = '';
    for (int i = 0; i < 100000; i++) {
      data += 'Processing block $i\n';
      if (data.length > 10000) {
        data = data.substring(0, 5000);
      }
    }
  }

  Future<void> _startBackgroundSync() async {
    setState(() {
      _status = 'Background sync...';
    });
    await compute(_heavyBackgroundSync, null);
    _transactionCount++;
    if (mounted) {
      setState(() {
        _transactionCache['sync_count'] = _transactionCount;
      });
    }
  }

  static void _heavyBackgroundSync(dynamic _) {
    final List<List<int>> memoryConsumer = [];
    final random = Random();
    for (int i = 0; i < 100; i++) {
      memoryConsumer.add(List.generate(1000, (index) => random.nextInt(1000)));
    }
    double result = 0;
    for (int i = 0; i < 10000; i++) {
      result += sin(i) * cos(i) * tan(i / 100);
    }
  }

  Future<void> _createDeadlock() async {
    setState(() {
      _status = 'Simulating deadlock...';
    });
    await compute(_simulateDeadlock, null);
    setState(() {
      _status = 'Deadlock simulation complete.';
    });
  }

  static void _simulateDeadlock(dynamic _) {
    // Simulate two tasks waiting on each other (no real deadlock, just heavy work)
    int sum1 = 0;
    for (int i = 0; i < 10000000; i++) {
      sum1 += i * i;
    }
    String result = '';
    for (int i = 0; i < 100000; i++) {
      result = '${result.hashCode ^ i}';
      if (result.length > 20) {
        result = result.substring(0, 10);
      }
    }
  }

  void _cleanup() {
    for (final timer in _activeTimers) {
      timer.cancel();
    }
    _activeTimers.clear();
    _pendingOperations.clear();
    _lockQueue.clear();
    _databaseLocked = false;
    _fileLocked = false;
    _progressController.stop();
    _progressController.reset();
    _operationTimer.stop();
  }

  @override
  void dispose() {
    _cleanup();
    _progressController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scenario 2'),
        actions: [
          RotationTransition(turns: _rotationController, child: const Icon(Icons.cloud_sync)),
          if (_operationTimer.isRunning)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  '${_operationTimer.elapsed.inSeconds}s',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: AnimatedBuilder(
                              animation: _progressController,
                              builder: (context, child) {
                                return CircularProgressIndicator(
                                  value: _isProcessing ? _progressController.value : 0,
                                  strokeWidth: 8,
                                  backgroundColor: Colors.grey[300],
                                );
                              },
                            ),
                          ),
                          Icon(
                            _isProcessing ? Icons.hourglass_empty : Icons.check_circle,
                            size: 48,
                            color: _isProcessing ? Colors.orange : Colors.green,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(_status, textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _isProcessing ? null : _performDataSync,
                icon: const Icon(Icons.play_arrow),
                label: const Text('Start'),
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
