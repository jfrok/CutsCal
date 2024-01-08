<template>
    <AuthenticatedLayout>
        <Head title="Clients"/>

        <div class="row">
            <div class="col-sm-12" >
                <div class="card card-table" style="background-color: rgba(0,119,246,0.05)">
                    <div class="card-body">
                        <div class="page-header">
                            <div class="row align-items-center">
                                <div class="col">
                                    <h3 class="page-title">
                                        {{ $page.props.auth.user.lang == 'arabic' ? 'إدارة الزبائن' : 'Clients Management' }}</h3>
                                </div>
                                <div class="col-auto text-end float-end ms-auto download-grp">
                                    <a @click="createClient()" class="btn btn-primary"><i
                                        class="fas fa-plus"></i></a>
                                </div>
                            </div>
                        </div>

                        <v-table v-if="clients.data.length > 0" fixed-header>
                            <thead>
                            <tr>
                                <th class="text-center">
                                    <v-checkbox
                                        v-model="getIds.selectAllIdsChecker"
                                        @change="selectClients"
                                    ></v-checkbox>
                                </th>
                                <th class="text-left">
                                    Name
                                </th>
                                <th class="text-left">
                                    Email
                                </th>
                                <th class="text-left">
                                    Phone
                                </th>
                                <th class="text-left">
                                    Action
                                </th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr
                                v-for="item in clients.data"
                                :key="item.client_id"
                            >
                                <td>
                                    <v-checkbox
                                        v-model="getIds.id"
                                        :value="item.client_id"
                                    ></v-checkbox>
                                </td>
                                <td><a href="javascript:void(0)" @click="getEditData(item)">{{ item.client_name }}</a>
                                </td>
                                <td>{{ item.client_email }}</td>
                                <td>{{ item.client_phone }}</td>
                                <td><a href="javascript:void(0)" @click="destroy(item.client_id)">
                                    <i class="fas fa-trash"></i>
                                </a>
                                </td>
                            </tr>
                            </tbody>
                            <div v-if="$page.props.auth.userRole.includes('client-delete')" class="p-20">
                                <v-btn color="red-darken-1" @click="deleteClient(0)"
                                        v-if="clients.length > 1"><span><i
                                    class="feather-trash-2"></i></span>
                                </v-btn>
                            </div>
                            <Pagination :links="clients.links"/>

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
        </div>
        <!--        // Dialog-->
        <v-dialog v-model="form.dialog" persistent width="1024">
            <v-card>
                <v-card-title>
                    <span class="text-h5">{{ form.editMode ? 'Edit Client' : 'Create a Client' }}</span>
                </v-card-title>
                <v-card-text>
                    <v-container>
                        <v-row>
                            <v-col cols="12">
                                <v-text-field label="Full name" v-model="form.name" required></v-text-field>
                                <InputError :message="errors.name"/>
                            </v-col>
                            <v-col md="6">
                                <v-text-field label="Email (optional)" v-model="form.email"></v-text-field>
                                <InputError :message="errors.email"/>
                            </v-col>
                            <v-col md="6">
                                <v-text-field label="Phone*" type="number" v-model="form.phone" required></v-text-field>
                                <InputError :message="errors.phone"/>
                            </v-col>
                            <v-container fluid>
                                <v-textarea
                                    counter
                                    label="Text"
                                    v-model="form.notes"></v-textarea>
                            </v-container>
                        </v-row>
                    </v-container>
                    <!--                    <small>*indicates required field</small>-->
                </v-card-text>
                <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn color="blue-darken-1" variant="text" @click="form.dialog = false">
                        Close
                    </v-btn>
                    <v-btn color="blue-darken-1" variant="text" @click="saveUser">
                        {{ form.editMode ? 'Update' : 'Save' }}
                    </v-btn>
                </v-card-actions>
            </v-card>
        </v-dialog>
    </AuthenticatedLayout>
</template>

<script>
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import {router, useForm} from "@inertiajs/vue3";
import InputError from "@/Components/InputError.vue";
import {reactive, ref} from "vue";
import {useToast} from "vue-toastification";
import {Head} from "@inertiajs/vue3";
export default {
    components: {
        Head,
        InputError,
        AuthenticatedLayout,
    },
    props: {
        errors: Object,
        clients: Object,
    },
    setup(props) {
        const toast = useToast();
        let routeName = {
            route: null,
            params: null
        };
        let form = useForm({
            dialog: false,
            editMode: false,
            name: '',
            email: '',
            phone: '',
            notes: '',
        });
        let getIds = useForm({
            selectAllIdsChecker: false,
            id: [],
        })

        function destroy(cId) {
            Swal.fire({
                title: 'Are you sure?',
                // text: "You won't be able to revert this!",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes, delete it!'
            }).then((result) => {
                if (result.isConfirmed) {
                    // if (!getIds.selectAllIdsChecker){
                    //
                    //     getIds.id = cId;
                    // }
                    getIds.post(route('client.destroy', cId), {
                        preserveScroll: true,
                        preserveState: true,
                        onSuccess: () => {
                            showToastSuccess('Successfully deleted')
                        }
                    })
                    Swal.fire(
                        'Deleted!',
                        'The client has been deleted.',
                        'success'
                    )
                }
            })
        }

        function deleteClient() {
            console.log(getIds.id)
            Swal.fire({
                title: 'Are you sure?',
                // text: "You won't be able to revert this!",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes, delete it!'
            }).then((result) => {
                if (result.isConfirmed) {
                    getIds.post(route('client.destroy', 0), {
                        preserveScroll: true,
                        preserveState: true,
                        onSuccess: () => {
                            showToastSuccess('Successfully deleted')
                        }
                    })
                    //  console.log(cId)
                    Swal.fire(
                        'Deleted!',
                        'The client has been deleted.',
                        'success'
                    )
                }
            })
        }

        function selectClients() {
            if (getIds.selectAllIdsChecker) {
                const ids = props.clients.data.map((clientsIds) => clientsIds.client_id)
                getIds.id = ids;
            } else {
                getIds.id = []
            }
        }

        function createClient() {
            form.reset()
            form.editMode = false;
            form.dialog = true;
            routeName.route = 'client.store';
            // routeName.route = '';
        }

        function getEditData(data) {
            console.log(getIds)
            form.reset()
            form.editMode = true;
            // if (form.editMode) {
            form.dialog = true;

            const user = data;
            routeName.route = 'client.update'
            routeName.params = user.client_id
            form.name = user.client_name;
            form.email = user.client_email;
            form.phone = user.client_phone;
            form.notes = user.client_notes;
            // }
        }

        function saveUser() {
            const routeToSave = form.editMode ? route(routeName.route, routeName.params) : route('client.store');

            form.post(routeToSave, {
                preserveScroll: true,
                preserveState: true,
                onSuccess: () => {
                    // form.editMode ? form.editMode = false : form.editMode = true;
                    form.editMode ? showToastSuccess('Successfully updated') : showToastSuccess('Successfully added')
                    form.reset()
                    form.dialog = false;
                },
            });
        }

        function showToastSuccess(message) {
            toast.success(message);
        }

        return {form, saveUser, createClient, getEditData, deleteClient, selectClients, destroy, getIds};
    },
};
</script>
