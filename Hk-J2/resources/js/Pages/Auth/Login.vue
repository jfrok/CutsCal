<template>
        <div v-if="status" class="mb-4 font-medium text-sm text-green-600">
            {{ status }}
        </div>
{{form.password}}
        <div class="main-wrapper login-body">

            <div class="login-wrapper">
                <div class="container">
<!--                    <div v-if="$page.props.ziggy.flash.error" class="mb-4 font-medium text-sm text-green-600">-->
<!--                        {{ $page.props.ziggy.flash.error }}-->
<!--                    </div>-->

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
                            <img class="img-fluid" src="/images/logo/cutcal-login.png" alt="Logo">
                        </div>
                        <div class="login-right">
                            <div class="login-right-wrap">
                                <h1>Welcome to JfrO</h1>
                                <p class="account-subtitle">Need an account? <Link :href="route('register')">Sign Up</Link></p>
                                <h2>Sign in</h2>

                                <form @submit.prevent="submit">
                                    <div class="form-group">
                                        <label>Email <span class="login-danger">*</span></label>
                                        <TextInput
                                            id="email"
                                            type="text"
                                            class="form-control"
                                            v-model="form.email"
                                            required
                                            autofocus
                                            autocomplete="email"
                                        />

                                        <InputError class="mt-2" :message="form.errors.email" />
                                        <span class="profile-views"><i class="fas fa-user-circle"></i></span>
                                    </div>
                                    <div class="form-group">
                                        <label>Password <span class="login-danger">*</span></label>
<!--                                        <input class="form-control pass-input" type="text">-->
                                        <TextInput
                                            id="password"
                                            :type="showPassword ? 'text' : 'password'"
                                            class="form-control pass-input"
                                            v-model="form.password"
                                            required
                                            autocomplete="current-password"
                                        />
                                        <a style="color: white" href="javascript:void(0)" @click="togglePasswordVisibility"><span class="profile-views feather-eye toggle-password"></span></a>
                                    </div>
                                    <div class="forgotpass">
                                        <div class="remember-me">
                                            <label class="custom_check mr-2 mb-0 d-inline-flex remember-me"> Remember me
                                                <Checkbox name="remember" v-model:checked="form.remember" />
                                                <span class="checkmark"></span>
                                            </label>
                                        </div>
                                        <Link
                                            v-if="canResetPassword"
                                            :href="route('password.request')"
                                        >
                                            Forgot your password?
                                        </Link>
<!--                                        <a href="forgot-password.html">Forgot Password?</a>-->
                                    </div>

                                    <div class="form-group">
                                        <PrimaryButton class="ml-4" style="background-color: #0a53be" :class="{ 'opacity-25': form.processing }" :disabled="form.processing" >
                                            Log in
                                        </PrimaryButton>
<!--                                        <button class="btn btn-primary btn-block" type="submit">Login</button>-->
                                    </div>
                                </form>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
</template>
<script>
import GuestLayout from "@/Layouts/GuestLayout.vue";
import Checkbox from '@/Components/Checkbox.vue';
import InputError from '../../Components/InputError.vue';
import InputLabel from '@/Components/InputLabel.vue';
import PrimaryButton from '@/Components/PrimaryButton.vue';
import TextInput from '@/Components/TextInput.vue';
import { Head, Link,useForm } from '@inertiajs/vue3';

export default {
    props:{
        canResetPassword: {
            type: Boolean,
        },
        status: {
            type: String,
        },
    },
    Layout: GuestLayout,
    data(){
       return {
           showPassword:false,
          form:useForm({
              email: '',
              remember: false,
              password:'',
          })
       }
    },
    methods: {
        error(mesg) {
            toastr.error(mesg)
        },
        submit() {
            this.form.post(route('login'), {
                onFinish: () => form.reset('password'),
            });

        },
        togglePasswordVisibility()
        {
            this.showPassword = !this.showPassword;
        }
    },
    components:{Checkbox,InputError,InputLabel,PrimaryButton,TextInput,Head,Link},
}
</script>
