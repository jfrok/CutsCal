<script>
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import {defineComponent} from "vue";
import eventModal from "@/Components/EventModal.vue";
import FullCalendar from "@fullcalendar/vue3";
import {useForm} from "@inertiajs/vue3";
import EventModal from "@/Components/EventModal.vue";
import dayGridPlugin from "@fullcalendar/daygrid";
import timeGridPlugin from "@fullcalendar/timegrid";
import interactionPlugin from "@fullcalendar/interaction";
import {eventDetails} from "@/Pages/Calendar/TestCalendar";

import {data} from "autoprefixer";

let allEvents = []
// let calendar = this.$parent.$parent.$refs.calsession.getApi()

export default defineComponent({
    layout:AuthenticatedLayout,
    computed: {
        eventModal() {
            return eventModal
        }
    },
    components: {
        FullCalendar,
        useForm,
        EventModal
    },
    data() {
        // function testCalendar() {
        return {
            calendarOptions: {
                plugins: [
                    dayGridPlugin,
                    timeGridPlugin,
                    interactionPlugin // needed for dateClick
                ],
                headerToolbar: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'dayGridMonth,timeGridWeek,timeGridDay'
                },
                initialView: 'dayGridMonth',
                // initialEvents: INITIAL_EVENTS, // alternatively, use the `events` setting to fetch from a feed
                editable: true,
                selectable: true,
                selectMirror: true,
                dayMaxEvents: true,
                weekends: true,
                select: this.handleDateSelect,
                eventClick: this.handleEventClick,
                // eventsSet: this.handleEvents
                /* you can update a remote database when these fire:
                eventAdd:
                eventChange:
                eventRemove:
                */
                events: (info, success, fail)=>{
                    $.get('/calendar/events',function (data){
                        // console.log(data)
                        // ALL RIGHHTS RESEVED BY JAFAAAR!!!! 2023c

                        let dataToRender = data.events.map(x=>{
                            x.start = x.dateFrom;
                            x.end =  x.dateTo;
                            // if(!x.time_from){
                            x.allDay = true;
                            //  }
                            return x;
                        });
                        console.log(dataToRender)
                        success(dataToRender);
                    })
                },
            },


            // currentEvents: [$.get('/calendar/events', function (data){
            //    allEvents.push(data)
            // })],
            // eventRender: allEvents,
            // events: [
            //     { title: 'event 1', start: '2023-04-01', allDay:true, },
            //     // { title: 'event 2', start: '2023-04-02' }
            // ],

            // }
            updateCalendar() {
                // Fetch updated events data from API or database
                $.get('/calendar/events', (data) => {
                    let dataToRender = data.events.map(x => {
                        x.start = x.dateFrom;
                        x.end = x.dateTo;
                        x.allDay = true;
                        return x;
                    });

                    // Call success() to pass updated events data to the calendar
                    this.calendarOptions.events = (info, success, fail) => {
                        success(dataToRender);
                    }

                    // Call updateEvents() on calendarApi object to update events on the calendar
                    let calendarApi = this.$refs.calendar.getApi(); // Get calendarApi object
                    calendarApi.refetchEvents(); // Update events on the calendar
                });
            }
        }

    },
    methods: {

        handleWeekendsToggle() {
            this.calendarOptions.weekends = !this.calendarOptions.weekends // update a property
        },
        handleDateSelect(selectInfo) {
            let title = document.getElementById('title').value
            //while(eventDetails.length > 0) {
            //  if(!eventDetails.length){
            //       eventDetails = [];
            eventDetails.value.push(selectInfo.startStr,selectInfo.endStr)
            //  }
            // }
            console.log(selectInfo)
            $('#con-close-modal').modal('show')

            let calendarApi = selectInfo.view.calendar

            calendarApi.unselect() // clear date selection
            //
            if (title) {
                /// database insert here
                calendarApi.addEvent({
                    //id: createEventId(),
                    title,
                    start: selectInfo.startStr,
                    end: selectInfo.endStr,
                    allDay: selectInfo.allDay

                })

            }
        },

        handleEventClick(clickInfo) {
            if (confirm(`Are you sure you want to delete the event '${clickInfo.event.title}'`)) {
                clickInfo.event.remove()
            }
        },
        handleEvents(events) {
            console.log(events)
            this.currentEvents = events
        },

    }

})
function getRefreshEvents()
{
// .refetchEvents()
    //  $.get('/calendar/events',function (data){
    this.updateCalendar
    //  })
}
</script>
<script setup>
import {useForm} from "@inertiajs/vue3";
import {ref, watch} from "vue";
allEvents = ref([])


let form = useForm({
    title: '',
    dateFrom: eventDetails.value[0],
    dateTo: eventDetails.value[1],
})
watch(() =>eventDetails, ($eventDetails) =>{
    console.log($eventDetails.value)
    form.dateFrom = $eventDetails.value[0]
    form.dateTo = $eventDetails.value[1]
},{deep: true})

// watch(props.events, (newValue, oldValue) => {
//     calendarOptions.events = newValue;
// })
let submit = () => {
    form.post(route('calendar.add'), {
        getRefreshEvents
    });
}
function openModal()
{
    //do something here
    console.log('test');
    $('#con-close-modal').modal('show')
}

</script>

<template>
    <!--        <button type="button" class="btn btn-success waves-effect waves-light mt-1" data-bs-toggle="modal" data-bs-target="#con-close-modal">Responsive Modal</button>-->
    <!--        <button type="button" @click="openModal()">Responsive Modal</button>-->
    <div id="con-close-modal" class="modal fade" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">Modal Content is Responsive</h4>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form method="post" @submit.prevent="submit">
                    <div class="modal-body p-4">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="mb-3">
                                    <label for="field-1" class="form-label">Title</label>
                                    <input type="text" v-model="form.title" name="title" id="title" class="form-control" placeholder="appointment">
                                </div>
                            </div>

                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="field-4" class="form-label">Date from</label>
                                    <input type="text"  name="dateFrom" id="dateFrom" v-model="form.dateFrom" class="form-control">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="field-5" class="form-label">Date to</label>
                                    <input type="date" v-model="form.dateTo" name="dateTo" id="dateTo" class="form-control">
                                </div>
                            </div>
                        </div>
                        <!--                    <div class="row">-->
                        <!--                        <div class="col-md-12">-->
                        <!--                            <div class="">-->
                        <!--                                <label for="field-7" class="form-label">Personal Info</label>-->
                        <!--                                <textarea class="form-control" id="field-7" placeholder="Write something about yourself"></textarea>-->
                        <!--                            </div>-->
                        <!--                        </div>-->
                        <!--                    </div>-->
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary waves-effect" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-info waves-effect waves-light">Save changes</button>
                    </div>
                </form>
            </div>

        </div>
    </div>
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
    <div class='demo-app-main'>
        <FullCalendar
            class='demo-app-calendar'
            :options='calendarOptions'

        >
            <div>
                <!--                    <b>{{ value.timeText }}</b>-->
                <i v-for="(value,key,index) in calendarOptions">{{ value.event.title }}</i>
            </div>
        </FullCalendar>
    </div>
</template>
