import { defineConfig } from 'vite';
import createReScriptPlugin from '@jihchi/vite-plugin-rescript';

export default defineConfig({
  plugins: [createReScriptPlugin()],
  build: {
    target: 'esnext',
  }
});

