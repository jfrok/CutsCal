<template>
    <v-form @submit.prevent="createAccount">
        <v-text-field v-model="form.name" label="Name"></v-text-field>
        <InputError class="mt-2" :message="form.errors.name"/>
        <v-text-field v-model="form.email" label="Email"></v-text-field>
        <InputError class="mt-2" :message="form.errors.email"/>
        <v-text-field v-model="form.password" label="Password"></v-text-field>
        <InputError class="mt-2" :message="form.errors.password"/>
        <v-text-field v-model="form.password_confirmation" label="Conform Password"></v-text-field>
        <InputError class="mt-2" :message="form.errors.password_confirmation"/>

        <v-text-field v-model="form.job" label="Job"></v-text-field>
        <v-text-field v-model="form.city" label="City"></v-text-field>
        <v-text-field v-model="form.address" label="Address"></v-text-field>
        <v-textarea v-model="form.description" label="Description"></v-textarea>
        <v-file-input v-model="form.img" label="Avatar" accept="image/*"></v-file-input>
        <InputError class="mt-2" :message="form.errors.img"/>

        <v-btn color="primary" type="submit">Create Account</v-btn>
    </v-form>
</template>

<script>
import {router, useForm} from "@inertiajs/vue3";
import InputError from "@/Components/InputError.vue";

export default {
    components: {InputError},
    setup(){
       let form = useForm({
           name: '',
           email: '',
           job: '',
           city: '',
           password: '',
           password_confirmation: '',
           address: '',
           description: '',
           img: null
        })
      let createAccount = () => {
          form.post(route('account.create'), )

      }
      return {form, createAccount}
    },
    data() {
        return {
            name: '',
            email: '',
            job: '',
            city: '',
            address: '',
            description: '',
            img: null
        };
    },
    methods: {

    }
};
</script>
