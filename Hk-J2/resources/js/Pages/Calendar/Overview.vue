<template oncopy="return false" onpaste="return false" oncut="return false">
    <AuthenticatedLayout>
        <Head title="Calendar"/>
<!--        <v-sheet class="pa-1 ma-1 wsheet">-->
<!--            <div class="calendar-header">-->
<!--                <div class="navigation">-->
<!--                    <a href="javascript:void(0)" class="today-btn box-sh" @click="navigate('today')">Today</a>-->

<!--                    <div class="header-btns">-->
<!--                        <a href="javascript:void(0)" class="arrows-btns box-sh" @click="navigate('prev')">-->
<!--                            &lt;!&ndash; <div class="icon-co"></div> &ndash;&gt;-->
<!--                            <v-icon class="arrows-icon">-->
<!--                                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 20 20"-->
<!--                                     fill="none">-->
<!--                                    <mask id="mask0_228_10870" style="mask-type:alpha" maskUnits="userSpaceOnUse"-->
<!--                                          x="0" y="0" width="20" height="20">-->
<!--                                        <rect width="20" height="20" fill="#D9D9D9"/>-->
<!--                                    </mask>-->
<!--                                    <g mask="url(#mask0_228_10870)">-->
<!--                                        <path d="M12 15L7 10L12 5L13.0625 6.0625L9.125 10L13.0625 13.9375L12 15Z"-->
<!--                                              fill="#403E48"/>-->
<!--                                    </g>-->
<!--                                </svg>-->
<!--                            </v-icon>-->
<!--                        </a>-->
<!--                        <a href="javascript:void(0)" class="arrows-btns box-sh" @click="navigate('next')">-->
<!--                            <v-icon class="arrows-icon">-->
<!--                                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 20 20"-->
<!--                                     fill="none">-->
<!--                                    <mask id="mask0_228_10874" style="mask-type:alpha" maskUnits="userSpaceOnUse"-->
<!--                                          x="0" y="0" width="20" height="20">-->
<!--                                        <rect x="20" y="20" width="20" height="20" transform="rotate(-180 20 20)"-->
<!--                                              fill="#D9D9D9"/>-->
<!--                                    </mask>-->
<!--                                    <g mask="url(#mask0_228_10874)">-->
<!--                                        <path d="M8 5L13 10L8 15L6.9375 13.9375L10.875 10L6.9375 6.0625L8 5Z"-->
<!--                                              fill="#403E48"/>-->
<!--                                    </g>-->
<!--                                </svg>-->
<!--                            </v-icon>-->
<!--                        </a>-->

<!--                    </div>-->
<!--                    <div class="title">-->
<!--                        &lt;!&ndash;                        {{ currentDate }}&ndash;&gt;-->
<!--                        {{ currentDayName() }}-->
<!--                    </div>-->
<!--                </div>-->
<!--                <div class="mode-picker">-->
<!--                    <div class="search-wr box-sh">-->
<!--                        <a href="javascript:void(0)" class="search-btn" @click="setInputToFocus()">-->
<!--                            <v-icon>-->
<!--                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16"-->
<!--                                     fill="none">-->
<!--                                    <path fill-rule="evenodd" clip-rule="evenodd"-->
<!--                                          d="M7.33398 2.66634C4.75666 2.66634 2.66732 4.75568 2.66732 7.33301C2.66732 9.91034 4.75666 11.9997 7.33398 11.9997C9.91131 11.9997 12.0007 9.91034 12.0007 7.33301C12.0007 4.75568 9.91131 2.66634 7.33398 2.66634ZM1.33398 7.33301C1.33398 4.0193 4.02028 1.33301 7.33398 1.33301C10.6477 1.33301 13.334 4.0193 13.334 7.33301C13.334 10.6467 10.6477 13.333 7.33398 13.333C4.02028 13.333 1.33398 10.6467 1.33398 7.33301Z"-->
<!--                                          fill="#8C8B91"/>-->
<!--                                    <path fill-rule="evenodd" clip-rule="evenodd"-->
<!--                                          d="M10.6289 10.6289C10.8892 10.3685 11.3113 10.3685 11.5717 10.6289L14.4717 13.5289C14.732 13.7892 14.732 14.2113 14.4717 14.4717C14.2113 14.732 13.7892 14.732 13.5289 14.4717L10.6289 11.5717C10.3685 11.3113 10.3685 10.8892 10.6289 10.6289Z"-->
<!--                                          fill="#8C8B91"/>-->
<!--                                </svg>-->
<!--                            </v-icon>-->
<!--                        </a>-->
<!--                        <input type="text" ref="search" class="input-search" placeholder="Type to Search...">-->
<!--                    </div>-->
<!--                    <v-select variant="outlined rounded-pill" class="bg-secondary-pr box-sh" v-model="form.selectedView"-->
<!--                              :items="['Month', 'Week', 'Day']" density="compact"/>-->
<!--                </div>-->
<!--            </div>-->
<!--        </v-sheet>-->
        <v-row justify="center p-3">
            <v-dialog v-model="form.dialog" persistent width="1024">
                <v-card>
                    <v-card-title>
                        <span class="text-h5">{{ form.editMode ? 'Edit Event' : 'Create Event' }}</span>
                    </v-card-title>
                    <v-card-text>
                        <v-container>
                            <v-row>

                                <!--                                                <v-col cols="12">-->
                                <v-text-field
                                    v-model="form.color"
                                    type="color"
                                    maxlength="50"
                                    :label="$page.props.auth .user.lang == 'arabic'? 'الون' : 'Color'"
                                    variant="outlined"/>
                                <InputError :message="form.errors.color"/>
                                <!--                                                </v-col>-->

                                <v-col cols="12">
                                    <v-text-field
                                        maxlength="100"
                                        :label="$page.props.auth .user.lang == 'arabic'? 'العنوان' : 'Title'"
                                        v-model="form.title" required/>
                                    <InputError :message="form.errors.title"/>
                                </v-col>

                                <v-col cols="6">
                                    <v-text-field maxlength="50" type="time"
                                                  :label="$page.props.auth.user.lang == 'arabic'? 'الوقت من' : 'Time from'"
                                                  v-model="form.timeFrom" required/>
                                    <v-text-field
                                        v-model="form.timeFrom" required
                                        :active="menu2"
                                        :focus="menu2"
                                        label="Picker in menu"
                                        prepend-icon="mdi-clock-time-four-outline"
                                        readonly
                                    >
                                        <v-menu
                                            v-model="menu2"
                                            :close-on-content-click="false"
                                            activator="parent"
                                            transition="scale-transition"
                                        >
                                            <v-time-picker
                                                v-if="menu2"
                                                v-model="form.timeFrom"
                                                full-width
                                            ></v-time-picker>
                                        </v-menu>
                                    </v-text-field>
                                    <InputError :message="form.errors.timeFrom"/>
                                </v-col>
                                <v-col cols="6">
                                    <v-text-field  maxlength="50" type="time"
                                                  :label="$page.props.auth.user.lang == 'arabic'? 'الوقت الئ' : 'Time to'"
                                                  v-model="form.timeTo" required/>
                                    <InputError :message="form.errors.timeTo"/>
                                </v-col>
                                <v-col md="6">
                                    <flat-pickr :config="config" class="form-control"
                                                v-model="form.dateFrom"></flat-pickr>
                                    <InputError :message="form.errors.dateFrom"/>
                                </v-col>
                                <v-col md="6">
                                    <flat-pickr class="form-control" :config="config"
                                                v-model="form.dateTo"></flat-pickr>
                                    <InputError :message="form.errors.dateTo"/>
                                </v-col>
                                <!--                                                add color input-->
                                <v-container fluid>
                                    <v-textarea
                                        counter
                                        label="Note(s)"
                                        v-model="form.description"
                                        maxlength="200"></v-textarea>
                                </v-container>
                            </v-row>
                        </v-container>
                        <!--                                        <small>*indicates required field</small>-->
                    </v-card-text>
                    <v-card-actions>
                        <v-spacer></v-spacer>
                        <v-btn color="blue-darken-1" variant="text" @click="form.dialog = false">
                            Close
                        </v-btn>
                        <v-btn v-if="form.editMode" color="blue-darken-1" variant="text"
                               @click="remove">
                            Delete
                        </v-btn>
                        <v-btn color="blue-darken-1" variant="text" @click="submit">
                            {{ form.editMode ? 'Update' : 'Save' }}
                        </v-btn>

                    </v-card-actions>
                </v-card>
            </v-dialog>
        </v-row>
        <!--                            </v-card>-->

        <!--                    </v-stepper>-->
        <!--                </v-stepper-window>-->


        <!--    <div class='demo-app'>-->
        <!--        <div class='demo-app-sidebar'>-->
        <!--            <div class='demo-app-sidebar-section'>-->
        <!--                <h2>Instructions</h2>-->
        <!--                <ul>-->
        <!--                    <li>Select dates and you will be prompted to create a new event</li>-->
        <!--                    <li>Drag, drop, and resize events</li>-->
        <!--                    <li>Click an event to delete it</li>-->
        <!--                </ul>-->
        <!--            </div>-->
        <!--            <div class='demo-app-sidebar-section'>-->
        <!--                <label>-->
        <!--                    <input-->
        <!--                        type='checkbox'-->
        <!--                        :checked='calendarOptions.weekends'-->
        <!--                        @change='handleWeekendsToggle'-->
        <!--                    />-->
        <!--                    toggle weekends-->
        <!--                </label>-->
        <!--            </div>-->
        <!--            <div class='demo-app-sidebar-section'>-->
        <!--                <h2>All Events ({{ currentEvents.length }})</h2>-->
        <!--                <ul>-->
        <!--                    <li v-for='event in currentEvents' :key='event.id'>-->
        <!--                        <b>{{ event.startStr }}</b>-->
        <!--                        <i>{{ event.title }}</i>-->
        <!--                    </li>-->
        <!--                </ul>-->
        <!--            </div>-->
        <!--        </div>-->
        <v-row class="disable-user-select">
            <v-col cols="12">
                <v-card class="vcard border-r-20 border-secondary-color-2" elevation="0">
                    <v-card-text>
<!--                        <div class="border-r-20">-->
                            <FullCalendar class="border-r-20" id="calendar" ref="calendar" @update-calendar="updateCalendar"
                                          :event-render="handleEventRender" @eventDrop="handleEventDrop"
                                          :options="calendarOptions"/>
<!--                        </div>-->
                    </v-card-text>
                </v-card>
                <!-- Uncomment the following section if you have a button -->
                <!-- <v-btn @click="openAddEventModal" color="info" class="mt-1">
                  Add Event
                </v-btn> -->
            </v-col>
        </v-row>

    </AuthenticatedLayout>
</template>
<script lang="js">
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import {defineComponent, watch, getCurrentInstance, watchEffect} from "vue";
import FullCalendar from "@fullcalendar/vue3";
import {useForm, usePage} from "@inertiajs/vue3";
import dayGridPlugin from "@fullcalendar/daygrid";
import timeGridPlugin from "@fullcalendar/timegrid";
import interactionPlugin from "@fullcalendar/interaction";
import {eventDetails} from "@/Pages/Calendar/TestCalendar";
import Modal from "@/Components/Modal.vue";
import moment from 'moment';
import InputError from "@/Components/InputError.vue";
import FlatPickr from 'vue-flatpickr-component';
import {Head} from "@inertiajs/vue3";
import 'flatpickr/dist/flatpickr.css';

let dataToRender = []
export default defineComponent({
    // layout: AuthenticatedLayout,
    props: {
        events: Object,
    },
    computed: {},
    components: {
        Head,
        AuthenticatedLayout,
        InputError,
        FullCalendar,
        useForm,
        FlatPickr,
        Modal
    },

    mounted() {
        this.$nextTick(() => {
            const {props} = usePage();
            const date = props.date ?? new Date();
            this.refs.calendar.getApi().gotoDate(date);
            // console.log(this.refs.calendar.getApi())

        });
        // let width = ref()

        // let windowWidth = window.windowWidth;
        window.addEventListener("resize", this.handleResize);

        let calendarApi = this.$refs.calendar.getApi();
        // if (windowWidth <= 400){

        // calendarApi.changeView('timeGridWeek')
        // }
    },
    data() {

        // function testCalendar() {
        let windowWidth = window.innerWidth;
        let items = [
            '1',
            '2',
            'Submit',
        ]
        return {
            menu2: false,
            modal2: false,
            selectedView: 'Month',
            currentDate: '',
            status: true,
            search: false,
            items,
            // windowWidth,
            config: {
                wrap: false,
                altFormat: 'M j, Y',
                // altInput: true,
                dateFormat: 'Y-m-d',
                allowInput: true
            },
            calendarOptions: {
                plugins: [
                    // CustomViewCalendar,
                    dayGridPlugin,
                    timeGridPlugin,
                    interactionPlugin // needed for dateClick
                ],
                headerToolbar: {
                    left: 'prev,next today',
                    //premium
                    center: 'title',
                    right: 'dayGridMonth,timeGridWeek,timeGridDay'
                },
                buttonText: this.customButtonsName(),
                //  locale: esLocale,
                initialView: 'dayGridMonth',
                // initialView: windowWidth <= 400 ? 'timeGridWeek' : 'dayGridMonth',

                // initialEvents: INITIAL_EVENTS, // alternatively, use the `events` setting to fetch from a feed
                editable: true,
                selectable: true,
                selectMirror: true,
                dayMaxEvents: true,
                weekends: true,
                select: this.handleDateSelect,
                eventClick: this.handleEventClick,
                eventDrop: this.handleEventDrop,
                eventResize: this.handleEventResize,
                dayHeaderContent: this.customDayHeaderContent,
                // eventsSet: this.handleEvents
                /* you can update a remote database when these fire:
                eventAdd:
                eventChange:
                eventRemove:
                */
                // initialEvents: t,
                // eventDidMount: function(info) {
                //     $(info.el).find(".fc-event-title").prepend("<b style='display: block'>"+getRemainingDays(info.event.dateTo)+"</b>");
                // },
                events: (info, success, fail) => {
                    $.get('/calendar/events', function (data) {
                        let dataToRender = data.events.map(x => {
                            x.start = x.timeFrom ? `${x.dateFrom}T${x.timeFrom}` : x.dateFrom;
                            x.end = x.timeTo ? `${x.dateTo}T${x.timeTo}` : x.dateTo;
                            x.color = `${x.color === 'null' ? '#ff9900' : x.color}`
                            if (!x.timeFrom) {
                                x.displayEventTime = false
                                x.start = `${x.dateFrom}`
                                x.end = `${x.dateTo}`;
                                x.allDay = true
                            }
                            return x;
                        });
                        success(dataToRender);
                    })
                }

            },

        }

    },
    setup() {
        const internalInstance = getCurrentInstance();

        const handleEventDrop = (eventDropInfo) => {
            const eventId = eventDropInfo.event.id;
            const newStart = moment(eventDropInfo.event.start).format('YYYY-MM-DD')
            const newEnd = moment(eventDropInfo.event.end).format('YYYY-MM-DD')
                ? moment(eventDropInfo.event.end).format('YYYY-MM-DD')
                : null;
            form.color = eventDropInfo.event.backgroundColor;
            form.title = eventDropInfo.event.title
            form.timeFrom = eventDropInfo.event.extendedProps.timeFrom
            form.timeTo = eventDropInfo.event.extendedProps.timeTo
            form.dateFrom = newStart
            form.dateTo = newEnd
            form
                .post(route('calendar.update', eventId), {
                    preserveScroll: true
                })
        };

        /// route's object
        let routeName = {
            route: null,
            params: null
        };

        let form = useForm({
            title: '',
            color: '',
            timeFrom: '',
            timeTo: '',
            editMode: false,
            selectedView: 'Day',
            resize: false,
            remove: false,
            dialog: false,
            description: '',
            dateFrom: eventDetails.value[0],
            dateTo: eventDetails.value[1],
        })
        // watch(() => form.selectedView, async (newView) => {
        //     await this.$nextTick(); // Wait for the next update cycle
        //
        //     if (this.refs.calendar) {
        //         const calendarApi = this.refs.calendar.getApi();
        //         calendarApi.changeView(
        //             newView === 'Month'
        //                 ? 'dayGridMonth'
        //                 : newView === 'Week'
        //                     ? 'timeGridWeek'
        //                     : newView === 'Day'
        //                         ? 'timeGridDay'
        //                         : 'dayGridMonth'
        //         );
        //         this.currentDayName();
        //     }
        // }, { immediate: true });
        //
        // watchEffect(() => {
        //     const calendarApi = this.$refs.calendar.getApi();
        //     calendarApi.changeView(
        //         this.selectedView === 'Month' ? 'dayGridMonth'
        //             : this.selectedView === 'Week' ? 'timeGridWeek'
        //                 : this.selectedView === 'Day' ? 'timeGridDay'
        //                     : 'dayGridMonth'
        //     );
        //     this.currentDayName();
        //     console.log('change view');
        // });


        watch(() => eventDetails, ($eventDetails) => {
            // console.log( moment($eventDetails.value[$eventDetails.value.length - 1].start).format('HH:mm'))
            if (moment($eventDetails.value[$eventDetails.value.length - 1].start).format('HH:mm') !== '00:00') {
                form.timeFrom = moment($eventDetails.value[$eventDetails.value.length - 1].start).format('HH:mm')
                form.timeTo = moment($eventDetails.value[$eventDetails.value.length - 1].end).format('HH:mm')
            } else {
                form.timeFrom = ''
                form.timeTo = ''
            }
            if (moment($eventDetails.value[$eventDetails.value.length - 1].end).subtract(1, "days").format('YYYY-MM-DD') == moment($eventDetails.value[$eventDetails.value.length - 1].start).format('YYYY-MM-DD')) {
                form.dateFrom = moment($eventDetails.value[$eventDetails.value.length - 1].start).format('YYYY-MM-DD')
                form.dateTo = null;
            } else {
                form.dateFrom = moment($eventDetails.value[$eventDetails.value.length - 1].start).format('YYYY-MM-DD')
                form.dateTo = moment($eventDetails.value[$eventDetails.value.length - 1].end).format('YYYY-MM-DD')
            }
        }, {deep: true})

        function updateCalendar() {
            // Fetch updated events data from API or database
            $.get('/calendar/events', (data) => {
                dataToRender = data.events.map(x => {
                    x.start = x.timeFrom ? `${x.dateFrom}T${x.timeFrom}` : x.dateFrom;
                    x.end = x.timeTo ? `${x.dateTo}T${x.timeTo}` : x.dateTo;
                    x.color = `${x.color}`;
                    if (!x.timeFrom) {
                        x.start = `${x.dateFrom}`
                        x.end = `${x.dateTo}`;
                        x.allDay = true
                    }
                    return x;
                });
                // Call success() to pass updated events data to the calendar
                internalInstance.proxy.calendarOptions.events = (info, success, fail) => {
                    success(dataToRender);
                }

                // Call updateEvents() on calendarApi object to update events on the calendar
                let calendarApi = this.$refs.calendar.getApi(); // Get calendarApi object
                calendarApi.refetchEvents(); // Update events on the calendar
            });
        }

        // this.$nextTick(() => {
        //     this.$refs.fullCalendar.calendar.gotoDate(new Date('2020-08-11'));
        //
        // });
        let submit = async () => {
            const routeToSave = form.editMode ? route(routeName.route, routeName.params) : route('calendar.add');
            await form.post(form.remove ? route('calendar.remove', routeName.params) : routeToSave, {
                preserveScroll: true,
                onSuccess: () => {
                    form.dialog = false
                    // $('#con-close-modal').modal('toggle')
                    // form.reset('title')
                    form.reset()
                    updateCalendar();

                },
            });
        };

        let remove = async () => {
            form.remove = true
            submit()
        }
        return {remove, form, submit, updateCalendar, routeName, handleEventDrop}
    },


    methods: {
        // currentDayName() {
        //     // console.log(this.$ref.datePicker.getApi())
        //
        //     const test = this.$refs.calendar.getApi();
        //     this.currentDate = test.currentData.viewTitle
        //     return this.currentDate
        // },
        // navigate(action) {
        //     const calendarApi = this.$refs.calendar.getApi();
        //     console.log(calendarApi)
        //     switch (action) {
        //         case 'next':
        //             calendarApi.next();
        //             this.currentDayName()
        //             console.log(calendarApi)
        //             break;
        //         case 'prev':
        //             calendarApi.prev();
        //             this.currentDayName()
        //             break;
        //         case 'today':
        //             calendarApi.today();
        //             this.currentDayName()
        //             this.selectedDate = moment(new Date).format('YYYY-MM-DD')
        //             break;
        //     }
        // },
        setInputToFocus() {
            this.status = !this.status;
            this.$refs.search.focus() //:  this.$refs.search.blur()
        },
        updateWindowWidth() {
            // Update the windowHeight data property when the window is resized
            this.windowWidth = window.innerWidth;
        },
        beforeDestroy() {
            // Remove the event listener when the component is destroyed to prevent memory leaks
            window.removeEventListener("resize", this.handleResize);
        },
        customButtonsName() {
            const lang = usePage().props.auth.user.lang;
            return lang === 'arabic'
                ? {today: 'اليوم', month: 'الشهر', week: 'الاسبوع', day: 'يوم'}
                : {today: 'today', month: 'month', week: 'week', day: 'day'};
        },
        customDayHeaderContent(arg) {
            const customDayNames = usePage().props.auth.user.lang == 'arabic' ? ['الاحد', 'الاثنين', 'الثلاثاء', 'الاربعاء', 'الخميس', 'الاجمعة', 'السبت'] : ['SU', 'MO', 'TU', 'WE', 'TH', 'FR', 'SA'];

            console.log(arg)
            return customDayNames[arg.date.getUTCDay()];
        },
        handleEventRender(info) {
            const event = info.event
            // console.log(info)
            // Check if the event's title is '12a'
            if (event.timeTo === '23:59:00') {
                event.setProp('displayEventTime', false)
            }
        },
        getRemainingDays(dateTo) {
            const start = new Date();
            const end = moment(dateTo);
            const duration = moment.duration(end.diff(start));

            const days = duration.asDays();

            return Math.ceil(days);

        },

        openAddEventModal() {
            this.routeName.route = 'calendar.add'
            this.form.title = '';
            this.form.color = '';
            this.form.timeFrom = '';
            this.form.timeTo = '';
            this.form.dateFrom = null;
            this.form.dateTo = null;
            this.form.editMode = false
            this.form.dialog = true
            // Open the add event modal
            // $('#con-close-modal').modal('show');
        },
        handleWeekendsToggle() {
            this.calendarOptions.weekends = !this.calendarOptions.weekends // update a property
        },
        handleDateSelect(selectInfo) {
            eventDetails.value.push(selectInfo)
            this.routeName.route = 'calendar.add'
            this.form.title = '';
            this.form.color = '';
            // this.form.dateFrom = selectInfo[0];
            // this.form.dateTo = selectInfo[1];
            // this.form.timeFrom = '';
            // this.form.timeTo = '';
            this.form.dialog = true
            this.form.editMode = false
            // $('#con-close-modal').modal('show')
        },

        handleEventClick(clickInfo) {
            // if (confirm(`Are you sure you want to delete the event '${clickInfo.event.title}'`)) {
            this.form.dialog = true
            this.form.editMode = true
            this.routeName.route = 'calendar.update'
            this.routeName.params = clickInfo.event.id
            // eventEditDetails.value.push(clickInfo.event)
            this.form.title = clickInfo.event.title;
            this.form.color = clickInfo.event.backgroundColor;
            this.form.description = clickInfo.event.extendedProps.description;
            this.form.timeFrom = clickInfo.event.extendedProps.timeFrom;
            this.form.timeTo = clickInfo.event.extendedProps.timeTo;
            this.form.dateFrom = clickInfo.event.extendedProps.dateFrom;
            this.form.dateTo = clickInfo.event.extendedProps.dateTo;
            // }
        },
        handleEventResize(info) {
            this.form.eId = info.event.id
            this.form.title = info.event.title
            this.form.color = info.event.backgroundColor;
            this.form.timeFrom = info.event.extendedProps.timeFrom
            this.form.timeTo = info.event.extendedProps.timeTo
            this.form.dateFrom = info.event.extendedProps.dateFrom
            this.form.dateTo = moment(info.event.end).format('YYYY-MM-DD')
            this.form.post(route('calendar.update', info.event.id), {
                preserveScroll: true,
            })

        },
        handleEvents(events) {
            // console.log(events)
            this.currentEvents = events
        },

    },

})

</script>
<style lang="css">
.fc-day-today {
    background-color: inherit !important;


}

.fc-day-today .fc-daygrid-day-number {
    z-index: 9999;
    display: flex;
    width: 32px;
    height: 32px;
    color: #ffffff;
    justify-content: center;
    align-items: center;
    border-radius: 56px;
    background: #1c72a2;

}

.fc .td,
th {
    border-bottom: none !important;
}

.fc .fc-button .fc-icon {
    font-size: 1.5em;
    position: relative;
    top: -4px;
    vertical-align: middle;
}

.calendar-header {
    display: flex;
    padding: 16px 24px;
    background-color: #FBFAFB;
    justify-content: space-between;
    align-items: center;
    align-self: stretch;
    gap: 24px !important;
}

.navigation {
    display: flex;
    align-items: center;
    gap: 24px;
    background: transparent;
    cursor: pointer;
    border-radius: 29px;
    transition: background-color 0.3s ease;

    button {
        &:hover {
            background-color: #ffffff;
        }
    }
}

.title {
    color: #403E48;
    font-size: 24px;
    font-style: normal;
    font-weight: 600;
    line-height: 130%;
}

.today-btn {
    cursor: pointer;
    border-radius: 29px;
    transition: background-color 0.3s ease;
    background-color: #ffffff;
    display: flex;
    padding: 8px 12px;
    justify-content: flex-end;
    align-items: center;
    gap: 4px;

    &:hover {
        background-color: #ffffff;
    }
}

.arrows-btns {
    &:hover {
        background-color: #ffffff;
    }

    background-color: #ffffff;
    border-radius: 29px;
    padding: 8px 12px;
    display: inline-flex;
    width: 40px;
    height: 40px;
    justify-content: center;
    align-items: center;
    gap: 4px;
}

.search-wr {
    background-color: #ffffff;
    border-radius: 29px;
    height: 40px;
}

.search-btn {
    background-color: #ffffff;
    border-radius: 29px;
    padding: 8px 12px;
    display: inline-flex;
    width: 42px;
    height: 40px;
    justify-content: center;
    align-items: center;
    gap: 4px;
}

.input-search {
    width: 0px;
    border-style: none;
    outline: none;
    border-radius: 29px;
    transition: all .5s ease-in-out;
    background-color: #ffffff !important;
    color: #fff;

    &:focus {
        color: #000;
        width: 300px;
        border-radius: 0px;
        background-color: transparent;
        /*border-bottom: 1px solid #EDEBEF;*/
        transition: all 500ms cubic-bezier(0, 0.110, 0.35, 2);

    }
}

.mode-picker {
    display: flex;
    width: fit-content;
    height: fit-content;
    align-items: center;
    gap: 12px;
}

.mode-picker .v-select__menu-icon {
    left: 10px;
    margin-inline-start: 16px;
    opacity: 100%;
    transition: 0.2s cubic-bezier(0.4, 0, 0.2, 1);
}

.mode-picker .v-input .v-input__control .v-text-field .v-input__details {
    width: 160px;
    padding-inline-start: 24px;
    padding-inline-end: 56px;
}

.mode-picker .v-input__details {
    display: none !important;
}

.mode-picker .v-select {
    background-color: #ffffff !important;
    border-radius: 29px;
    width: 160px;
}
</style>
