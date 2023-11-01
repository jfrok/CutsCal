<script setup>
import InputError from '@/Components/InputError.vue';
import PrimaryButton from '@/Components/PrimaryButton.vue';
import TextInput from '@/Components/TextInput.vue';
import { Head, Link, useForm } from '@inertiajs/vue3';
import Checkbox from "@/Components/Checkbox.vue";

const form = useForm({
    name: '',
    email: '',
    lang: '',
    password: '',
    password_confirmation: '',
    terms: false,
});

const submit = () => {
    form.post(route('account.store'), {
        // onFinish: () => alert('success'),
    });
};
</script>
<script>
import GuestLayout from "@/Layouts/GuestLayout.vue";

export default {
    layout:GuestLayout,
}
</script>

<template>
    <!--    <GuestLayout>-->
    <Head title="Register" />

    <div class="main-wrapper login-body">

        <div class="login-wrapper">

            <div class="container">

                <v-alert
                    v-if="$page.props.ziggy.flash.error"
                    variant="outlined"
                    type="warning"
                    prominent
                    border="top"
                >
                    {{ $page.props.ziggy.flash.error }}
                </v-alert>
                <div class="loginbox">
                    <div class="login-left">
                        <img class="img-fluid" style="height: 680px" src="/images/logo/cutcal-login.png" alt="Logo">
                    </div>
                    <div class="login-right">
                        <div class="login-right-wrap">
                            <h1>Welcome to JfrO</h1>
                            <!--                                <p class="account-subtitle">Need an account? <a href="register.html">Sign Up</a></p>-->
                            <h2>Sign up</h2>

                            <form @submit.prevent="submit">
                                <div class="form-group">
                                    <label>Username <span class="login-danger">*</span></label>
                                    <TextInput
                                        id="name"
                                        type="text"
                                        class="form-control"
                                        v-model="form.name"

                                        autofocus
                                        autocomplete="name"
                                    />

                                    <InputError class="mt-2" :message="form.errors.name" />
                                    <span class="profile-views"><i class="fas fa-user-circle"></i></span>
                                </div>
                                <div class="form-group">
                                    <label>Email <span class="login-danger">*</span></label>
                                    <TextInput
                                        id="email"
                                        type="email"
                                        class="form-control"
                                        v-model="form.email"

                                        autocomplete="username"
                                    />
                                    <InputError class="mt-2" :message="form.errors.email" />
                                    <span class="profile-views"><i class="fas fa-mail-bulk"></i></span>
                                </div>
                                <div class="form-group">
                                    <label>Password <span class="login-danger">*</span></label>
                                    <!--                                        <input class="form-control pass-input" type="text">-->
                                    <TextInput
                                        id="password"
                                        type="password"
                                        class="form-control pass-input"
                                        v-model="form.password"

                                        autocomplete="new-password"                                        />
                                    <!--                                        <span class="profile-views feather-eye toggle-password"></span>-->
                                    <InputError class="mt-2" :message="form.errors.password" />
                                    <span class="profile-views"><i class="fas fa-lock"></i></span>
                                </div>
                                <div class="form-group">
                                    <label>Conform Password <span class="login-danger">*</span></label>

                                    <TextInput
                                        id="password_confirmation"
                                        type="password"
                                        class="form-control pass-input"
                                        v-model="form.password_confirmation"
                                        autocomplete="new-password"
                                    />
                                    <span class="profile-views"><i class="fas fa-lock"></i></span>
                                </div>
                                <div>
                                    <h7>By creating an account, you agree with our <a :href="route('PrivacyPolicy')" target="_blank">Privacy and Policy</a>.</h7>
<!--                                <v-checkbox label="" aria-required="true"/>-->
                                </div>
                                <div class="forgotpass">
                                    <Link
                                        :href="route('login')"
                                        class="underline text-sm text-gray-600 hover:text-gray-900 rounded-md focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
                                    >
                                        Already registered?
                                    </Link>
                                    <!--                                        <a href="forgot-password.html">Forgot Password?</a>-->
                                </div>
                                <v-radio-group
                                    v-model="form.lang"
                                    column
                                >
                                <v-radio
                                    label="English"
                                    color="red-darken-3"
                                    value="english"
                                ></v-radio>
                                <v-radio
                                    label="Arabic"
                                    color="indigo"
                                    value="arabic"
                                ></v-radio>
                                </v-radio-group>
                                <div class="form-group">
                                    <PrimaryButton style="background-color: #0a53be" class="ml-4" :class="{ 'opacity-25': form.processing }" :disabled="form.processing">
                                        Register
                                    </PrimaryButton>
                                    <!--                                        <button class="btn btn-primary btn-block" type="submit">Login</button>&ndash;&gt;-->
                                </div>
                            </form>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
