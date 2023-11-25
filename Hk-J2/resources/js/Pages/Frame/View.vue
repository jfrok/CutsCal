<script>
import {Link, usePage} from "@inertiajs/vue3";
import FlatPickr from 'vue-flatpickr-component';
import 'flatpickr/dist/flatpickr.css';
import moment from 'moment';
import ReservationTemp from "@/Components/ReservationTemp.vue";

export default {
    components: {
        ReservationTemp,
        Link,
        FlatPickr
    },
    props: {
        errors: Object,
        employers: Object,
        services: Array,
        schedule: Array,
        availableTimesByDay: Array,
    },
    data: () => ({
        current: 1,
        config: null,
        rToken: usePage().url.replace('/make-a-reservation/',''),
        date: null,
        headers: [
            {text: 'Name', value: 'name'},
            {text: 'Price', value: 'price', align: 'end'}
        ],
        selected: [],
        selectedIndices: [],
        selectedEmployer: []
    }),
    watch: {
        schedule: {
            handler(newSchedule) {
                this.updateConfig();
            },
            immediate: true,
        },
    },
    methods: {
        usePage,
        setCookie() {
            $cookies.set('r-token',this.rToken)
            // this.rToken = usePage().url.replace('/make-a-reservation/','')
        },
        getDayNumber(date) {
            return new Date(date).getDay();
        },
        formatDate(date) {
            return moment(date).format('dddd');
        },
        toggleSelection(itemId) {
            const index = this.selectedIndices.indexOf(itemId);
            if (index === -1) {
                this.selectedIndices.push(itemId);
            } else {
                this.selectedIndices.splice(index, 1);
            }
        },
        toggleSelectionEmployees(itemId) {
            const index = this.selectedEmployer.indexOf(itemId);
            if (index === -1) {
                this.selectedEmployer.splice(0, this.selectedEmployer.length);
                this.selectedEmployer.push(itemId);
            } else {
                this.selectedEmployer.splice(index, 1);
            }
        },
        isSelected(index) {
            return this.selectedIndices.includes(index);
        },
        updateConfig() {
            this.config = {
                wrap: false,
                altFormat: 'M j, Y',
                minDate: "today",
                maxDate: new Date().fp_incr(30),
                dateFormat: 'Y-m-d',
                inline: true,
                disable: [
                    (date) => {
                        const dayIndex = date.getDay();
                        const daySchedule = this.schedule.find(item => item.id === dayIndex);
                        return !daySchedule || daySchedule.openingTime === null || daySchedule.closingTime === null;

                    }
                ]
            };
        }
    },
    created() {
        this.updateConfig();
    },
    mounted() {
        this.setCookie()
    }
}
</script>

<template>
    <div class="row">
        <ReservationTemp :employers="employers" :services="services" :schedule="schedule"
                         :available-times-by-day="availableTimesByDay"  :frame-token="rToken" :errors="errors"/>
    </div>
</template>
