<template>
    <AuthenticatedLayout>
        <Head title="Employers"/>

        <div class="row">
            <div class="col-sm-12">
                <div class="card card-table border-r-20 border-secondary-color-2 bg-official-secondary">
                    <div class="card-body">
<!--                        <div v-if="$page.props.ziggy.flash.message">-->
<!--                            {{ showToastSuccess('Successfully') }}-->
<!--                        </div>-->
                        <div class="page-header">
                            <div class="row align-items-center">
                                <div class="col">
                                    <h3 class="page-title">
                                        {{ $page.props.auth.user.lang == 'arabic' ? 'إدارة الموظفون' : 'Employers Management' }}</h3>
                                </div>
                                <div v-if="$page.props.auth.userRole.includes('employer-create')" class="col-auto text-end float-end ms-auto download-grp">
                                    <Link :href="route('employer.create')" class="btn btn-primary"><i
                                        class="fas fa-plus"></i></Link>
                                </div>
                            </div>
                        </div>
                        <div class="table-responsive" v-if="employers.data.length > 0">
                            <v-table v-if="employers.data.length > 0" fixed-header>
                                <thead>
                                <tr>
                                    <th class="text-center">
                                        <v-checkbox
                                            v-model="getIds.checkIfAllSelected"
                                            @change="selectEmployers"
                                        ></v-checkbox>
                                    </th>
                                    <th class="text-left">
                                        Name
                                    </th>
                                    <th class="text-left">
                                        Email
                                    </th>
                                    <th class="text-left">
                                        Created at
                                    </th>
                                    <th v-if="$page.props.auth.userRole.includes('employer-delete')" class="text-left">
                                        Action
                                    </th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr
                                    v-for="item in employers.data"
                                    :key="item.id"
                                >
                                    <td>
                                        <v-checkbox
                                            v-model="getIds.id"
                                            :value="item.id"
                                        ></v-checkbox>
                                    </td>
                                    <td><Link :href="route('employer.edit',item.id)">{{ item.name }}</Link></td>
                                    <td>{{ item.email }}</td>
                                    <td>{{ item.created_at }}</td>
                                    <td v-if="$page.props.auth.userRole.includes('employer-delete')"><a href="javascript:void(0)" @click="destroy(item.id)">
                                        <i class="fas fa-trash"></i>
                                    </a>
                                    </td>
                                </tr>
                                </tbody>
                                <div v-if="$page.props.auth.userRole.includes('employer-delete')" class="p-20">
                                    <v-btn color="red-darken-1" rounded size="small" @click="groupDelete(0)"
                                           v-if="employers.data.length > 1"><span><i
                                        class="feather-trash-2"></i></span>
                                    </v-btn>
                                </div>
                            </v-table>
                            <v-alert v-else style="margin-top: 70px"
                                     type="info"
                                     variant="tonal"
                            >
                                <v-alert-title style="justify-content: center;display: flex">There is no clients
                                </v-alert-title>
                            </v-alert>

                        </div>
                        <v-alert v-else style="margin-top: 70px"
                                 type="info"
                                 variant="tonal"
                        >
                            <v-alert-title style="justify-content: center;display: flex">There is no employers
                            </v-alert-title>
                        </v-alert>
                    </div>
                </div>
            </div>
        </div>
    </AuthenticatedLayout>
</template>
<script setup>
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import {Link, router, useForm} from "@inertiajs/vue3";
import {ref, watch} from "vue";
import {Head} from "@inertiajs/vue3";
import {useToast} from "vue-toastification";

const toast = useToast();

function showToastSuccess(message) {
    toast.success(message);
}

let props = defineProps({
    employers: Object
})
const showSpinner = ref(false);

function selectEmployers() {
    if (getIds.checkIfAllSelected) {
        const ids = props.employers.data.map((employersIds) => employersIds.id)
        getIds.id = ids;
    } else {
        getIds.id = []
    }
}

let getIds = useForm({
    checkIfAllSelected: false,
    id: [],
})

const destroy = (uId) => {
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
            getIds.post(route('account.destroy', uId), {
                preserveScroll: true,
                preserveState: true,
                onSuccess: () => {
                    showToastSuccess('Successfully deleted')
                }
            })
            Swal.fire(
                'Deleted!',
                'Your file has been deleted.',
                'success'
            )
        }
    })
}
const groupDelete = () => {
    if (getIds.id) {
        showSpinner.value = true;
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
                getIds.post(route('account.groupDelete', 0), {
                    preserveScroll: true,
                    preserveState: true,
                    onSuccess: () => {
                        showToastSuccess('Successfully deleted')
                    },
                    onStart: () => {
                        showSpinner.value = true;
                    },
                    onFinish: () => {
                        showSpinner.value = false;
                    },
                });
                Swal.fire(
                    'Deleted!',
                    'Your file has been deleted.',
                    'success'
                )
            }
        })
    }
};
</script>
