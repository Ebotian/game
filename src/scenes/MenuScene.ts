export class MenuScene extends Phaser.Scene {
  private startButton!: Phaser.GameObjects.Text;

  constructor() {
    super({ key: 'MenuScene' });
  }

  create() {
    const { width, height } = this.scale;
    this.startButton = this.add.text(width/2, height/2, '开始游戏', { fontSize: '32px' })
      .setOrigin(0.5)
      .setInteractive()
      .on('pointerdown', () => {
        this.scene.start('GameScene');
      });
  }
}
