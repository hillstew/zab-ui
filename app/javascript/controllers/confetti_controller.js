import { Controller } from 'stimulus';
import ConfettiGenerator from 'confetti-js';

export default class extends Controller {
  static targets = ['output'];

  render() {
    var confettiSettings = { target: 'my-canvas' };
    var confetti = new ConfettiGenerator(confettiSettings);
    confetti.render();
  }
}
