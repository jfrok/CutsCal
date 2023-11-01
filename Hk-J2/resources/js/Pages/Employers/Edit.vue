<template>

    <!--    //// disply the avatar-->
    <div class="row align-items-center" style="display: flex;justify-content: center;padding: 20px 30px">
        <div class="col-auto profile-image">
            <img class="rounded-circle"  alt="User Image" style="height: 100px"
                 src="https://i.postimg.cc/fLHg7Wx1/system2.webp" />
        </div>
    </div>
    <!--    end disply the avatar-->
    <v-form @submit.prevent="updateAccount">
        <div class="row">
            <div class="col-12 col-sm-4">
                <v-text-field v-model="form.name" label="Username"></v-text-field>
                <InputError class="mt-2" :message="form.errors.name"/>
            </div>
            <div class="col-12 col-sm-4">
                <v-text-field v-model="form.email" label="Email"></v-text-field>
                <InputError class="mt-2" :message="form.errors.email"/>
            </div>
        </div>
        <!--        <div class="row">-->
        <!--            <div class="col-12 col-sm-4">-->
        <!--                <v-text-field v-model="form.password" label="Password"></v-text-field>-->
        <!--                <InputError class="mt-2" :message="form.errors.password"/>-->
        <!--            </div>-->
        <!--        </div>-->
        <h3>Optional</h3>
        <div class="row">
            <div class="col-12 col-sm-4">
                <v-select
                    v-model="form.role"
                    :items="Object.values(roles)"
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
<!--            <div class="d-flex justify-center mt-5 mb-3">-->
<!--                <label for="subscription_end_date">Subscription end date</label>-->
<!--                <flat-pickr class="form-control" id="subscription_end_date" v-model="form.subscription_end_date" />-->
<!--            </div>-->
        </div>
        <v-text-field v-model="form.address" label="Address"></v-text-field>
        <v-textarea v-model="form.description" label="Description"></v-textarea>
        <!--        <v-file-input v-model="form.img" label="Avatar" accept="image/*"></v-file-input>-->
        <!--        <InputError class="mt-2" :message="form.errors.img"/>-->
        <v-btn color="primary" type="submit">Update</v-btn>
    </v-form>
    <v-card
        class="overflow-y-auto"
        max-height="400"
    >
        <v-card-text>

            <div v-for="userPermission in userPermissions" :key="userPermission.id">
                {{userPermission.name}}
            </div>
        </v-card-text>
    </v-card>

</template>
<script>
import {router, useForm} from "@inertiajs/vue3";
import FlatPickr from 'vue-flatpickr-component';
import 'flatpickr/dist/flatpickr.css'; // Import the FlatPickr CSS

import InputError from "@/Components/InputError.vue";
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import format from "@popperjs/core/lib/utils/format";
export default {
    layout:AuthenticatedLayout,
    props:{
        employer:Array,
        employerRole:String,
        roles:Object,
        allPermissions:Object,
        addedPermissions:Object,
        userPermissions:Array

    },

    components: {InputError,FlatPickr},

    setup(props){
        const permissionNames = props.addedPermissions.map((per) => per.name)

        let form = useForm({
            name: props.employer.name,
            email: props.employer.email,
            job: props.employer.job,
            city: props.employer.city,
            password: '',
            permissions: permissionNames,
            address: props.employer.address,
            description: props.employer.description,
            role: Object.values(props.employerRole),
            // subscription_end_date: props.employer.subscription_end_date,
            img: props.employer.avatar
        })
        let updateAccount = () => {
            form.post(route('employer.update',props.employer.id), )

        }
        return {form, updateAccount}
    },
    // watch: {
    //     userPermissions: function(newVal, oldVal) {
    //         const permissionNames = newVal.map((per) => per.name)
    //
    //         // this.form.permissions = permissionNames
    //         console.log('Prop changed: ', newVal, ' | was: ', oldVal)
    //     }
    //     }
    // computed {
    // },
};
</script>
