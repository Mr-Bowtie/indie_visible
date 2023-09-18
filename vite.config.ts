import { defineConfig } from 'vite'
import RubyPlugin from "vite-plugin-ruby";
import StimulusHMR from "vite-plugin-stimulus-hmr";
import FullReload from "vite-plugin-full-reload";

export default defineConfig({
  plugins: [
    RubyPlugin(),
    StimulusHMR(),
    // You can specify any paths you want to watch for changes
    FullReload(["app/views/**/*.erb"])
  ],
  server: {
    host: "0.0.0.0",
    hmr: {
      clientPort: process.env.OUTER_PORT_FRONTEND,
    },
    port: process.env.INNER_PORT_FRONTEND_DEV,
    watch: {
      usePolling: true,
    }
  }
})
