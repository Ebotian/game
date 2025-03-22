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
