<template>
    <v-stepper
        v-model="step"
        :items="items"
        show-actions
        alt-labels
        editable
    >
        <template v-slot:item.1>
            <h3 class="text-h6">Calendar settings</h3>
            <br>
            <ShopSchedule v-if="!isMobile" :include-btn="false"/>
            <div class="text-center p-20" v-else>
                <v-btn color="#3d5ee1" @click="openScheduleDialog">Edit</v-btn>
            </div>
        </template>
        <template v-slot:item.2>
            <h3 class="text-h6">Services</h3>
            <div class="d-flex justify-end">
                <a href="javascript:void(0)" @click="createServices" class="btn btn-primary"><i
                    class="fas fa-plus"></i></a>
            </div>
            <br>

            <v-dialog v-model="servicesDialog" persistent width="524">
                <AddServices @update="addService" @close-dialog="(val)=>{servicesDialog = false}"/>
            </v-dialog>

                <v-table>
                    <thead class="bg-official-secondary">
                    <tr>
                        <th>Name</th>
                        <th class="text-end">Price</th>
                        <th class="text-end">Action</th>

                    </tr>
                    </thead>
                    <tbody>
                    <tr v-for="item in services" :key="item.id">
                        <td v-text="item.name"></td>
                        <td class="text-end" v-text="item.price"></td>
                        <td class="text-end"><a href="javascript:void(0)" class="cursor-pointer f-color-red" @click="deleteService(item.id)"><i class="feather-x-circle"></i></a></td>
                    </tr>

                    </tbody>
                </v-table>

        </template>
        <template v-slot:item.3>
<!--            <div class="d-flex">-->
            <h3 class="text-h6">Barbers</h3>
            <div class="d-flex justify-end b-ps">
                <Link :href="route('employer.create')" class="btn btn-primary"><i
                    class="fas fa-plus"></i></Link>
            </div>
<!--            </div>-->
            <br>
            <v-autocomplete
                class="mb-7"
                v-model="selectedEmployee"
                :items="employers"
                chips
                closable-chips
                color="blue-grey-lighten-2"
                item-text="name"
                :item-value="itemValue"
                label="Select a barber"
                multiple
            >
                <template v-slot:chip="{ props, item }">
                    <v-chip
                        v-bind="props"
                        :prepend-avatar="item.raw.avatar"
                        :text="item.raw.name"
                    ></v-chip>
                </template>

                <template v-slot:item="{ props, item }">
                    <v-list-item
                        v-bind="props"
                        :prepend-avatar="item?.raw?.avatar"
                        :title="item?.raw?.name"
                        :subtitle="item?.raw?.group"
                    ></v-list-item>
                </template>
            </v-autocomplete>
            <v-sheet border>
                <v-table>
                    <thead class="bg-official-secondary">
                    <tr>
                        <th>Name</th>
                        <th class="text-end">Avatar</th>
                        <!--                        <th class="text-end">Price</th>-->
                    </tr>
                    </thead>

                    <tbody>
                    <tr v-for="item in markedEmployees" :key="item.id">
                        <td>{{ item.name }}</td>
                        <td class="text-end">
                            <v-avatar>
                                <v-img :src="item.avatar ?? 'https://i.postimg.cc/yNyvjQPJ/defult-user-img.png'"/>
                            </v-avatar>
                        </td>
                    </tr>

                    </tbody>
                </v-table>
            </v-sheet>
        </template>
        <template v-slot:item.4>
            <h3 class="text-h6">Preview</h3>
            <br>
            <div class="col-auto text-center ms-auto download-grp">
                <v-btn v-if="$page.props.auth.schedule != null" @click="openNewWindow">
                    <div class="pa-20">
                        <i class="fas fa-eye"></i>
                    </div>
                </v-btn>
            </div>
            <hr>
            <h3>Embed Code</h3>
            <v-slider
                label="height"
                v-model="height.slider"
                class="align-center"
                :max="height.max"
                :min="height.min"
                hide-details
            >
                <template v-slot:append>
                    <v-text-field
                        v-model="height.slider"
                        hide-details
                        single-line
                        density="compact"
                        type="number"
                        class="w-30"
                    ></v-text-field>
                </template>
            </v-slider>
            <v-slider
                label="width"
                v-model="width.slider"
                class="align-center"
                :max="width.max"
                :min="width.min"
                hide-details
            >
                <template v-slot:append>
                    <v-text-field
                        v-model="width.slider"
                        hide-details
                        single-line
                        density="compact"
                        type="number"
                        class="w-30"
                    ></v-text-field>
                </template>
            </v-slider>
            <div class="p-20">
            <v-btn  color="blue-darken-4"
                    rounded="0"
                    variant="outlined"
                     @click="copy();"><i class="fa fa-clipboard"></i></v-btn>
            <!--            <span><pre>`<iframe :src=this.url :width="this.width.slider.toFixed()" :height="this.height.slider.toFixed()" frameborder="0"></iframe>`</pre> </span>-->
            <span><pre ref="embed">{{ embedFrameC }}</pre> </span>
            </div>
        </template>
    </v-stepper>
</template>
<script>
import ShopSchedule from "@/Components/ShopSchedule.vue";
import {router} from "@inertiajs/vue3";
import AddServices from "@/Components/AddServices.vue";
import {Link} from "@inertiajs/vue3";
import {isMobile} from "@/Pages/Ref/isMobile";
import {scheduleDialog} from "@/Pages/Ref/scheduleDialog";
import {useToast} from "vue-toastification";
import config from "@/config";

export default {
    name: 'Steppers',
    components: {AddServices, ShopSchedule, Link},
    props: {
        employers: Object,
        markedEmployees: Object,
        services: Array,
        frameToken: String,
    },
    data: (props) => ({
        width: {
            min: 300,
            max: 1000,
            slider: 500,
        },
        height: {
            min: 300,
            max: 1000,
            slider: 500,
        },
        url: config.frame.urls.live+props.frameToken,//route('frame.view', props.frameToken),
        frameUI: [],
        selectedEmployee: props.markedEmployees ?? null,
        servicesDialog: false,
        shipping: 0,
        step: 1,
        items: [
            'Calendar',
            'Services',
            'Barbers',
            'Preview',
        ],
        products: [
            {
                name: 'Product 1',
                price: 10,
                quantity: 2,
            },
            {
                name: 'Product 2',
                price: 15,
                quantity: 10,
            },
        ],
    }),

    watch: {
        // validatedSelectedEmployee(newVal) {
        //     this.selectedEmployee = newVal;
        // },
        selectedEmployee(newVal, oldVal) {
            const ids = this.selectedEmployee.map(itemId => itemId.id);
            const markedIds = this.markedEmployees.map(itemId => itemId.id);
            if (!markedIds.includes(ids) && ids !== null) {
                this.markedEmployers();
                // console.log(newVal)
                // this.selectedEmployee = newVal;
            }
        }
    },

    methods: {
        showToastSuccess(message) {
            const toast = useToast();
            toast.success(message);
        },
        addService(data) {
            console.log(data)
            data.post(route('services.create'),data, {
                preserveScroll: true,
                preserveState: true,
                onSuccess: () => {
                    // this.showToastSuccess('Successfully added')
                    // data.name = '';
                    // data.price = '';
                    // data.duration = '';
                    this.servicesDialog = false
                    // form.editMode ? form.editMode = false : form.editMode = true;
                    // form.editMode ? showToastSuccess('Successfully updated') : showToastSuccess('Successfully added')
                    data.reset()
                    // form.dialog = false;
                },

            });
            this.servicesDialog = false
        },
        copy() {
            const textToCopy = this.$refs.embed.textContent;
            navigator.clipboard.writeText(textToCopy)
                .then(() => {
                    let toast = useToast();
                    toast.success('Text copied to clipboard')
                    console.log('Text copied to clipboard');
                })
                .catch(err => {
                    console.error('Error in copying text: ', err);
                });
        },
        itemValue(item) {
            return item;
        },
        openScheduleDialog() {
            scheduleDialog.value = true
        },
        createServices() {
            this.servicesDialog = true
            // form.reset()
            // form.editMode = false;
            // routeName.route = 'client.store';
            // routeName.route = '';
        },
        embedFrame() {
            let frame = `<iframe src=${this.url} width="${this.width.slider.toFixed()}" height="${this.height.slider.toFixed()}" frameborder="0"></iframe>`
            return this.frameUI = frame;
        },
        selectEmployee(employeeId) {
            this.selectedEmployee = employeeId;
        },
        markedEmployers() {
            router.post(route('employer.setMark'), {user_ids: this.selectedEmployee.map(ids => ids.id)});
        },
        deleteService(sId) {
            router.post(route('services.delete',sId),{
                preserveScroll: true, preserveState: true,

            });
        },
        openNewWindow() {

            const windowFeatures = 'width=800,height=600,menubar=yes,toolbar=yes';
            window.open(this.url, '_blank', windowFeatures);
        }
    },

    computed: {
        scheduleDialog() {
            return scheduleDialog
        },
        isMobile() {
            return isMobile
        },
        validatedSelectedEmployee() {
            return this.selectedEmployee.filter(id =>
                this.markedEmployees.some(markedEmployee => markedEmployee.id === id)
            );
        },
        embedFrameC() {
            return this.frameUI = this.embedFrame();
        },
        subtotal() {
            return this.products.reduce((acc, product) => acc + product.quantity * product.price, 0);
        },
        total() {
            return this.subtotal + Number(this.shipping ?? 0);
        },
    },
}
</script>
