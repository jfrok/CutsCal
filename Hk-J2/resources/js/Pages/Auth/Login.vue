<template>
    <guest-layout>
    <v-row class="pa-7 pa-md-0 ma-0 h-100 overflow-x-hidden" align="center" align-content="center">
        <v-col cols="12" md="5" class="h-100 auth-banner auth-img-background fireaxered d-none d-md-flex">
<!--            <img src="/images/logo/cutcal-login.png" alt="Background Image" class="auth-banner-image align-self-center" />-->
        </v-col>
        <v-row justify="center" >
        <v-col cols="12" md="7" align-self="center" style="max-width: 500px;">
            <div class="pa-3 pa-md-0 justify-center d-flex flex-column w-100">
                <h1>Welcome to CutCal</h1>
                <p class="account-subtitle">Need an account? <Link :href="route('register')">Sign Up</Link></p>
                <h2>Sign in</h2>
                <v-alert v-if="$page.props.ziggy.flash.error" variant="outlined" type="warning" prominent border="top">
                    {{ $page.props.ziggy.flash.error }}
                </v-alert>
<v-card elevation="0" class="border mb-5" color="#000" @click="navigateToGoogleAuth">
    <div class="d-flex justify-space-between align-center pa-4">
        <svg fill="#090d8b" height="24" width="24" version="1.1" id="Capa_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 210 210" xml:space="preserve" data-darkreader-inline-fill="" style="--darkreader-inline-fill: #181a1b; --darkreader-inline-stroke: #e8e6e3;" stroke="#090d8b" data-darkreader-inline-stroke="">
<g id="SVGRepo_bgCarrier" stroke-width="0"/>
            <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"/>
            <g id="SVGRepo_iconCarrier"> <path d="M0,105C0,47.103,47.103,0,105,0c23.383,0,45.515,7.523,64.004,21.756l-24.4,31.696C133.172,44.652,119.477,40,105,40 c-35.841,0-65,29.159-65,65s29.159,65,65,65c28.867,0,53.398-18.913,61.852-45H105V85h105v20c0,57.897-47.103,105-105,105 S0,162.897,0,105z"/> </g>
</svg>
        <span>Continue with Google</span>
    </div>
</v-card>
                <v-form @submit.prevent="submit">
                    <div class="form-group">
                        <label>Email <span class="login-danger"></span></label>
                        <v-text-field id="email" type="text" v-model="form.email"
                                      class="input-auth"
                                      variant="text" hide-details="auto" autocomplete="email" />
                        <InputError class="mt-2" :message="form.errors.email" />
                    </div>
                    <div class="form-group">
                        <label>Password <span class="login-danger"></span></label>
                            <v-text-field
                                class="input-auth"
                                :type="showPassword ? 'text' : 'password'"
                                v-model="form.password"
                                variant="text"
                                hide-details="auto"
                                required
                                autocomplete="current-password"

                            >

                                <template v-slot:append-inner>
                                    <v-btn
                                        icon
                                        size="x-small"
                                        @click="toggleShowPassword()"
                                        elevation="0"
                                        color="transparent"
                                    >
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16" fill="none">
                                        <path
                                            fill-rule="evenodd"
                                            clip-rule="evenodd"
                                            d="M1.42716 8C1.50002 8.12591 1.59662 8.28637 1.71628 8.47165C2.02362 8.94754 2.47878 9.5804 3.06969 10.2107C4.26368 11.4843 5.933 12.6667 8 12.6667C10.067 12.6667 11.7363 11.4843 12.9303 10.2107C13.5212 9.5804 13.9764 8.94754 14.2837 8.47165C14.4034 8.28637 14.5 8.12591 14.5728 8C14.5 7.87409 14.4034 7.71363 14.2837 7.52835C13.9764 7.05246 13.5212 6.4196 12.9303 5.78929C11.7363 4.51571 10.067 3.33333 8 3.33333C5.933 3.33333 4.26368 4.51571 3.06969 5.78929C2.47878 6.4196 2.02362 7.05246 1.71628 7.52835C1.59662 7.71363 1.50002 7.87409 1.42716 8ZM15.3333 8C15.9296 7.70186 15.9295 7.70163 15.9294 7.70139L15.9283 7.69925L15.926 7.69469L15.9184 7.67988C15.9121 7.66752 15.9031 7.65021 15.8915 7.62829C15.8683 7.58447 15.8347 7.52215 15.7907 7.44399C15.7028 7.28776 15.5734 7.06768 15.4038 6.80498C15.0653 6.28088 14.5621 5.5804 13.903 4.87737C12.597 3.48429 10.5997 2 8 2C5.40033 2 3.40299 3.48429 2.09698 4.87737C1.43789 5.5804 0.93471 6.28088 0.596224 6.80498C0.426567 7.06768 0.297195 7.28776 0.209314 7.44399C0.165349 7.52215 0.131693 7.58447 0.108502 7.62829C0.0969045 7.65021 0.0879168 7.66752 0.0815586 7.67988L0.0739933 7.69469L0.0716926 7.69925L0.0709134 7.7008C0.0707909 7.70104 0.0703819 7.70186 0.666667 8L0.0703819 7.70186C-0.0234606 7.88954 -0.0234606 8.11046 0.0703819 8.29814L0.666667 8C0.0703819 8.29814 0.0702594 8.2979 0.0703819 8.29814L0.0716926 8.30075L0.0739933 8.30531L0.0815586 8.32012C0.0879168 8.33248 0.0969045 8.34979 0.108502 8.37171C0.131693 8.41553 0.165349 8.47785 0.209314 8.55601C0.297195 8.71224 0.426567 8.93232 0.596224 9.19502C0.93471 9.71913 1.43789 10.4196 2.09698 11.1226C3.40299 12.5157 5.40033 14 8 14C10.5997 14 12.597 12.5157 13.903 11.1226C14.5621 10.4196 15.0653 9.71913 15.4038 9.19502C15.5734 8.93232 15.7028 8.71224 15.7907 8.55601C15.8347 8.47785 15.8683 8.41553 15.8915 8.37171C15.9031 8.34979 15.9121 8.33248 15.9184 8.32012L15.926 8.30531L15.9283 8.30075L15.9291 8.2992C15.9292 8.29896 15.9296 8.29814 15.3333 8ZM15.3333 8L15.9296 8.29814C16.0235 8.11046 16.0232 7.88907 15.9294 7.70139L15.3333 8Z"
                                            fill="#8C8B91"
                                        />
                                        <path
                                            fill-rule="evenodd"
                                            clip-rule="evenodd"
                                            d="M8.00016 6.66683C7.26378 6.66683 6.66683 7.26378 6.66683 8.00016C6.66683 8.73654 7.26378 9.3335 8.00016 9.3335C8.73654 9.3335 9.3335 8.73654 9.3335 8.00016C9.3335 7.26378 8.73654 6.66683 8.00016 6.66683ZM5.3335 8.00016C5.3335 6.5274 6.5274 5.3335 8.00016 5.3335C9.47292 5.3335 10.6668 6.5274 10.6668 8.00016C10.6668 9.47292 9.47292 10.6668 8.00016 10.6668C6.5274 10.6668 5.3335 9.47292 5.3335 8.00016Z"
                                            fill="#8C8B91"
                                        />
                                    </svg>
                                </v-btn>
                            </template>
                        </v-text-field>
                    </div>
                    <div class="d-flex justify-space-between align-center w-100">
                    <div class="d-flex align-center">

                            <v-checkbox hide-details color="#3d5ee1" name="remember" v-model:checked="form.remember" />
                        <span class="d-inline-flex text-gray-500"> Remember me</span>
                        <!--                            <span class="checkmark"></span>-->
<!--                        </label>-->
                    </div>
                        <Link v-if="canResetPassword" :href="route('password.request')">
                            Forgot your password?
                        </Link>
                    </div>
                        <!--                    </div>-->
                    <div class="d-flex flex-column gap-2">

                                            <div >
                        <v-btn type="submit" class="bg-official text-white" :class="{ 'opacity-25': form.processing }" :disabled="form.processing">
                            Login
                        </v-btn>
                                            </div>
                    </div>

                </v-form>
            </div>
        </v-col>
        </v-row>
        </v-row>
    </guest-layout>
</template>
<script>
import GuestLayout from "@/Layouts/GuestLayout.vue";
import Checkbox from '@/Components/Checkbox.vue';
import InputError from '../../Components/InputError.vue';
import InputLabel from '@/Components/InputLabel.vue';
import PrimaryButton from '@/Components/PrimaryButton.vue';
import TextInput from '@/Components/TextInput.vue';
import {Head, Link, router, useForm} from '@inertiajs/vue3';
// import logo from '../../images/logo/cutcal-login.png';

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
    // watch: {
    //     showPassword() {
    //         this.moveCursorToEnd();
    //     }
    // },
    methods: {
        navigateToGoogleAuth() {
            window.location.href = route('google-auth');
        },
        logo(){
          return require('../../images/logo/cutcal-login.png')
        },
        error(mesg) {
            toastr.error(mesg)

        },
        submit() {
            this.form.post(route('login'), {
                onFinish: () => this.form.reset('password'),
            });

        },
        togglePasswordVisibility()
        {
            this.showPassword = !this.showPassword;
        },
        toggleShowPassword() {
            this.showPassword = !this.showPassword;
            // this.$nextTick(() => {
            //     this.moveCursorToEnd();
            // });
        },
        moveCursorToEnd() {
            const passwordField = this.$refs.passwordField.$el.querySelector('input');
            const length = passwordField.value.length;
            // console.log(passwordField)
            passwordField.setSelectionRange(length, length);
        }
    },
    components:{GuestLayout, Checkbox,InputError,InputLabel,PrimaryButton,TextInput,Head,Link},
}
</script>
