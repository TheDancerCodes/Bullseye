/*
  Holds data that models our BullsEye Game 🎯

  Each time the user hits the hit me button, we update the properties of the 
  GameModel based on the current value of the slider, and the totalScore & round
 */
class GameModel {
  static const SLIDER_START = 50;
  static const SCORE_START = 0;
  static const ROUND_START = 1;

  // Constructor ~ Added parameters for each of the properties of GameModel.
  // Wrapped the last 3 in [] menaing they are optional parameters.
  GameModel(this.target,
      [this.current = SLIDER_START,
      this.totalScore = SCORE_START,
      this.round = ROUND_START]);

  // Properties
  int target; // Target value for the game
  int current; // Current value of the slider
  int totalScore; // Total score so far in the game
  int round; // Current round

}
