import { BootScene, MenuScene, GameScene } from '../scenes';
import { useEffect } from 'react';
import Phaser from 'phaser';

export default function Home() {
  useEffect(() => {
    const config: Phaser.Types.Core.GameConfig = {
      type: Phaser.AUTO,
      parent: 'game-container',
      width: 800,
      height: 600,
      scene: [BootScene, MenuScene, GameScene],
    };

    new Phaser.Game(config);
  }, []);

  return <div id="game-container" />;
}
