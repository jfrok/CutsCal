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

                        <div class="text-subtitle-2 mb-2 w-100" v-if="roles.data.length > 0">
                            <div v-for="uniqueUserName in uniqueUserNames" :key="uniqueUserName">
                               <h4 class="p-10 mt-5"> {{ uniqueUserName }} </h4>
                                <hr>
                            <v-expansion-panels>
                                    <v-expansion-panel v-for="role in roles.data"
                                                       :key="role.id">
                                        <v-expansion-panel-title>{{ role.name }}</v-expansion-panel-title>
                                    <v-expansion-panel-text v-if="role.user_name === uniqueUserName">
                                        <v-row class="mt-5 mb-7" >
                                            <v-col cols="12">
                                            <div v-for="(roleHolders,index) in rolesUsers" :key="index" >
                                                <template v-if="roleHolders.role == role.name">
                                              <v-chip-group v-if="roleHolders.users.length > 0">
                                                  <v-chip v-for="(user,index) in roleHolders.users" :key="index">
                                                      {{user.name}}
                                                  </v-chip>
                                              </v-chip-group>
                                                <div class="text-center h-1" v-if="roleHolders.users.length < 1">
                                                    No users
                                                </div>
                                                </template>

                                            </div>
                                            </v-col>
                                            <v-col cols="12">
                                                <div class="align-center d-flex">
                                                <div class="d-flex align-center justify-start w-100">
                                                    <Link :href="route('roles.show', role.id)">View</Link>
                                                </div> <div class="d-flex align-center justify-end w-100">
                                                    <v-btn class=" hover-effect" rounded elevation="0" v-if="usePage().props.auth.userRole.includes('role-delete')" methods="delete" @click="roleDelete(role.id)">
                                                        <i class="fas fa-minus-circle"></i>
                                                    </v-btn>
                                                </div>
                                                </div>
                                            </v-col>
                                        </v-row>

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
        rolesUsers: Object,
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
        rolesValidation(roleName) {
            for (let role in this.rolesUsers) {
                if (this.rolesUsers[role][roleName].users.length > 0) {
                    return true;
                }
            }
            return false;
        }
    }

}
</script>
