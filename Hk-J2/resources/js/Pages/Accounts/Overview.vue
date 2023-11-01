<template>
    <AuthenticatedLayout>
        <div class="row">
            <div class="col-sm-12">
                <div class="card card-table">
                    <div class="card-body">

                        <div class="page-header">
                            <div class="row align-items-center">
                                <div class="col">
                                    <h3 class="page-title">{{$page.props.auth.user.lang == 'arabic'? 'إدارة الحسابات' : 'Accounts Management'}}</h3>
                                </div>
                                <div class="col-auto text-end float-end ms-auto download-grp">
                                    <Link :href="route('account.create')" class="btn btn-primary"><i
                                        class="fas fa-plus"></i></Link>
                                </div>
                            </div>
                        </div>

                        <div class="table-responsive">
                            <form @submit.prevent="groupDelete">

                                <table
                                    class="table border-0 star-student table-hover table-center mb-0 datatable table-striped">
                                    <thead class="student-thread">
                                    <tr>
                                        <th v-if="$page.props.auth.userRole.includes('user-delete')">
                                            <div class="form-check check-tables">
                                                <input class="form-check-input" @change="selectAll" id="checkAll"
                                                       v-model="groupDeleteForm.checkIfAllSelected" type="checkbox">
                                            </div>
                                        </th>
                                        <th>ID</th>
                                        <th>Name</th>
                                        <th>Email</th>
                                        <th>Lang</th>
                                        <th>Created At</th>
                                        <th>Action</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr v-for="user in users" :key="user.id">
                                        <td v-if="$page.props.auth.userRole.includes('user-delete')">
                                            <div class="form-check check-tables">
                                                <input class="form-check-input" id="allIds" name="uIds[]"
                                                       v-model="groupDeleteForm.uIds" type="checkbox" :value="user.id">
                                                <input class="form-check-input" name="allIds[]"
                                                       v-model="groupDeleteForm.uIds" type="hidden">
                                            </div>
                                        </td>
                                        <td>{{ user.id }}</td>
                                        <td>
                                            <small><strong>{{ Object.values(employers).includes(user.id) ? 'employer' : 'mainUser'}}</strong></small>
                                            <br>
                                            <Link :href="route('account.edit',user.id)">
                                                <h2 class="table-avatar">
                                                    <a class="avatar avatar-sm me-2">

                                                        <img class="avatar-img rounded-circle"
                                                             v-if="user.avatar"
                                                             :src="user.avatar" alt="User Image">
                                                        <img v-else src="https://i.postimg.cc/yNyvjQPJ/defult-user-img.png"
                                                             alt="">
                                                    </a>
                                                    <a>{{ user.name }}</a>
                                                </h2>
                                            </Link>
                                        </td>
                                        <td>{{ user.email }}</td>
                                        <td>{{ user.lang }}</td>
                                        <!--                                <td>$120</td>-->
                                        <td>{{ moment(user.created_at).format('DD/MM/YYYY') }}</td>
                                        <td v-if="$page.props.auth.userRole.includes('trash-force-delete')">
                                            <div class="up-come-headerS">
                                                <a type="button" @click="destroy(user.id)"><span><i
                                                    class="feather-trash"></i></span></a>
                                            </div>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </form>
                            <div v-if="$page.props.auth.userRole.includes('user-delete')">
                                <button class="btn btn-danger mt-5" @click="groupDelete" type="submit"
                                        v-if="users.length > 1"><span><i
                                    class="feather-trash-2"></i></span>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </AuthenticatedLayout>
</template>
<script setup>
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import moment from "moment";
import {Link, router, useForm} from "@inertiajs/vue3";
import {ref, watch} from "vue";
import {allUids} from "@/Pages/Ref/allUids";

let props = defineProps({
    users: Array,
    employers: Array,
})

const showSpinner = ref(false);

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
            router.post(route('account.destroy', uId), {
                preserveScroll: true,
                preserveState: true,
            })
            Swal.fire(
                'Deleted!',
                'Your file has been deleted.',
                'success'
            )
        }
    })
}

function selectAll() {
    if ($('#checkAll').is(':checked')) {

        $('.form-check-input').prop('checked', true)

    } else {
        $('.form-check-input').prop('checked', false)
    }
}

let groupDeleteForm = useForm({
    uIds: [],
    alluIds: usersList(),
    checkIfAllSelected: '',

})
watch(() => allUids, ($allUids) => {
    groupDeleteForm.alluIds = $allUids.value
})
function usersList() {
    // Check if employers is an array, if not, return an empty array
    if (Array.isArray(props.users)) {
        // Use map to extract IDs if employers is an array
        return props.users.map(user => ({ id: user.id }));
    } else {
        return [];
    }
}
const groupDelete = () => {
    if (groupDeleteForm.uIds) {
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
                groupDeleteForm.post(route('account.groupDelete'), {
                    preserveScroll: true,
                    preserveState: true,
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
