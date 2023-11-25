<template>
    <div class="row justify-center">

        <v-card

            :loading="loading"
            class="mx-auto my-12"
            :max-width="isMobileC ? 350 : 474"
        >

            <template v-slot:loader="{ isActive }">
                <v-progress-linear
                    :active="isActive"
                    color="deep-purple"
                    height="4"
                    indeterminate
                ></v-progress-linear>
            </template>
            <v-card-item>

                <v-card-title>{{
                        current == 1 ? 'Calendar' : current == 2 ? 'Services' : current == 3 ? 'Barbers' : current == 4 ? 'Time' : current == 5 ?'Personal information' : 'Thank you'
                    }}
                </v-card-title>

                <v-card-subtitle>
                    <!--                                    <span class="me-1">Local Favorite</span>-->

                    <!--                                    <v-icon-->
                    <!--                                        color="error"-->
                    <!--                                        icon="mdi-fire-circle"-->
                    <!--                                        size="small"-->
                    <!--                                    ></v-icon>-->
                </v-card-subtitle>
            </v-card-item>

            <v-card-text>
                <v-row
                    align="center"
                    class="mx-0"
                >
                    <!--                                    <v-rating-->
                    <!--                                        :model-value="4.5"-->
                    <!--                                        color="amber"-->
                    <!--                                        density="compact"-->
                    <!--                                        half-increments-->
                    <!--                                        readonly-->
                    <!--                                        size="small"-->
                    <!--                                    ></v-rating>-->

                    <!--                                    <div class="text-grey ms-4">-->
                    <!--                                        4.5 (413)-->
                    <!--                                    </div>-->
                </v-row>

                <div class="my-4 text-subtitle-1">
                </div>

                <div v-if="current == 1" style="display: flex;justify-content: center">
                    <flat-pickr style="display: none" v-model="date" :config="config" class="form-control"/>
                </div>
                <div v-if="current == 2">
                    <v-sheet border>
                        <v-table>
                            <thead>
                            <tr>
                                <th>Name</th>
                                <th class="text-end">Price</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr v-for="item in services" :key="item.id"
                                :style="`cursor: pointer; ${selectedIndices.includes(item.id) ? 'background-color: #f2f8ff;' : ''} `"
                                @click="toggleSelection(item.id)">
                                <td v-text="item.name"></td>
                                <td class="text-end" v-text="item.price"></td>
                            </tr>
                            </tbody>
                        </v-table>
                    </v-sheet>
                </div>

                <div v-if="current == 3">
                    <v-sheet border>
                        <v-table>
                            <thead>
                            <tr>
                                <th>Name</th>
                                <th class="text-end">Avatar</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr v-for="item in employers.data" :key="item.id"
                                :style="`cursor: pointer; ${selectedEmployer.includes(item.id) ? 'background-color: #f2f8ff;' : ''} `"
                                @click="toggleSelectionEmployees(item.id)">
                                <td>{{ item.name }}</td>
                                <td class="text-end">
                                    <v-avatar>
                                        <v-img
                                            :src="item.avatar ?? 'https://i.postimg.cc/yNyvjQPJ/defult-user-img.png'"/>
                                    </v-avatar>
                                </td>
                            </tr>
                            </tbody>
                        </v-table>
                    </v-sheet>
                </div>

                <div v-if="current == 4">
                    <v-card-title>Availability ({{ formatDate(date) }} at {{ selectedTime.toString() }})
                    </v-card-title>
                    <div class="px-4">

                        <v-chip-group v-for="item in [...availableTimesByDay]">
                            <v-chip v-if="item.dayId === getDayNumber(date)" v-for="t in item.times"
                                    :style="`cursor: pointer; ${selectedTime.includes(t) ? 'background-color: #f2f8ff;' : ''} `"
                                    @click="toggleSelectionTime(t)">{{ t }}
                            </v-chip>
                        </v-chip-group>
                    </div>
                </div>
                <div v-if="current == 5">
                    <v-form ref="form" v-model="valid">
                        <v-text-field
                            v-model="name"
                            :rules="nameRules"
                            label="Name"
                            required
                        />
                        <v-text-field
                            v-model="email"
                            :rules="emailRules"
                            type="email"
                            label="E-mail (Optional)"
                        />

                        <v-text-field
                            v-model="phone"
                            :rules="phoneRules"
                            label="Phone"
                            type="number"
                            required
                        />
                    </v-form>
                </div>
                <div v-if="current == 'thx'">
                    <v-sheet style="position: absolute"
                             class="position-relative"
                             min-height="450">
                        <!--        <div class="position-absolute d-flex align-center justify-center w-100 h-100">-->
                        <!--            <v-btn-->
                        <!--                size="x-large"-->
                        <!--                color="deep-purple-darken-2"-->
                        <!--                @click="dialog = !dialog"-->
                        <!--            >-->
                        <!--                Open Dialog-->
                        <!--            </v-btn>-->
                        <!--        </div>-->

                        <v-fade-transition hide-on-leave>
                            <v-card
                                append-icon="$close"
                                class="mx-auto"
                                elevation="16"
                                max-width="500"
                                title="Success"
                            >
                                <template v-slot:append>
                                    <v-btn icon="$close" variant="text" @click="current = 1"></v-btn>
                                </template>

                                <v-divider></v-divider>

                                <div class="py-12 text-center">
                                    <v-icon
                                        class="mb-6"
                                        color="success"
                                        icon="mdi-check-circle-outline"
                                        size="128"
                                    ></v-icon>

                                    <div class="text-h4 font-weight-bold">Thank you</div>
                                    <h4>Thank you the reservation has made place check your email or your phone number for the reservation details</h4>
                                </div>

                                <v-divider></v-divider>
                                <div class="pa-4 text-end">
                                    <v-btn
                                        class="text-none"
                                        color="medium-emphasis"
                                        min-width="92"
                                        rounded
                                        variant="outlined"
                                        @click="current = 1"
                                    >
                                        Back
                                    </v-btn>
                                </div>
                            </v-card>
                        </v-fade-transition>
                    </v-sheet>
                </div>
            </v-card-text>
            <v-divider class="mx-4 mb-1"></v-divider>
            <v-card-actions>
                <v-btn v-if="current >= 2" style="margin: 10px" @click="current --">Previous</v-btn>
                <v-btn v-if="showNextButton()" @click="current ++">Next</v-btn>
                <v-btn v-if="current == 5" @click="submit">Reserve
                    <template v-slot:loader>
                        <v-progress-linear indeterminate></v-progress-linear>
                    </template>
                </v-btn>
            </v-card-actions>
        </v-card>
    </div>
</template>
<script>
import {Link, router, useForm} from "@inertiajs/vue3";
import FlatPickr from 'vue-flatpickr-component';
import 'flatpickr/dist/flatpickr.css';
import moment from 'moment';
import {ref} from "vue";
import ThxDialog from "@/Components/ThxDialog.vue";

export default {
    components: {
        Link,
        FlatPickr
    },
    props: {
        errors: Object,
        employers: Object,
        services: Array,
        schedule: Array,
        availableTimesByDay: Array,
        frameToken: String,
    },
    data: () => ({
        current: 1,
        loading: false,
        config: null,
        date: null,
        headers: [
            {text: 'Name', value: 'name'},
            {text: 'Price', value: 'price', align: 'end'}
        ],
        selected: [],
        selectedIndices: [],
        selectedEmployer: [],
        selectedTime: [],
        valid: true,
        name: '',
        email: '',
        phone: '',
        nameRules: [
            v => !!v || 'Name is required',
            v => (v && v.length >= 3) || 'Name must be at least 3 characters'
        ],
        emailRules: [
            v => (!v || /.+@.+\..+/.test(v)) || 'E-mail must be valid'
        ],
        phoneRules: [
            v => !!v || 'Phone is required',
            v => (v && v.length >= 10) || 'Phone number must be at least 10 digits'
        ]
    }),
    methods: {
        isMobile() {
            if (/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)) {
                return true
            } else {
                return false
            }
        },
        showNextButton() {
            if (this.current == 1 && this.date != null) return true;
            if (this.current == 2 && this.selectedIndices.length > 0) return true;
            if (this.current == 3 && this.selectedEmployer.length > 0) return true;
            if (this.current == 4 && this.selectedTime.length > 0) return true;
            // if (this.current < 5) return true;
            return false;
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
        toggleSelectionTime(itemId) {
            const index = this.selectedTime.indexOf(itemId);
            if (index === -1) {
                this.selectedTime.splice(0, this.selectedTime.length);
                this.selectedTime.push(itemId);
            } else {
                this.selectedTime.splice(index, 1);
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
        },
        submit() {
            // if (this.$refs.form.validate()) {
            this.loading = true
            let data = ref({
                frameToken: this.frameToken,
                name: this.name,
                email: this.email,
                phone: this.phone,
                barber: this.selectedEmployer.toString(),
                service: this.selectedIndices,
                date: this.date,
                time: this.selectedTime.toString()
            });
            console.log(data)
            router.post(route('store.order', this.frameToken), data.value ,{
                preserveScroll:true,
                onSuccess: () =>{
                    this.current = 'thx';
                }
            })
            // }
        }
    },
    watch: {
        loading(val) {
            if (!val) return

            setTimeout(() => (this.loading = false), 2000)
        },
    },
    computed: {
        isMobileC() {
            if (this.isMobile()) {
                return true
            }
            return false
        }
    },
    created() {
        this.updateConfig();
    }
}
</script>
<style lang="css">
.flatpickr-calendar {
    max-width: 740px;
    width: 740px;
//border: 3px solid #0a53be;
}

.flatpickr-rContainer .flatpickr-days {
//width: auto !important;
}

.dayContainer {
    padding: 10px !important;

    min-width: 307.875px;
    max-width: 450.875px;
    text-align: center;
    width: 450px;
    height: 400px !important;
    font-size: 19px !important;
}

.flatpickr-day {
    background: none;
    border: 1px solid transparent;
    border-radius: 150px;
    /* -webkit-box-sizing: border-box; */
    /* box-sizing: border-box; */
    /* color: #393939; */
    /* cursor: pointer; */
    /* font-weight: 400; */
//width: 14.2857143%;
    /* -webkit-flex-basis: 14.2857143%; */
    -ms-flex-preferred-size: 14.2857143%;
    flex-basis: 14.2857143%;
    max-width: 59px;
    height: 39px;
    line-height: 35px;
//margin: 9px; display: inline-block; position: relative;
    -webkit-box-pack: center;
    -webkit-justify-content: center;
    -ms-flex-pack: center;
    justify-content: center;
    text-align: center;
}

.flatpickr-days {
    position: relative;
    overflow: hidden;
    display: -webkit-box;
    display: -webkit-flex;
    display: -ms-flexbox;
    display: flex;
    -webkit-box-align: start;
    -webkit-align-items: flex-start;
    -ms-flex-align: start;
    align-items: flex-start;
    width: 457.875px;
}

.flatpickr-innerContainer {
    display: block;
//margin: 50px !important; //display: -webkit-box;
    /* display: -webkit-flex; */
    display: -ms-flexbox;
    /* display: flex; */
    /* -webkit-box-sizing: border-box; */
    /* box-sizing: border-box; */
    overflow: hidden;
}

@media only screen and (max-width: 470px) {
    .flatpickr-calendar,
    .flatpickr-rContainer .flatpickr-days,
    .flatpickr-days,
    .flatpickr-innerContainer {
        all: unset;
    }

    .dayContainer {
        padding: 0 !important;

    //min-width: 107.875px; max-width: 150.875px; text-align: center;
        width: 450px;
        height: 300px !important;
        font-size: 19px !important;
    }

    .flatpickr-day {

        max-width: 39px;
        height: 45px;
        line-height: 49px;
        margin: 0px;

    }
}

</style>
