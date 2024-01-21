<template>
    <AuthenticatedLayout>
        <Head title="Roles"/>

        <div class="row">
        <div class="col-sm-12" >
            <div class="card card-table border-r-20 border-secondary-color-2 bg-official-secondary">
                <div class="card-body">

                    <div class="page-header">
                        <div class="row align-items-center">
                            <div class="col">
                                <h3 class="page-title">{{$page.props.auth.user.lang == 'arabic'? 'إدارة الرتب' : 'Roles Management'}}</h3>
                            </div>
                            <div class="col-auto text-end float-end ms-auto download-grp">
                                <Link :href="route('roles.create')" class="btn btn-primary"><i class="fas fa-plus"></i>
                                </Link>
                            </div>
                        </div>
                    </div>

<!--                    <div class="table-responsive">-->
<!--                        <table-->
<!--                            class="table border-0 star-student table-hover table-center mb-0 datatable table-striped">-->
<!--                            <thead class="student-thread">-->
<!--                            <tr>-->
<!--                                <th>Name</th>-->
<!--                                <th>Belong</th>-->
<!--                            </tr>-->
<!--                            </thead>-->
<!--                            <tbody>-->
<!--                            <tr v-for="role in roles.data" :key="role.id">-->
<!--                                <td>-->
<!--                                    &lt;!&ndash;<div style="padding: 20px 30px">&ndash;&gt;-->
<!--                                    <Link :href="route('roles.show',role.id)">{{ role.name }}</Link>-->
<!--                                    <a style="padding: 20px 60px"-->
<!--                                       v-if="usePage().props.auth.userRole.includes('role-delete')" methods="delete"-->
<!--                                       @click="roleDelete(role.id)"><i class="fas fa-minus-circle hover-effect"></i></a>-->
<!--                                    &lt;!&ndash;</div>&ndash;&gt;-->
<!--                                    &lt;!&ndash;                                    </h2>&ndash;&gt;-->
<!--                                </td>-->
<!--                                <td>-->
<!--                                    <h2>{{role.user_name}}</h2>-->

<!--                                </td>-->
<!--                            </tr>-->
<!--                            </tbody>-->
<!--                        </table>-->

<!--                        <h2>Tree View</h2>-->
<!--                        <p>A tree view represents a hierarchical view of information, where each item can have a number of subitems.</p>-->
<!--                        <p>Click on the arrow(s) to open or close the tree branches.</p>-->

<!--                       <TreeView />-->

                        <div class="text-subtitle-2 mb-2" v-if="roles.data.length > 0">
                            <div v-for="uniqueUserName in uniqueUserNames" :key="uniqueUserName">
                               <h4 class="p-10 mt-5"> {{ uniqueUserName }} </h4>

                                <hr>
                            <v-expansion-panels v-for="role in roles.data"
                                                :key="role.id">
                                    <v-expansion-panel  v-if="role.user_name === uniqueUserName"
                                        :title="role.name"
                                    >
                                    <v-expansion-panel-text>
                                        <v-row class="mt-5 mb-7" >
                                            <v-btn block  variant="tonal" @click="fetchUsers(role.name)">Fetch Users</v-btn>

                                            <!--                                            <v-chip>-->
<!--                                                user-->
<!--                                            </v-chip>-->
                                        <br>
                                        </v-row>
                                        <Link :href="route('roles.show', role.id)">View</Link>
                                        <a
                                            style="padding: 20px 60px; float: right"
                                            v-if="usePage().props.auth.userRole.includes('role-delete')"
                                            methods="delete"
                                            @click="roleDelete(role.id)"
                                        >
                                            <i class="fas fa-minus-circle hover-effect"></i>
                                        </a>
                                    </v-expansion-panel-text>
                                </v-expansion-panel>
                            </v-expansion-panels>

                            </div>

                        </div>
                    <v-alert v-else style="margin-top: 70px"
                             type="info"
                             variant="tonal"
                    >
                        <v-alert-title style="justify-content: center;display: flex">There is no roles
                        </v-alert-title>
                    </v-alert>
                    </div>
                </div>
            </div>
        </div>
<!--    </div>-->
    </AuthenticatedLayout>
</template>
<script>
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import {Link, router, usePage} from "@inertiajs/vue3";
import {Head} from "@inertiajs/vue3";
import {useToast} from "vue-toastification";
export default {
    // layout: AuthenticatedLayout,
    components: {
        Head,
        Link,
        router,
        // TreeView,
        AuthenticatedLayout
    },
    props: {
        roles: Object
    },
    methods: {
        router() {
            return router
        },
        roleDelete(id) {
            const toast = useToast();

            function showToastSuccess(message){
                toast.success(message);
            }

            router.delete(route('roles.destroy', id),{
                onSuccess: () =>{
                    showToastSuccess('Successfully deleted')
                },
            })
        },
        fetchUsers(roleName) {
            router.post(route('getRoleUsers', roleName))
        },
        usePage
    },
    computed: {
        uniqueUserNames(userName) {
            const usernames = this.roles.data.map((role) => role.user_name);
            return [...new Set(usernames)];
        },
    }

}
</script>
