#!/bin/bash

# 1. 创建目录结构
echo "创建项目目录结构..."
mkdir -p src/scenes
mkdir -p src/stores
mkdir -p src/styles

# 2. 创建 Phaser 场景
echo "创建 Phaser 场景..."

# BootScene.ts
cat <<EOL > src/scenes/BootScene.ts
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
EOL

# MenuScene.ts
cat <<EOL > src/scenes/MenuScene.ts
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
EOL

# GameScene.ts
cat <<EOL > src/scenes/GameScene.ts
import { useGameStore } from '../stores/gameStore';

export class GameScene extends Phaser.Scene {
  private store = useGameStore;

  constructor() {
    super({ key: 'GameScene' });
  }

  create() {
    const dayText = this.add.text(20, 20, `Day: ${this.store.getState().day}`, {
      fontSize: '24px',
    });

    const card = this.add.rectangle(400, 300, 200, 300, 0x00FF00)
      .setInteractive()
      .on('pointerdown', () => {
        this.store.getState().setResources({ learning: -10 });
        dayText.setText(`Day: ${this.store.getState().day}`);
      });
  }
}
EOL

# 3. 创建 Zustand 状态管理文件
echo "创建 Zustand 状态管理..."

cat <<EOL > src/stores/gameStore.ts
import { create } from 'zustand';

type Resource = {
  learning: number;
  social: number;
  health: number;
  entertainment: number;
};

interface GameState {
  day: number;
  resources: Resource;
  setResources: (update: Partial<Resource>) => void;
  nextDay: () => void;
}

export const useGameStore = create<GameState>((set) => ({
  day: 1,
  resources: { learning: 50, social: 50, health: 50, entertainment: 50 },
  setResources: (update) =>
    set((state) => ({ resources: { ...state.resources, ...update } })),
  nextDay: () => set((state) => ({ day: state.day + 1 })),
}));
EOL

# 4. 添加游戏主页面代码（index.tsx）
echo "创建游戏主页面..."

cat <<EOL > src/pages/index.tsx
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
EOL

# 5. 配置样式文件
echo "创建全局样式文件..."

cat <<EOL > src/styles/globals.css
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

#game-container {
  display: block;
  margin: 0 auto;
  background-color: #000;
}

body {
  font-family: sans-serif;
  background-color: #f0f0f0;
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
}
EOL

# 6. 安装依赖
echo "安装 Phaser 和 Zustand 依赖..."
npm install phaser zustand

# 7. 运行开发服务器
echo "完成！启动开发服务器..."
npm run dev
