<template>
    <div class="overflow-y-scroll">
        <!--            sdule-->
        <v-toolbar v-if="includeBtn"
                   dark
                   color="primary"
        >
            <v-btn
                icon
                dark
                @click="emit('close-dialog',false)"
            >
                <v-icon>mdi-close</v-icon>
            </v-btn>
            <v-toolbar-title>Settings</v-toolbar-title>
            <v-spacer></v-spacer>
            <v-toolbar-items>
                <v-btn
                    variant="text"
                    @click="submitSchedule"
                >
                    Save
                </v-btn>
            </v-toolbar-items>
        </v-toolbar>
        <v-card  class="rounded-card">
            <v-card-text>
                <h4 class="h4 font-weight-thin mb-7">Interval</h4>
                <v-text-field v-model="interval" label="Interval" color="primary" variant="outlined" type="number"/>
                <h4 class="h4 font-weight-thin mb-7 mt-7">Schedule</h4>
                <v-table class="sch-table bg-official-secondary">
                    <thead>
                    <tr>
                        <th class="text-left">Check</th>
                        <th class="text-left">Opening time</th>
                        <th class="text-left">Closing time</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr v-for="day in days" :key="day.id">
                        <td class="align-items-center d-flex">
                            <v-checkbox
                                v-model="selectedDays"
                                :label="day.label"
                                :value="day.id"
                            />
                        </td>
                        <td class="time-inputs mt-16 mr-3 ">
                            <v-text-field v-model="day.openingTime" variant="text"
                                          :readonly="!selectedDays.includes(day.id)" type="time"/>
                        </td>
                        <td class="time-inputs">
                            <v-text-field variant="text" v-model="day.closingTime"
                                          :readonly="!selectedDays.includes(day.id)" type="time"/>
                        </td>
                    </tr>

                    </tbody>
                </v-table>
            </v-card-text>
        </v-card>
    </div>
</template>
<script setup>
import {router, usePage} from "@inertiajs/vue3";
import {computed, onMounted, ref, watch} from "vue";
import _ from 'lodash';

let props = defineProps({
    includeBtn: Boolean
})

const scheduleData = usePage().props.auth.schedule ?? '';
if (usePage().props.auth.userRole.includes('schedule-list') || usePage().props.auth.userRole.includes('schedule-edit') && scheduleData.length > 0) {
    onMounted(() => {
        scheduleData.forEach(scheduledDay => {
            const day = days.value.find(d => d.id === scheduledDay.id);
            if (day) {
                day.openingTime = scheduledDay.openingTime;
                day.closingTime = scheduledDay.closingTime;
                selectedDays.value.push(day.id);
            }
        });
    });
}

// console.log(usePage().props.auth.schedule)
const days = ref([
    {id: 0, label: 'Sunday', openingTime: null, closingTime: null},
    {id: 1, label: 'Monday', openingTime: null, closingTime: null},
    {id: 2, label: 'Tuesday', openingTime: null, closingTime: null},
    {id: 3, label: 'Wednesday', openingTime: null, closingTime: null},
    {id: 4, label: 'Thursday', openingTime: null, closingTime: null},
    {id: 5, label: 'Friday', openingTime: null, closingTime: null},
    {id: 6, label: 'Saturday', openingTime: null, closingTime: null},
]);
const selectedDays = ref([]);
const interval = ref(usePage().props.auth.interval.interval);

const selectedDaysData = computed(() => {
    return days.value.filter(day => selectedDays.value.includes(day.id));
});
const computedTimes = computed(() => {
    return selectedDaysData.value.map(day => ({
        openingTime: day.openingTime,
        closingTime: day.closingTime,
    }));
});

const intervalData = computed(() => {
    return interval.value
});
const emit = defineEmits(['close-dialog']);

const submitSchedule = () => {
    emit('close-dialog', false);
    router.post(route('store.schedule'), {
        days: selectedDaysData.value,
        interval: intervalData.value,
    }, {
        preserveScroll: true,
        preserveState: true,
    });
};
const debouncedSubmitSchedule = _.debounce(submitSchedule, 250);

if (!props.includeBtn) {
    watch(selectedDaysData, debouncedSubmitSchedule);
    watch(computedTimes, debouncedSubmitSchedule);

    // onMounted(() => {
    if (intervalData != usePage().props.auth.interval.interval) {
        watch(intervalData, debouncedSubmitSchedule);
    }
    // });
}


</script>
