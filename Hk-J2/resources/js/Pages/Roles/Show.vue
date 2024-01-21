<template>
    <div class="row">
        <div class="col-sm-12">
            <div class="card card-table border-r-20 border-secondary-color-2 bg-official-secondary">
                <div class="card-body">
                    <h2>{{ role.name }}</h2>
                    <div class="table-responsive">
                        <Link :href="route('roles.edit',role.id)">
                        <v-btn value="outlined" style="background-color: #0a53be">Edit</v-btn>
                                    </Link>
                            <div v-for="permission in rolePermissions" :key="permission.id">
                                <h1>
                                      <v-label>{{ permission.name }}</v-label>
                                </h1>
                            </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import {Link} from "@inertiajs/vue3";

export default {
    layout: AuthenticatedLayout,
    components: {
        Link
    },
    props: {
        rolePermissions: Array,
        role: Array
    }
}
</script>
