<script setup>
import {Head, router, useForm, usePage} from '@inertiajs/vue3';
import Chart from "@/Components/Chart.vue";
import {Link} from "@inertiajs/vue3";
import {onMounted, ref} from 'vue'
import {computed, defineComponent, onActivated, reactive, watch} from "vue";
import moment from 'moment';
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import {orderData} from "@/Pages/Ref/OrderData";
import OrderDetails from "@/Components/OrderDetails.vue";
function arabicDay(dateFrom) {
    const englishDay = moment(dateFrom).format('dddd');
    const arabicDays = {
        Sunday: 'الأحد',
        Monday: 'الاثنين',
        Tuesday: 'الثلاثاء',
        Wednesday: 'الأربعاء',
        Thursday: 'الخميس',
        Friday: 'الجمعة',
        Saturday: 'السبت',
    };
    return arabicDays[englishDay] || '';
}


const currentDate = new Date();
const formattedDate = currentDate;

function goToCalendar(dateFrom) {
    router.visit(route('calendar.overview', {date: dateFrom}));
}


let props = defineProps({
    notes: Array,
    projects: Object,
    orders: Object,
    clients: Object,
    errors: Object,
    events: Array,
    p: Array,
    eventCount: Array,
    count: Array,
    counterTrueOrFalse: Number,
    countNextEvent: Number,
    totalUsers: Number,
    totalEvents: Number,
    totalProjects: Number,
})

function getRemainingDays(dateFrom, dateTo) {
    const start = moment(dateFrom);
    const end = moment(dateTo);
    const duration = moment.duration(end.diff(start));
    const days = duration.asDays();
    return Math.ceil(days);
}

// const selectedFilter = ref('');

let filteringEvents = reactive({
    filter: '',
    showMore: 10,
})
let months = [
    'January', 'February', 'March', 'April', 'May',
    'June', 'July', 'August', 'September',
    'October', 'November', 'December'
];

let uniqueYears = []; // Initialize uniqueYears array
let monthsByYear = {}; // Initialize months object with years as keys

const updateMonthsByYear = (events) => {
    events.forEach((event) => {
        const year = event.dateFrom.substring(0, 4);
        const month = event.dateFrom.substring(5, 7);

        if (!monthsByYear.hasOwnProperty(year)) {
            monthsByYear[year] = [];
        }

        if (!monthsByYear[year].includes(month)) {
            monthsByYear[year].push(month);
        }
    });

    uniqueYears = Object.keys(monthsByYear); // Update uniqueYears array
};

watch(filteringEvents, (value) => {
    router.get(route('dashboard'), {...filteringEvents}, {
            preserveScroll: true,
            preserveState: true,
        }
    );
    if (filteringEvents.filter == 'past') {
        uniqueYears = [];
        monthsByYear = {};

    } else if (filteringEvents.filter == 'upcoming') {
        uniqueYears = [];
        monthsByYear = {};

    } else if (filteringEvents.filter == 'closest') {
        uniqueYears = [];
        monthsByYear = {};

    } else {
        uniqueYears = [];
        monthsByYear = {};
    }
});
// let dialog = false
// Call updateMonthsByYear initially with the events data
let orderDialog = ref(false)
function openOrderDialog (item) {
    orderDialog.value = true;
    orderData.value = item
    console.log(orderData.value)
}
updateMonthsByYear(props.events);


watch(() => props.events, (newEvents) => {
    // console.log(newEvents.data)
    updateMonthsByYear(newEvents);
});
//
// let showData = reactive({
//     showMore:10
// });
function showMore() {
    filteringEvents.showMore += 2;
    router.get(route('dashboard'), {...filteringEvents}, {
        preserveScroll: true, preserveState: true,
    },)

    // console.log(showData)
}

let dialog = ref(false);
let noteDialog = ref(false);

const noteForm = useForm({
    note: '',
    color: '',
})

function makeNote() {
    if (noteForm.note || noteForm.color) {
        noteForm.post(route('note.make'), {
            onSuccess: () => {
                noteDialog.value = false;
                noteForm.reset()
            }
        })
    }
}

const notValidNote = v => {
    if (!v) {
        return false
    }
}
const validNote = computed(() => notValidNote)

function removeNote(nId) {
    router.post(route('note.remove', nId))
}
</script>
<template>
    <AuthenticatedLayout>
        <Head title="Dashboard"/>


        <div class="row">
            <div class="col-xl-3 col-sm-6 col-12 d-flex" v-if="$page.props.auth.userRole.includes('user-list')">
                <div class="card bg-comman w-100 bBcW">
                    <div class="card-body">
                        <div class="db-widgets d-flex justify-content-between align-items-center">
                            <div class="db-info">
                                <h6>
                                    {{
                                        $page.props.auth.user.lang == 'arabic' ? 'إجمالي المستخدمين' : 'Total Users'
                                    }}</h6>
                                <h3>{{ totalUsers }}</h3>
                            </div>
                            <div class="db-icon">
                                <i class="feather-users"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xl-3 col-sm-6 col-12 d-flex" v-if="$page.props.auth.userRole.includes('client-list')">
                <div class="card bg-comman w-100 bBcW">
                    <div class="card-body">
                        <div class="db-widgets d-flex justify-content-between align-items-center">
                            <div class="db-info">
                                <h6>
                                    {{
                                        $page.props.auth.user.lang == 'arabic' ? 'إجمالي الزبائن' : 'Total Clients'
                                    }}</h6>
                                <h3>{{ totalUsers }}</h3>
                            </div>
                            <div class="db-icon">
                                <i class="feather-users"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xl-3 col-sm-6 col-12 d-flex" v-if="$page.props.auth.userRole.includes('employer-list')">
                <div class="card bg-comman w-100 bBcW">
                    <div class="card-body">
                        <div class="db-widgets d-flex justify-content-between align-items-center">
                            <div class="db-info">
                                <h6>
                                    {{
                                        $page.props.auth.user.lang == 'arabic' ? 'إجمالي الموظفون' : 'Total Employees'
                                    }}</h6>
                                <h3>{{ totalUsers }}</h3>
                            </div>
                            <div class="db-icon">
                                <i class="feather-users"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--            <div class="col-xl-3 col-sm-6 col-12 d-flex">-->
            <!--                <div class="card bg-comman w-100">-->
            <!--                    <div class="card-body">-->
            <!--                        <div class="db-widgets d-flex justify-content-between align-items-center">-->
            <!--                            <div class="db-info">-->
            <!--                                <h6>-->
            <!--                                    {{ $page.props.auth.user.lang == 'arabic' ? 'إجمالي المشاريع' : 'Total Projects' }}</h6>-->
            <!--                                <h3>{{ totalProjects }}</h3>-->
            <!--                            </div>-->
            <!--                            <div class="db-icon">-->
            <!--                                <i class="feather-server"></i>-->
            <!--                            </div>-->
            <!--                        </div>-->
            <!--                    </div>-->
            <!--                </div>-->
            <!--            </div>-->
            <div class="col-xl-3 col-sm-6 col-12 d-flex" v-if="$page.props.auth.userRole.includes('event-calendar')">
                <div class="card bg-comman w-100 bBcW">
                    <div class="card-body">
                        <div class="db-widgets d-flex justify-content-between align-items-center">
                            <div class="db-info">
                                <h6>
                                    {{
                                        $page.props.auth.user.lang == 'arabic' ? ' إجمالي الأحداث القادمة' : 'Total Upcoming events'
                                    }}</h6>
                                <h3>{{ totalEvents }}</h3>
                            </div>
                            <div class="db-icon">
                                <i class="feather-clock"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div v-if="$page.props.auth.userRole.includes('note-list')">
            <v-dialog width="500" v-model="noteDialog">
                <v-card title="Make a note" style="border-radius: 20px">
                    <v-card-text>
                        <v-textarea
                            v-model="noteForm.note"
                            clearable
                            clear-icon="mdi-close-circle"
                            label="Text"
                            :rules="[validNote]"
                        ></v-textarea>
                        <InputError :message="errors.note"/>
                        <v-text-field
                            v-model="noteForm.color"
                            type="color"
                            label="Color"
                            variant="outlined"/>
                    </v-card-text>
                    <v-card-actions>
                        <v-spacer></v-spacer>

                        <v-btn
                            text="Close"
                            @click="noteDialog = false"
                        ></v-btn>
                        <v-btn v-if="$page.props.auth.userRole.includes('note-create')"
                               text="Add"
                               @click="makeNote"
                        ></v-btn>
                    </v-card-actions>
                </v-card>
            </v-dialog>

            <v-sheet style="background-color: rgba(0,119,246,0.15);border-radius: 20px"
                     max-width="1156"
                     class="mx-auto mt-8"
                     elevation="12"
                     height="128"
                     width="100%"
            >
                <v-row align="center" justify="center">
                    <v-col cols="auto">
                        <v-btn density="compact" @click="noteDialog = true" icon="mdi-plus"/>
                    </v-col>

                </v-row>
                <div v-for="note in notes" :key="note.id"
                     :style="`position: relative;float: ${$page.props.auth.user.lang == 'arabic' ? 'right' : 'left'}`">
                    <v-chip
                        class="ma-2"
                        closable
                        @click:close="$page.props.auth.userRole.includes('note-delete') ? removeNote(note.id) : ''"
                        :style="`background-color:${note.color};`"
                    >
                        {{ note.notes }}
                    </v-chip>
                </div>
            </v-sheet>

            <div class="py-3"></div>
        </div>
        <!--                <code class="text-subtitle-1">.{{ model }}</code>-->
        <!--            </div>-->
        <!--<CreateAccount />-->
        <v-dialog v-model="orderDialog" width="800">
            <OrderDetails :order-data="orderData"/>
        </v-dialog>
        <div class="row">
            <div class="col-12 col-lg-12 col-xl-8">

                <div class="row">
                    <div class="col-12 col-lg-12 col-xl-12 d-flex">
                        <div class="card flex-fill comman-shadow" style="background-color: rgba(0,119,246,0.15);">
                            <div class="card-header d-flex align-items-center"
                                 style="background-color: rgba(0,119,246,0.00);">
                                <h5 class="card-title">
                                    {{
                                        $page.props.auth.user.lang == 'arabic' ? 'تاريخ الحجوزات' : 'Reservations History'
                                    }}</h5>

                            </div>
                            <div class="card-body">
                                <v-table
                                    style="border-radius: 20px"
                                    fixed-header
                                    v-if="orders.length > 0"
                                >
                                    <thead>
                                    <tr>
                                        <th class="text-left">
                                            Name
                                        </th>
                                        <th class="text-left">
                                            Phone
                                        </th>
                                        <th class="text-left">
                                            Email
                                        </th>
                                        <th class="text-left">
                                            Date
                                        </th>
                                        <th class="text-left">
                                            Time
                                        </th>
                                        <th class="text-left">
                                            Total
                                        </th>
                                        <th class="text-center">
                                            Details
                                        </th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr
                                        v-for="item in orders"
                                        :key="item.id"
                                    >
                                        <td>{{ item.name }}</td>
                                        <td>{{ item.phone }}</td>
                                        <td>{{ item.email }}</td>
                                        <td>{{ moment(item.date).format('YYYY MMM D') }}</td>
                                        <td>{{ moment(item.time,"HH:mm:ss").format("hh:mm A") }}</td>
                                        <!--                                        <td>{{ item.time }}</td>-->
                                        <td>{{ item.price }}</td>
                                        <td class="text-center"><v-btn variant="plain" @click="openOrderDialog(item)" color="primary">Details</v-btn></td>
                                    </tr>
                                    </tbody>
                                </v-table>
                                <v-alert v-else style="margin-top: 70px"
                                         type="info"
                                         variant="tonal"
                                >
                                    <v-alert-title style="justify-content: center;display: flex">There is no clients
                                    </v-alert-title>
                                </v-alert>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-lg-12 col-xl-12 d-flex">
                        <div class="card flex-fill comman-shadow" style="background-color: rgba(0,119,246,0.04)">
                            <div class="card-header" style="background-color: rgba(0,119,246,0.0)">
                                <div class="row align-items-center">
                                    <div class="col-6">
                                        <h5 class="card-title">
                                            <strong> {{
                                                    $page.props.auth.user.lang == 'arabic' ? "النشاط" : "Activity's"
                                                }}</strong></h5>
                                    </div>
                                    <div class="col-6">
                                        <ul class="chart-list-out">
                                            <!--                                            <li><span class="circle-blue"></span>Teacher</li>-->
                                            <!--                                            <li><span class="circle-green"></span>Students</li>-->

                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div class="card-body">
                                <!--                                <div id="school-area"></div>-->
                                <Chart :p="$page.props.p" :count="$page.props.count"
                                       :eventCount="$page.props.eventCount"/>
                            </div>
                        </div>
                    </div>

                    <div class="col-12 col-lg-12 col-xl-12 d-flex"
                         v-if="$page.props.auth.userRole.includes('client-list')">
                        <div class="card flex-fill comman-shadow" style="background-color: rgba(0,119,246,0.15);">
                            <div class="card-header d-flex align-items-center"
                                 style="background-color: rgba(0,119,246,0.00);">
                                <h5 class="card-title">
                                    {{
                                        $page.props.auth.user.lang == 'arabic' ? 'تاريخ الزبائن' : 'Clients History'
                                    }}</h5>

                            </div>
                            <div class="card-body">
                                <v-table
                                    style="border-radius: 20px"
                                    fixed-header
                                    v-if="clients.data.length > 0"
                                >
                                    <thead>
                                    <tr>
                                        <th class="text-left">
                                            Name
                                        </th>
                                        <th class="text-left">
                                            Phone
                                        </th>
                                        <th class="text-left">
                                            Email
                                        </th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr
                                        v-for="item in clients.data"
                                        :key="item.client_id"
                                    >
                                        <td>{{ item.client_name }}</td>
                                        <td>{{ item.client_phone }}</td>
                                        <td>{{ item.client_email }}</td>
                                    </tr>
                                    </tbody>
                                </v-table>
                                <v-alert v-else style="margin-top: 70px"
                                         type="info"
                                         variant="tonal"
                                >
                                    <v-alert-title style="justify-content: center;display: flex">There is no clients
                                    </v-alert-title>
                                </v-alert>
                            </div>
                        </div>
                    </div>


                    <div class="col-12 col-lg-12 col-xl-12 d-flex"
                         v-if="$page.props.auth.userRole.includes('project-list')">
                        <div class="card flex-fill comman-shadow" style="background-color: rgba(0,119,246,0.04)">
                            <div class="card-header d-flex align-items-center"
                                 style="background-color: rgba(0,119,246,0.00)">
                                <h5 class="card-title">
                                    {{
                                        $page.props.auth.user.lang == 'arabic' ? 'تاريخ المشاريع' : 'Projects History'
                                    }}</h5>
                            </div>
                            <div class="card-body">
                                <v-alert v-if="projects.data.length < 1"
                                         type="info"
                                         title="No data founded"
                                         text="There are is no data"
                                         variant="tonal"
                                ></v-alert>
                                <div class="teaching-card" v-else v-for="project in projects.data"
                                     :key="project.id">
                                    <ul class="steps-history">
                                        <!--                                        <li>Sep22</li>-->
                                        <!--                                        <li>Sep23</li>-->
                                        <!--                                        <li>Sep24</li>-->
                                    </ul>
                                    <ul class="activity-feed">
                                        <li class="feed-item d-flex align-items-center">
                                            <div class="dolor-activity">
                                                <span class="feed-text1"><a>{{ project.title }}</a></span>
                                                <ul class="teacher-date-list">
                                                    <li><i class="fas fa-calendar-alt me-2"></i>{{
                                                            moment(project.created_at).format('YYYY-MM-DD')
                                                        }}
                                                    </li>
                                                    <li>|</li>
                                                    <a href="">
                                                        <li><i class="feather-github me-2"></i>Github
                                                        </li>
                                                    </a>
                                                    <li><i class="feather-eye me-2"></i>Demo
                                                    </li>
                                                </ul>
                                            </div>
                                            <div class="activity-btns ms-auto">
                                                <button type="submit" class="btn btn-info">In Progress</button>
                                            </div>
                                        </li>

                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

            <div class="col-12 col-lg-12 col-xl-4 d-flex" v-if="$page.props.auth.userRole.includes('event-calendar')">
                <div class="card flex-fill comman-shadow" style="background-color: rgba(0,119,246,0.10)">
                    <div class="card-body">
                        <div class="calendar-info1">
                            <div class="up-come-header">
                                <h2>
                                    {{
                                        usePage().props.auth.user.lang == 'arabic' ? 'المواعيد القادمة' : 'Upcoming Events'
                                    }}</h2>
                                <span v-if="$page.props.auth.userRole.includes('event-create')"><Link :href="route('calendar.overview')"><i
                                    class="feather-plus"></i></Link></span>
                            </div>
                            <div class="up-come-header" style="position: relative;float: right;margin-top: 3px;">
                                <span style="cursor: pointer" @click="dialog = true" class="feather-filter"></span>
                                <!--                            <FilterDialog />-->
                            </div>
                            <v-row justify="center" v-if="totalEvents > 0">
                                <v-dialog
                                    v-model="dialog"
                                    scrollable
                                    width="auto"
                                >
                                    <v-card>
                                        <v-card-title>Select a Filter</v-card-title>
                                        <v-divider></v-divider>
                                        <v-card-text style="height: auto;">
                                            <v-radio-group
                                                v-model="filteringEvents.filter"
                                                column
                                            >
                                                <v-radio
                                                    :label="$page.props.auth.user.lang == 'arabic' ? 'القادمة': 'upcoming'"
                                                    value="upcoming"></v-radio>
                                                <v-radio
                                                    :label="$page.props.auth.user.lang == 'arabic' ? 'الاسبوع الحالي': 'week'"
                                                    value="closest"></v-radio>
                                                <v-radio
                                                    :label="$page.props.auth.user.lang == 'arabic' ? 'السابقة': 'earlier'"
                                                    value="past"></v-radio>
                                            </v-radio-group>
                                            <v-btn @click="filteringEvents.filter = null"><i
                                                class="feather-rotate-ccw"></i></v-btn>
                                        </v-card-text>
                                        <v-divider></v-divider>
                                        <v-card-actions>
                                            <v-btn
                                                color="blue-darken-1"
                                                variant="text"
                                                @click="dialog = false"
                                            >
                                                Close
                                            </v-btn>
                                        </v-card-actions>
                                    </v-card>
                                </v-dialog>
                            </v-row>
                            <!--                        <div v-if="showEvents" id="events-wrapper">-->
                            <div v-if="events.length > 0">

                                <div id="events-wrapper" v-for="year in uniqueYears" :key="year" >

                                    <div class="upcome-event-date"
                                         style="display: flex;justify-content: center;margin-top: 70px">
                                        <h3 style="background-color: rgba(0,119,246,0.00)">{{ year }}</h3>
                                    </div>
                                    <!--{{// events}}-->
                                    <div v-for="month in monthsByYear[year]" :key="month" style="margin-top: 55px;">
                                        <div class="upcome-event-date" >
                                            <h3 style="background-color: rgba(0,119,246,0.00)">{{ moment(month).format('MMMM') }}</h3>
                                        </div>

                                        <div v-for="event in events"
                                             :key="event.id">
                                            <div class="calendar-details"
                                                 v-if="month == moment(event.dateFrom).format('MM') && year == moment(event.dateFrom).format('YYYY')">
                                                <p style="font-size: 10px;background-color: rgba(0,119,246,0.00)" v-if="event.timeFrom !== null" >{{
                                                        event.timeFrom
                                                    }}
                                                    {{ event.timeTo }}</p>
                                                <div class="calendar-box  normal-bg">
                                                    <div class="calandar-event-name">
                                                        <div class="event-square"
                                                             :class="{
                                        'green': getRemainingDays(formattedDate, event.dateTo ?? event.dateFrom) > 15,
                                        'red': getRemainingDays(formattedDate, event.dateTo ?? event.dateFrom) < 7,
                                        'yellow': getRemainingDays(formattedDate, event.dateTo ?? event.dateFrom) >= 7 && getRemainingDays(formattedDate, event.dateTo ?? event.dateFrom) <= 15
                                    }"
                                                             :style="getRemainingDays(formattedDate, event.dateTo ?? event.dateFrom) < 0 ? 'background-color: gray; opacity: 80%' : ''">
                                                            {{
                                                                getRemainingDays(formattedDate, event.dateTo ?? event.dateFrom) === 0 ? usePage().props.auth.user.lang === 'arabic' ? 'اليوم' : 'Today' : getRemainingDays(formattedDate, event.dateTo ?? event.dateFrom)
                                                            }}
                                                        </div>
                                                        <h4 style="cursor: pointer"
                                                            @click="goToCalendar(event.dateFrom)">
                                                            {{ event.title }}</h4>
                                                        <h5>{{
                                                                usePage().props.auth.user.lang == 'arabic' ? ' يصادف يوم ' + arabicDay(event.dateFrom) : 'It falls on ' + moment(event.dateFrom).format('dddd')
                                                            }}</h5>
                                                    </div>
                                                    <span>{{ event.dateFrom }} {{
                                                            event.dateTo !== null ? 'to' : ''
                                                        }} {{ event.dateTo }}</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <v-alert v-else style="margin-top: 70px"
                                     type="info"
                                     variant="tonal"
                            >
                                <v-alert-title style="justify-content: center;display: flex">There is no events
                                </v-alert-title>
                            </v-alert>
                            <div style="display: flex;justify-content: center;margin-top: 5px"
                                 v-if="props.countNextEvent != 0">
                                <a href="javascript:void(0)" @click="showMore" methods="post"
                                   id="showMoreBtn">{{
                                        usePage().props.auth.user.lang == 'arabic' ? 'اظهار المزيد' : 'show more'
                                    }}
                                    <i class="feather-arrow-down"></i> ({{ props.countNextEvent }})</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
        <!--    </div>-->
    </AuthenticatedLayout>
</template>
