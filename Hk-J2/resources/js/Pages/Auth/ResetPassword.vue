<script setup>
import GuestLayout from '@/Layouts/GuestLayout.vue';
import InputError from '@/Components/InputError.vue';
import InputLabel from '@/Components/InputLabel.vue';
import PrimaryButton from '@/Components/PrimaryButton.vue';
import TextInput from '@/Components/TextInput.vue';
import { Head, useForm,Link } from '@inertiajs/vue3';

const props = defineProps({
    email: {
        type: String,
        required: true,
    },
    token: {
        type: String,
        required: true,
    },
    status: {
        type: String,
    }
});

const form = useForm({
    token: props.token,
    email: props.email,
    password: '',
    password_confirmation: '',
});

const submit = () => {
    form.post(route('password.store'), {
        onFinish: () => form.reset('password', 'password_confirmation'),
    });
};
</script>

<template>
    <GuestLayout>
        <Head title="Reset Password" />
        <v-row class="pa-7 pa-md-0 ma-0 h-100 overflow-x-hidden" align="center" align-content="center">
            <v-col cols="12" md="5" class="h-100 auth-banner auth-img-background fireaxered d-none d-md-flex">
            </v-col>
            <v-row justify="center">
                <v-col cols="12" md="7" align-self="center" style="max-width: 500px;">
                        <div class="login-left">
<!--                            <img class="img-fluid" src="../assets/img/login.png" alt="Logo">-->
                        </div>
                        <div class="login-right">
                            <div class="login-right-wrap">
                                <h1>Welcome to CutsCal </h1>
                                <p class="account-subtitle">Do you want to <Link :href="route('login')">Sign In</Link>?</p>
                                  <h3>
                                        Reset your password
                                    </h3>

                                <div v-if="status" class="mb-4 font-medium text-sm text-green-600">
                                    {{ status }}
                                </div>

                                <form @submit.prevent="submit">
                                    <div>
                                        <InputLabel for="email" value="Email" />

                                        <v-text-field
                                            variant="text"
                                            class="input-auth"
                                            id="email"
                                            type="email"
                                            v-model="form.email"
                                            required
                                            autofocus
                                            autocomplete="username"
                                        />

                                        <InputError class="mt-2" :message="form.errors.email" />
                                    </div>

                                    <div class="mt-4">
                                        <InputLabel for="password" value="Password" />

                                        <v-text-field
                                            variant="text"
                                            class="input-auth"
                                            id="password"
                                            type="password"
                                            v-model="form.password"
                                            required
                                            autocomplete="new-password"
                                        />

                                        <InputError class="mt-2" :message="form.errors.password" />
                                    </div>

                                    <div class="mt-4">
                                        <InputLabel for="password_confirmation" value="Confirm Password" />

                                        <v-text-field
                                            id="password_confirmation"
                                            type="password"
                                            variant="text"
                                            class="input-auth"
                                            v-model="form.password_confirmation"
                                            required
                                            autocomplete="new-password"
                                        />

                                        <InputError class="mt-2" :message="form.errors.password_confirmation" />
                                    </div>

                                    <div class="flex items-center justify-end mt-4">
                                        <v-btn  class="bg-official text-white" type="submit" :class="{ 'opacity-25': form.processing }" :disabled="form.processing">
                                            Reset Password
                                        </v-btn>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </v-col>
                </v-row>
            </v-row>
    </GuestLayout>
</template>
