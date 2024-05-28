// import './bootstrap';
// import '../css/app.css';
// import "../../public/assets/scss/main.scss";
import {createApp, h} from 'vue';
import {createInertiaApp} from '@inertiajs/vue3';
import {resolvePageComponent} from 'laravel-vite-plugin/inertia-helpers';
import {ZiggyVue} from '../../vendor/tightenco/ziggy/dist/vue.m';
import {router} from "@inertiajs/vue3";
import FullCalendar from "@fullcalendar/vue3";
import Antd from 'ant-design-vue';
import 'ant-design-vue/dist/antd.css';
import VueApexCharts from "vue3-apexcharts";
import 'vuetify/styles'
import { createVuetify } from 'vuetify'
import '@mdi/font/css/materialdesignicons.css'
import 'vuetify/dist/vuetify.css'
import * as directives from 'vuetify/directives'
import { aliases, mdi } from 'vuetify/iconsets/mdi'
import DayJsAdapter from '@date-io/dayjs'
// import { VStepper } from 'vuetify/labs/VStepper'
import Toast from "vue-toastification";
// Import the CSS or use your own!
import "vue-toastification/dist/index.css";
import * as vuetifyComponents from 'vuetify/components';
// import {VDataTable} from "vuetify/labs/components";
import VueCookies from 'vue-cookies'

const vuetify = createVuetify({
    components: {
        // VStepper,
        // VDataTable,
        ...vuetifyComponents,
    },
    directives,
    date: {
        adapter: DayJsAdapter,
    },
    icons: {
        defaultSet: 'mdi',
        aliases,
        sets: {
            mdi,
        },

    },
})
const options = {
    // default options
};
// const app = createApp(App);
const appName = window.document.getElementsByTagName('title')[0]?.innerText || 'jhdevelopers';
router.on('navigate', () => document.getElementById('app').removeAttribute('data-page'));
createInertiaApp({

    title: (title) => `${title} - ${appName}`,
    resolve: (name) => resolvePageComponent(`./Pages/${name}.vue`, import.meta.glob('./Pages/**/*.vue')),
    setup({el, App, props, plugin}) {
        return createApp({render: () => h(App, props)})
            .use(plugin)
            .use(ZiggyVue, Ziggy)
            .use(Toast, options)
            .use(vuetify)
            .use(Antd)
            // .use(VueCookies)

           // .use(Sortable)
           //  .use( cookies)

            .component('apexchart', VueApexCharts)
            //.component('Sortable', Sortable)
            .component('FullCalendar', FullCalendar)
            .mount(el);
    },
    // progress: false,

    progress: {
        progress: false,
        color: '#ff9900',
    },
});
