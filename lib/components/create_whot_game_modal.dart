import 'package:cardgame/models/game_model.dart';
import 'package:cardgame/providers/whot_game_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateWhotGameModal extends StatefulWidget {
  const CreateWhotGameModal({Key? key}) : super(key: key);

  @override
  _CreateGameModalState createState() => _CreateGameModalState();
}

class _CreateGameModalState extends State<CreateWhotGameModal> {
  final TextEditingController _gameIdController = TextEditingController();
  final TextEditingController _maxPlayersController = TextEditingController();
  bool _isLoading = false;
  late WhotGameProvider _gameProvider;

  @override
  void initState() {
    // _gameProvider = Provider.of<ThirtyOneGameProvider>(context, listen: false);
    // _gameProvider = Provider.of<CrazyEightsGameProvider>(context, listen: false);
    _gameProvider = Provider.of<WhotGameProvider>(context, listen: false);
    super.initState();
  }

  Future<void> _createGame() async {
    final maxPlayers = int.tryParse(_maxPlayersController.text);

    if (maxPlayers == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter valid number of max players')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      
      final game = await _gameProvider.newWhotGame(maxPlayers);
      final response = [game.toJson()];

      if (response.isNotEmpty) {
        await _gameProvider.listGames();
        Navigator.of(context).pop(response);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create game')),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Create New Game'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _maxPlayersController,
            decoration: const InputDecoration(
              labelText: 'Max Players',
              // keyboardType: TextInputType.number,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _createGame,
          child: _isLoading ? CircularProgressIndicator() : Text('Create'),
        ),
      ],
    );
  }
  
  httpPost(String s, {required Map<String, Object> body}) {}
}
