<template>
    <AuthenticatedLayout>
    <div class="row">
        <div class="col-sm-12">
            <div class="card card-table border-r-20 border-secondary-color-2 bg-official-secondary">
                <div class="card-body">
                    <h2>{{ form.name }}</h2>
                    <form @submit.prevent="submitForm">
                        <v-text-field label="Role Name" v-model="form.name"/>
                        <div class="mt-10">
                            <v-row>

                                <v-col cols="12" md="4" v-for="(rolesLables, index) in rolesFilter" :key="index">
                                    <h4 class="text-capitalize">
                                        {{rolesLables}}
                                    </h4>
                                <template v-for="(permission, index) in permissions">


                                <template v-if="rolesLables == permission.name.split('-')[0]">
<!--                                <template v-if="index === permissions.findIndex(p => p.name.startsWith('client'))">-->
<!--                                    <div class="d-flex justify-center">-->

<!--                                    </div>-->
<!--                                </template>-->
                                    <div>
                                <v-checkbox
                                    :value="permission.id"
                                    v-model="form.permission"
                                    :label="permission.name"
                                />
                                    </div>
                            </template>
                            </template>
                                </v-col>

                            </v-row>
                        </div>
                        <!-- <v-btn type="submit" color="primary">Apply</v-btn> -->
                    </form>

                </div>
            </div>
        </div>
    </div>
    </AuthenticatedLayout>
</template>

<script>
import { ref, watch } from 'vue';
import { useForm } from '@inertiajs/vue3';
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import _ from 'lodash';

export default {
    components: { AuthenticatedLayout },
    props: {
        rolePermissions: Object,
        role: Array,
        permissions: Array,
    },
    computed:{
        rolesFilter() {
            let labels = [];
            this.permissions.forEach(p => {
                let name = p.name.split('-')[0];
                labels.push(name);
            });
            labels = [...new Set(labels)];
            return labels;
        }


    },
    setup(props) {
        const form = useForm({
            name: props.role.name,
            permission: Object.values(props.rolePermissions),
            delPermission: ''
        });
        function submitForm () {
            form.put(route('roles.update', props.role.id), {
                preserveState: true,
                preserveScroll: true,
            });
        };
        const debouncedSubmitSchedule = _.debounce(submitForm, 350);
        watch(() => form.permission, (newPermissions, oldPermissions) => {

                if (JSON.stringify(newPermissions) !== JSON.stringify(oldPermissions)) {
                    debouncedSubmitSchedule();
                }


        }, { deep: true });
        // },500)


        return {
            form,
            submitForm,
        };
    },
}
</script>
