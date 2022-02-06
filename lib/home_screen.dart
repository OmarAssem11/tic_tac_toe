import 'package:flutter/material.dart';
import 'package:tic_tac_toe/game_logic.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String activePlayer = 'X';
  String result = '';
  int turn = 0;
  bool gameOver = false;
  bool twoPlayer = false;
  var game = Game();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: MediaQuery.of(context).orientation == Orientation.portrait
            ? Column(
                children: [
                  _topWidget(),
                  _grid(context),
                  ..._options(),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _topWidget(),
                        const SizedBox(height: 64),
                        ..._options(),
                      ],
                    ),
                  ),
                  _grid(context),
                ],
              ),
      ),
    );
  }

  Padding _topWidget() {
    return !gameOver
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: Text(
              'It\'s $activePlayer turn'.toUpperCase(),
              style: const TextStyle(
                fontSize: 48,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: Text(
              result,
              style: const TextStyle(
                fontSize: 48,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          );
  }

  Expanded _grid(BuildContext context) {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 1,
        padding: const EdgeInsets.all(16),
        children: List.generate(
          9,
          (int index) => InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            onTap: () => _onTap(index),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).shadowColor,
                borderRadius: const BorderRadius.all(Radius.circular(16)),
              ),
              child: Center(
                child: Text(
                  Player.playerX.contains(index)
                      ? 'X'
                      : Player.playerO.contains(index)
                          ? 'O'
                          : '',
                  style: TextStyle(
                    color: Player.playerX.contains(index)
                        ? Colors.blue
                        : Colors.pink,
                    fontSize: 64,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _options() {
    return [
      ElevatedButton.icon(
        onPressed: () {
          setState(() {
            Player.playerX = [];
            Player.playerO = [];
            activePlayer = 'X';
            result = '';
            turn = 0;
            gameOver = false;
          });
        },
        icon: const Icon(
          Icons.replay,
        ),
        label: const Text(
          'Play again',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(Theme.of(context).splashColor),
          fixedSize: MaterialStateProperty.all(
            const Size(180, 50),
          ),
        ),
      ),
      SwitchListTile.adaptive(
        contentPadding: const EdgeInsets.fromLTRB(70, 16, 56, 32),
        title: const Text(
          'Two player mode',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        value: twoPlayer,
        onChanged: (bool newValue) {
          setState(() {
            twoPlayer = newValue;
          });
        },
        activeColor: Theme.of(context).splashColor,
      ),
    ];
  }

  void _onTap(int index) async {
    if ((Player.playerX.isEmpty || !Player.playerX.contains(index)) &&
        (Player.playerO.isEmpty || !Player.playerO.contains(index)) &&
        !gameOver) {
      game.play(index, activePlayer);
      _updateActivePlayer();
      if (!twoPlayer && !gameOver) {
        await game.autoPlay(activePlayer);
        _updateActivePlayer();
      }
    }
  }

  void _updateActivePlayer() {
    turn++;
    if (turn == 9) {
      gameOver = true;
    }
    setState(() {
      activePlayer = activePlayer == 'X' ? 'O' : 'X';
      String winner = game.checkWinner();
      if (winner != '') {
        gameOver = true;
        result = '$winner is the winner!';
      } else if (gameOver) {
        result = 'It\'s a draw!';
      }
    });
  }
}
