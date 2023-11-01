<template>
    <div>
        <div class="row">
            <div class="col-lg-12 margin-tb">
                <div class="pull-left">
                    <h2>Create New Role</h2>
                </div>
                <div class="pull-right">
                    <a class="btn btn-primary" @click="$inertia.visit(route('roles.index'))">Back</a>
                </div>
            </div>
        </div>

        <form @submit.prevent="submitForm">
            <div class="row">
                <div class="col-xs-12 col-sm-12 col-md-12">
                    <div class="form-group mt-5">
                        <v-text-field v-model="form.name" placeholder="Name"></v-text-field>
                    </div>
                </div>
                <div class="col-xs-12 col-sm-12 col-md-12">
                    <div class="form-group">
                        <label>Permission:</label>
                        <br />

                            <v-checkbox
                                v-for="value in permission" :key="value.id"
                                :value="value.id"
                                v-model="form.permission"
                                :label="value.name"
                            ></v-checkbox>
                    </div>
                </div>
                <div class="col-xs-12 col-sm-12 col-md-12 text-center">
                    <button type="submit" class="btn btn-primary">Submit</button>
                </div>
            </div>
        </form>
    </div>
</template>

<script>
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import {router} from "@inertiajs/vue3";

export default {
    data() {
        return {
            form: {
                name: '',
                permission: [],
            },
            // permission: {!! json_encode($permission) !!},
    };

    },
    layout:AuthenticatedLayout,
    methods: {
        submitForm() {
            router.post(route('roles.store'), this.form);
        },
    },
    props:{
        permission:Array
    }
};
</script>
