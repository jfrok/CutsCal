<template>
        <!--        // Dialog-->
            <v-card>
                <v-card-title>
                    <span class="text-h5">{{ editMode ? 'Edit Service' : 'Create Service' }}</span>
                </v-card-title>
                <v-card-text>
                    <v-container>
                        <v-row>
                            <v-col cols="12">
                                <v-text-field label="Name" v-model="form.name" required></v-text-field>
                                <InputError :message="form.errors.name"/>
                            </v-col>
                            <v-col md="6">
                                <v-text-field label="Price" v-model="form.price"></v-text-field>
                                <InputError :message="form.errors.price"/>
                            </v-col>
                            <v-col md="6">
                                <v-text-field label="Duration" v-model="form.duration"></v-text-field>
                                <InputError :message="form.errors.duration"/>
                            </v-col>
                        </v-row>
                    </v-container>
                    <!--                    <small>*indicates required field</small>-->
                </v-card-text>
                <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn color="blue-darken-1" variant="text" @click="$emit('close-dialog',false)">
                        Close
                    </v-btn>
                    <v-btn color="blue-darken-1" @click="$emit('update',form);" variant="text">
                        {{ editMode ? 'Update' : 'Save' }}
                    </v-btn>
                </v-card-actions>
            </v-card>
</template>

<script>
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import {router, useForm} from "@inertiajs/vue3";
import InputError from "@/Components/InputError.vue";
import {useToast} from "vue-toastification";
import {Head} from "@inertiajs/vue3";
export default {
    components: {
        Head,
        InputError,
        AuthenticatedLayout,
    },
    props: {
        errors: Object,
        clients: Object,
    },
    setup(props) {
        const toast = useToast();
        let form = useForm({
            name: '',
            price: '',
            duration: '',
        });



        function showToastSuccess(message) {
            toast.success(message);
        }

        return {form};
    },
    data: () =>{
        return{
            editMode:false,
            dialog:false,
        }
    }
};
</script>
