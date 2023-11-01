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
                    <v-btn color="blue-darken-1" @click="saveUser" variant="text">
                        {{ editMode ? 'Update' : 'Save' }}
                    </v-btn>
                </v-card-actions>
            </v-card>
</template>

<script>
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import {router, useForm} from "@inertiajs/vue3";
import InputError from "@/Components/InputError.vue";
import {reactive, ref} from "vue";
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

        function saveUser() {
            const emit = defineEmits(['close-dialog']);
            form.post(route('services.create'),form, {
                preserveScroll: true,
                preserveState: true,
                onSuccess: () => {
                    showToastSuccess('Successfully added')
                        form.name = '';
                    form.price = '';
                    form.duration = '';
                    emit('close-dialog',false)
                    // form.editMode ? form.editMode = false : form.editMode = true;
                    // form.editMode ? showToastSuccess('Successfully updated') : showToastSuccess('Successfully added')
                    form.reset()
                    // form.dialog = false;
                },
            });
        }

        function showToastSuccess(message) {
            toast.success(message);
        }

        return {form,saveUser};
    },
    data: () =>{
        return{
            editMode:false,
            dialog:false,
        }
    }
};
</script>
