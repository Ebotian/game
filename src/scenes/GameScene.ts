import { useGameStore } from '../stores/gameStore';

export class GameScene extends Phaser.Scene {
  private store = useGameStore;

  constructor() {
    super({ key: 'GameScene' });
  }

  create() {
    const dayText = this.add.text(20, 20, , {
      fontSize: '24px',
    });

    const card = this.add.rectangle(400, 300, 200, 300, 0x00FF00)
      .setInteractive()
      .on('pointerdown', () => {
        this.store.getState().setResources({ learning: -10 });
        dayText.setText();
      });
  }
}
