<template>
    <div>
        <a-steps v-model:current="current" type="navigation" size="small">
            <a-step
                v-if="$page.props.auth.userRole.includes('send-reminders')"
                title="Send remainders"
                @click="current = 0"
                status="process"
                description="Remainders messages."
            />

            <a-step
                v-if="$page.props.auth.userRole.includes('employer-set-schedule')"
                title="Schedule"
                @click="current = 1"
                status="process"
                description="Set your schedule."
            />
<!--            <a href="javascript:void(0)">-->
            <a-step
                v-if="$page.props.auth.userRole.includes('project-api')"
                @click="current = 2"
                title="API"
                status="process"
                description="Rest api token."
            />
<!--            </a>-->
        </a-steps>
        <div>
        </div>
        <div class="steps-content">
            <div class="card">
                <div class="card-body">
                    <div v-if="current == 0 && $page.props.auth.userRole.includes('send-reminders')">
                        <div class="container">
                            <div class="row" v-if="settings" style="border-radius: 20px;background-color: rgba(0,119,246,0.15)">

                                <v-switch  v-model="eventSettings.sendReminders" inset color="primary"
                                          label="Send remainders"/>
                                <!--                                <InputError class="mt-2" :message="eventSettings.errors.sendReminders" />-->
                                <v-row v-if="eventSettings.sendReminders">
                                    <v-col cols="12">
                                        <v-text-field type="number" v-model="eventSettings.sendBefore"
                                                      label="Before the event"></v-text-field>
                                        <InputError class="mt-2" :message="eventSettings.errors.sendBefore"/>
                                    </v-col>
                                    <!--                                    <v-col cols="12">-->
                                    <!--                                        <v-text-field type="time" v-model="eventSettings.sendTime" label="Send time"></v-text-field>-->
                                    <!--                                        <InputError class="mt-2" :message="eventSettings.errors.sendTime" />-->
                                    <!--                                    </v-col>-->

                                </v-row>

                            </div>
                        </div>
                        <v-sheet style="float: right;padding: 20px 30px">
                            <v-btn type="button" @click="updateEvents" block class="mt-2" style="background-color: #0d6efd">Apply</v-btn>
                        </v-sheet>
                    </div>
                    <div v-if="current == 1 && $page.props.auth.userRole.includes('employer-set-schedule')">

                        <v-table style="border-radius: 20px;background-color: rgba(0,119,246,0.15)">
                            <thead>
                            <tr>
                                <th class="text-left">Check</th>
                                <th class="text-left">Opening time</th>
                                <th class="text-left">Closing time</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr v-for="day in daysE" :key="day.id">
                                <td>
                                    <v-checkbox
                                        v-model="selectedDaysE"
                                        :label="day.label"
                                        :value="day.id"
                                    />
                                </td>
                                <td class="time-inputs mt-16 mr-3">
                                    <v-text-field v-model="day.openingTime"
                                                  :readonly="!selectedDaysE.includes(day.id)" type="time"/>
                                </td>
                                <td class="time-inputs">
                                    <v-text-field v-model="day.closingTime"
                                                  :readonly="!selectedDaysE.includes(day.id)" type="time"/>
                                </td>
                            </tr>
                            </tbody>
                        </v-table>
                        <v-sheet style="float: right;padding: 20px 30px">
                            <v-btn type="button" @click="submitSchedule" block class="mt-2" style="background-color: #0d6efd">Apply</v-btn>
                        </v-sheet>
                    </div>
                    <div v-if="current == 2 && $page.props.auth.userRole.includes('project-api')">
                        <div style="background-color: rgba(0,119,246,0.15); border-radius: 20px">
                            <!--                        <template>-->
                            <v-sheet width="300" class="mx-auto" style="background-color: rgba(0,119,246,0.00)">
                                <v-text-field
                                    label="Rest token"
                                    :append-icon="'mdi-refresh'"
                                    @click:append="generateToken"
                                    v-model="restApiToken.token"
                                    id="token"
                                ></v-text-field>
                            </v-sheet>
                            <v-sheet style="background-color: rgba(0,119,246,0.00)">
                                <h6>last update at {{ moment(settings.updated_at).format('DD/MM/YYYY') }}</h6>
                            </v-sheet>
                            <!--
                                                 </template>-->
                            <v-sheet v-for="apiRoute in apiRoutes" class="mt-5">
                                <v-sheet v-if="apiRoute.uri != 'api/user'"
                                         style="background-color: rgba(0,119,246,0.15);">

                                    <v-card
                                        style="background-color: rgba(0,119,246,0.15);"
                                        max-width="300"
                                    >
                                        <v-list
                                            style="background-color: rgba(0,119,246,0.00)"
                                        >
                                            <v-list-item-title style="background-color: rgba(0,119,246,0.00);">
                                                {{ apiRoute.uri }}
                                            </v-list-item-title>
                                        </v-list>
                                    </v-card>
                                </v-sheet>
                            </v-sheet>
                        </div>

                        <v-sheet style="float: right;padding: 20px 30px">
                            <v-btn type="button" @click="updateToken" block class="mt-2" style="background-color: #0d6efd">Apply</v-btn>
                        </v-sheet>
                    </div>
                </div>
            </div>
        </div>
        <!--        <div class="steps-action">-->
        <!--            <a-button v-if="current < steps.length - 1" type="primary" @click="next">Next</a-button>-->
        <!--            <a-button-->
        <!--                v-if="current == steps.length - 1"-->
        <!--                type="primary"-->

        <!--            >-->

        <!--                Done-->
        <!--            </a-button>-->
        <!--            <a-button v-if="current > 0" style="margin-left: 8px" @click="prev">Previous</a-button>-->
        <!--        </div>-->
    </div>
</template>
<script>
import {defineComponent, onMounted, reactive, ref, watch} from 'vue';
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import {router, useForm, usePage} from "@inertiajs/vue3";

import moment from "moment";
import InputError from "@/Components/InputError.vue";
import {useToast} from "vue-toastification";

export default defineComponent({
    layout: AuthenticatedLayout,
    components: {InputError},
    props: {
        success: Array,
        userSchedule: Array,
        settings: Array,
        apiRoutes: Array,

    },
    setup(props) {
        const userPermission = usePage().props.auth.userRole
        const current = ref()
        if (userPermission.includes('send-reminders')) {
            current.value = 0
        } else if (userPermission.includes('employer-set-schedule')) {
            current.value = 1
        }else if (!userPermission.includes('employer-set-schedule') && userPermission.includes('project-api')) {
            current.value = 2
        }

        const toast = useToast();
        const scheduleDataE = props.userSchedule ?? ''

        const daysE = ref([
            {id: 1, label: 'Monday', openingTime: null, closingTime: null},
            {id: 2, label: 'Tuesday', openingTime: null, closingTime: null},
            {id: 3, label: 'Wednesday', openingTime: null, closingTime: null},
            {id: 4, label: 'Thursday', openingTime: null, closingTime: null},
            {id: 5, label: 'Friday', openingTime: null, closingTime: null},
            {id: 6, label: 'Saturday', openingTime: null, closingTime: null},
            {id: 7, label: 'Sunday', openingTime: null, closingTime: null},
        ]);

        const selectedDaysE = ref([]);
        const settings = props.settings;

        const submitSchedule = () => {
            const selectedDaysDataE = daysE.value.filter(day => selectedDaysE.value.includes(day.id));
            router.post(route('store.employer-schedule'), {
                preserveState: true,
                preserveScroll: true,
                days: selectedDaysDataE,
                onSuccess: () => {
                    toast.success('Successfully updated')
                }
            })
        };

        const next = () => {
            current.value++;
        };
        const prev = () => {
            current.value--;
        };
        // let restApiToken = null
        // if (usePage().props.auth.userRole.includes('project-api') && settings){
          let   restApiToken = useForm({
                token: settings.api_token
            })
    // }
        let updateToken = async () => {
            await restApiToken.post(route('settings.updateToken'), {
                onSuccess: () => {
                    toast.success('Successfully updated')
                }
            })
        }
        let eventSettings = null
        if (usePage().props.auth.userRole.includes('send-reminders') && settings) {
             eventSettings = useForm({
                sendReminders: settings.sendRemainders == 1 ? true : false,
                sendBefore: settings.sendBefore,
                sendTime: settings.sendAt,
            })
        }
        // watch( () => eventSettings, ($eventSettings) =>{
        //     console.log($eventSettings + ' ff')
        //    })

        let updateEvents = async () => {
            await eventSettings.post(route('settings.eventSettings'), {
                preserveState: true,
                preserveScroll: true,
                onSuccess: () => {
                    toast.success('Successfully updated')
                }
            })
        }
        return {
            current,
            steps: [
                {
                    title: '1',
                },
                {
                    title: '2',
                },
                {
                    title: '3',
                },
            ],
            scheduleDataE,
            restApiToken,
            eventSettings,
            selectedDaysE,
            daysE,
            toast,
            updateToken,
            updateEvents,
            submitSchedule,
            next,
            prev,
        };
    },

    methods: {
        moment,
        generateToken() {
            let result = "";
            let characters =
                "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789@$";
            let charactersLength = characters.length;
            for (let i = 0; i < 20; i++) {
                result += characters.charAt(Math.floor(Math.random() * charactersLength));
            }
            this.restApiToken.token = result;
        },


    },
// data(){
// return{
//     scheduleData:usePage().props.auth.schedule
// }
// },

    mounted() {
        if (this.scheduleDataE){
        this.scheduleDataE.forEach(scheduledDay => {
            const day = this.daysE.find(d => d.id === scheduledDay.id);
            if (day) {
                day.openingTime = scheduledDay.openingTime;
                day.closingTime = scheduledDay.closingTime;
                this.selectedDaysE.push(day.id);
            }
        });
        }
    }
});
</script>
<!--<style scoped>-->
<!--.steps-content {-->
<!--    margin-top: 16px;-->
<!--    border: 1px dashed #e9e9e9;-->
<!--    border-radius: 6px;-->
<!--    background-color: #fafafa;-->
<!--    min-height: 200px;-->
<!--    text-align: center;-->
<!--    padding-top: 80px;-->
<!--}-->

<!--.steps-action {-->
<!--    margin-top: 24px;-->
<!--}-->

<!--[data-theme='dark'] .steps-content {-->
<!--    background-color: #2f2f2f;-->
<!--    border: 1px dashed #404040;-->
<!--}-->
<!--</style>-->
