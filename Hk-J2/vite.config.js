import { defineConfig } from 'vite';
import laravel from 'laravel-vite-plugin';
import vue from '@vitejs/plugin-vue';

// Import Bootstrap and BootstrapVue CSS files (order is important)

// https://github.com/vuetifyjs/vuetify-loader/tree/next/packages/vite-plugin
// import vuetify from 'vite-plugin-vuetify'
// import VueCookies from "vue-cookies";
// import Cookies from "js-cookie";

// import 'bootstrap/dist/js/bootstrap.js'
export default defineConfig({
    plugins: [
        laravel({
            input: 'resources/js/app.js',
            refresh: true,
        }),
        vue({
            template: {
                transformAssetUrls: {
                    base: null,
                    includeAbsolute: false,
                },
            },
        }),
        // vue.use(VueCookies, {
        //     // options here
        // }),
        // vue.use(Cookies, {
        //     // options here
        // })
    ],
});

// Make BootstrapVue available throughout your project
// // Optionally install the BootstrapVue icon components plugin
// Vue.use(IconsPlugin)
