<script setup>
// import GuestLayout from '@/Layouts/GuestLayout.vue';
import InputError from '@/Components/InputError.vue';
import InputLabel from '@/Components/InputLabel.vue';
import PrimaryButton from '@/Components/PrimaryButton.vue';
import TextInput from '@/Components/TextInput.vue';
import {Head, useForm, Link} from '@inertiajs/vue3';

defineProps({
    status: {
        type: String,
    },
});

const form = useForm({
    email: '',
});

const submit = () => {
    form.post(route('password.email'));
};
</script>

<template>
    <Head title="Forgot Password"/>
    <guest-layout>
        <v-row class="pa-7 pa-md-0 ma-0 h-100 overflow-x-hidden" align="center" align-content="center">
            <v-col cols="12" md="5" class="h-100 auth-banner auth-img-background fireaxered d-none d-md-flex">
            </v-col>
            <v-row justify="center">
                <v-col cols="12" md="7" align-self="center" style="max-width: 500px;">
                    <div class="login-right-wrap">

                                <h1>Welcome to CutsCal </h1>
                        <p class="account-subtitle">Do you want to? <Link :href="route('login')">Sign In</Link></p>

                                <h6>
                            Forgot your password? No problem. Just let us know your email address.

                        </h6>

                        <div v-if="status" class="mb-4 font-medium text-sm text-green-600">
                            {{ status }}
                        </div>

                        <form @submit.prevent="submit">
                            <div>
                                <InputLabel for="email" value="Email"/>
                                <v-text-field
                                    class="input-auth"
                                    id="email"
                                    type="email"
                                    required
                                    autofocus
                                    v-model="form.email"
                                    autocomplete="username"
                                    variant="text"
                                ></v-text-field>
                                <InputError class="mt-2" :message="form.errors.email"/>
                            </div>
                            <div class="flex items-center justify-end mt-4">

                            </div>
                            <div class="flex items-center justify-end mt-4">
                                <v-btn :class="{ 'opacity-25': form.processing }" type="submit" :disabled="form.processing"
                                       class="bg-official text-white">
                                    Email Password Reset Link
                                </v-btn>
                            </div>
                        </form>
                    </div>
                </v-col>
            </v-row>
        </v-row>
    </guest-layout>

</template>
<script>
import GuestLayout from "@/Layouts/GuestLayout.vue";

export default {
    Layout: GuestLayout
}
</script>
