<template>
    <AuthenticatedLayout>
    <Head title="Trash"/>
    <div class="row" >
        <div class="col-sm-12 border-r-20 border-secondary-color-2 bg-official-secondary">
            <Loader :show="showSpinner" color="blue"  />


            <div class="card bg-official-secondary">
                <div class="card-header bg-official-secondary">
                    <h3 class="page-title">{{$page.props.auth.user.lang == 'arabic'? 'إدارة المهملات' : 'Trash Management'}}</h3>
                </div>

                <div class="card-body">
                    <div class="table-responsive">
                        <v-table v-if="trashed.length > 0">
                            <thead>
                            <tr>
                                <th class="text-center">
                                    <v-checkbox
                                        v-model="getIds.selectAllIdsChecker"
                                        @change="selectClients"
                                    ></v-checkbox>
                                </th>
                                <th class="text-left">Title</th>
                                <th class="text-left">View</th>
                                <th v-if="$page.props.auth.userRole.includes('trash-restore')" class="text-left">Restore</th>
                                <th class="text-left">Delete</th>
                                <th class="text-left">Delete at</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr
                                v-for="item in trashed"
                                :key="item.id"
                            >
                                <td>
                                    <v-checkbox
                                        v-model="getIds.id"
                                        :value="item.id"
                                    ></v-checkbox>
                                </td>
                                <td>{{ item.title }}</td>

                                <td>
                                    <div class="up-come-headerS">   <Link :href="route('content.index',item.id)"><span><i class="feather-eye"></i></span></Link></div></td>
                                <td v-if="$page.props.auth.userRole.includes('trash-restore')">  <div class="up-come-headerS">   <Link  @click="restore(item.id)"><span><i class="feather-refresh-ccw"></i></span></Link></div></td>
                                <td v-if="$page.props.auth.userRole.includes('trash-force-delete')"><div class="up-come-headerS"><a type="button" @click="destroy(item.id)"><span><i class="feather-trash"></i></span></a></div></td>
                                <td>{{moment(item.deleted_at).format('DD/MM/YYYY')}}</td>
                            </tr>
                            </tbody>
                            <div v-if="$page.props.auth.userRole.includes('trash-delete')" class="p-20">
                                <v-btn color="red-darken-1" @click="groupDelete(0)"
                                       v-if="trashed.length > 1"><span><i
                                    class="feather-trash-2"></i></span>
                                </v-btn>
                            </div>
                        </v-table>
                        <v-alert v-else
                            type="info"
                            title="No data founded"
                            text="There are is no data"
                            variant="tonal"
                        ></v-alert>
                    </div>
                </div>

            </div>

        </div>
    </div>
    </AuthenticatedLayout>
</template>
<script setup>
import {Head, router, useForm} from '@inertiajs/vue3';
import {Link} from "@inertiajs/vue3";
import moment from 'moment';
import {allPids} from "@/Pages/Ref/allPids";
import {watch} from "vue";
import Loader from "@/Components/Loader.vue";
import { ref } from 'vue';
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";

let props = defineProps({
    trashed: Array,

})

const showSpinner = ref(false);

const destroy = (pId) => {
    Swal.fire({
        title: 'Are you sure?',
        text: "You won't be able to revert this!",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Yes, delete it!'
    }).then((result) => {
        if (result.isConfirmed) {
            router.post(route('forceDelete',pId))
            Swal.fire(
                'Deleted!',
                'Your file has been deleted.',
                'success'
            )
        }
    })
}
const restore = (pId) => {
    Swal.fire({
        title: 'Are you sure?',
        text: "You want to restore this project!",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Yes, restore it!'
    }).then((result) => {
        if (result.isConfirmed) {
            router.post(route('restore',pId))
            Swal.fire(
                'Restore!',
                'Your file has been restored.',
                'success'
            )
        }
    })
}
let getIds = useForm({
    selectAllIdsChecker: false,
    id: [],
})
function selectClients() {
    if (getIds.selectAllIdsChecker) {
        const ids = props.trashed.map((trashedIds) => trashedIds.id)
        getIds.id = ids;
    } else {
        getIds.id = []
    }
}

let groupDeleteForm = useForm({
    pIds:[],
    checkIfAllSelected:'',

})
watch( () => allPids,($allPids) =>{
    groupDeleteForm.allpIds = $allPids.value
})
const groupDelete = () => {
    showSpinner.value = true;
    getIds.post(route('trash.groupDelete'), {
        onStart: () => {
            showSpinner.value = true;
        },
        onFinish: () => {
            showSpinner.value = false;
        },
    });
};

</script>
