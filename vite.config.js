import { defineConfig } from 'vite';
import laravel from 'laravel-vite-plugin';

export default defineConfig({
    server: {
        host: '0.0.0.0', // Allow access from outside the Docker container
        watch: {
          usePolling: true // Ensure file changes are detected inside Docker
        }
      },
    plugins: [
        laravel({
            input: [
                'resources/css/app.css',
                'resources/js/app.js',
                'resources/css/admin/app.css',
                'resources/js/admin/app.js',
            ],
            refresh: true,
        }),
    ],
});
