import Phaser from 'phaser';

export class BootScene extends Phaser.Scene {
  constructor() {
    super({ key: 'BootScene' });
  }

  preload() {
    const { width, height } = this.scale;
    const progressBar = this.add.rectangle(width/2, height/2, 0, 30, 0xFFFFFF);
    this.load.on('progress', (value: number) => {
      progressBar.width = 400 * value;
    });
  }

  create() {
    this.scene.start('MenuScene');
  }
}
