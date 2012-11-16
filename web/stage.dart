library spaceinvader;

import 'dart:html';

part 'state.dart';
part 'menu.dart';
part 'playing.dart';
part 'gameover.dart';

class Stage {
  
  State _currentState;
  CanvasElement _canvas;
  
  CanvasRenderingContext2D get ctx => _canvas.context2d;
  
  State get currentState => _currentState; 
  set currentState (State state){
    if (_currentState.next == null){
      throw new UnsupportedError("The new state is null");
    }
    _currentState.destroy();
    _currentState = state;
    _currentState.render();
  }
  
  Stage.fromCanvas (this._canvas){
    _currentState = new Menu.withNext (
                    new Playing.withNext (
                    new GameOver ()));
  }
  
  nextState(){
    currentState = _currentState.next;
  }
  
  previousState(){
    currentState = _currentState.previous;
  }
  
  goToFirtState(){
    _currentState.destroy();
    while (_currentState.previous != null){
      _currentState = _currentState.previous;
    }
    _currentState.render();
  }
}