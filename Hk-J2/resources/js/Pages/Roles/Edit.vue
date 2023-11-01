<template>
    <AuthenticatedLayout>
    <div class="row">
        <div class="col-sm-12">
            <div class="card card-table">
                <div class="card-body">
                    <h2>{{ form.name }}</h2>
                    <form @submit.prevent="submitForm">
                        <v-text-field label="Role Name" v-model="form.name"/>
                        <div>
                            <div v-for="permission in permissions" :key="permission.id">
                                <v-checkbox
                                    :value="permission.id"
                                    v-model="form.permission"
                                    :label="permission.name"
                                />
                            </div>
                        </div>
<!--                        <v-btn type="submit" color="primary">Apply</v-btn>-->
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
