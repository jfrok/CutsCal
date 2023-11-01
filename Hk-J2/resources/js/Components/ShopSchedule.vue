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

    // onMounted(() => {
        if (intervalData != usePage().props.auth.interval.interval) {
            watch(intervalData, debouncedSubmitSchedule);
        }
    // });
}


</script>
<template>
    <div style="overflow-y: scroll;">
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
        <v-card title="Schedule" class="rounded-card">
            <v-card-text>
                <v-table>
                    <thead>
                    <tr>
                        <th class="text-left">Check</th>
                        <th class="text-left">Opening time</th>
                        <th class="text-left">Closing time</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td style="padding: 20px">
                            <v-text-field v-model="interval" label="Interval" type="number"/>
<!--                            <input-error :message="interval.error"/>-->
                        </td>
                    </tr>
                    <tr v-for="day in days" :key="day.id">
                        <td>
                            <v-checkbox
                                v-model="selectedDays"
                                :label="day.label"
                                :value="day.id"
                            />
                        </td>
                        <td class="time-inputs mt-16 mr-3">
                            <v-text-field v-model="day.openingTime"
                                          :readonly="!selectedDays.includes(day.id)" type="time"/>
                        </td>
                        <td class="time-inputs">
                            <v-text-field v-model="day.closingTime"
                                          :readonly="!selectedDays.includes(day.id)" type="time"/>
                        </td>
                    </tr>

                    </tbody>
                </v-table>
            </v-card-text>

        </v-card>
    </div>
</template>
