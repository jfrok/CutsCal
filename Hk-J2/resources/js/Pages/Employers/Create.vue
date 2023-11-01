<template>
    <v-form @submit.prevent="createAccount">
        <div class="row">
            <div class="col-12 col-sm-4">
                <v-text-field v-model="form.name" label="Username"></v-text-field>
                <InputError class="mt-2" :message="errors.name"/>
            </div>
            <div class="col-12 col-sm-4">
                <v-text-field v-model="form.email" label="Email"></v-text-field>
                <InputError class="mt-2" :message="errors.email"/>
            </div>
        </div>
        <div class="row">
            <div class="col-12 col-sm-4">
                <v-text-field v-model="form.password" label="Password"></v-text-field>
                <InputError class="mt-2" :message="errors.password"/>
            </div>
            <div class="col-12 col-sm-4">

                <v-text-field v-model="form.password_confirmation" label="Conform Password"></v-text-field>
                <InputError class="mt-2" :message="errors.password_confirmation"/>
            </div>
        </div>
        <h3>Optional</h3>
        <div class="row">
            <div class="col-12 col-sm-4">
                <v-select
                    v-model="form.role"
                    :items="Object.values(allRoles)"
                    chips
                    label="Role"
                    multiple
                ></v-select>
            </div>
            <div class="col-12 col-sm-4">
                <v-select
                    v-model="form.permissions"
                    label="Permissions"
                    multiple
                    :items="Object.values(allPermissions)"
                ></v-select>
            </div>
        </div>
        <div class="row">
            <div class="col-12 col-sm-4">
                <v-text-field v-model="form.job" label="Job"></v-text-field>
            </div>

            <div class="col-12 col-sm-4">

                <v-text-field v-model="form.city" label="City"></v-text-field>
            </div>
        </div>
        <v-text-field v-model="form.address" label="Address"></v-text-field>
        <v-textarea v-model="form.description" label="Description"></v-textarea>
        <!--        <v-file-input v-model="form.img" label="Avatar" accept="image/*"></v-file-input>-->
        <!--        <InputError class="mt-2" :message="form.errors.img"/>-->

        <v-btn color="primary" type="submit">Create Account</v-btn>
    </v-form>
</template>
<script>
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import CreateAccount from "@/Components/CreateAccount.vue";
import InputError from "@/Components/InputError.vue";
import {useForm} from "@inertiajs/vue3";
import {useToast} from "vue-toastification";

export default {
    layout: AuthenticatedLayout,
    components: {InputError},
    props:{
        allRoles:Array,
        allPermissions:Object,
        errors: Object
    },
    setup(props) {
        const toast = useToast();

        function showToastSuccess(message){
            toast.success(message);
        }

        let form = useForm({
            name: '',
            email: '',
            job: '',
            city: '',
            password: '',
            permissions: [],
            password_confirmation: '',
            address: '',
            description: '',
            role: [],
            img: null
        })
        let createAccount = () => {
            form.post(route('employer.store'),{
                onSuccess: () => {
                    showToastSuccess('Successfully created')
                }
            })


        }
        return {form, createAccount}
    },
}
</script>
