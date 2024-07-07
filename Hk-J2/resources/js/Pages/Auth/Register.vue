<template>
    <GuestLayout>
        <Head title="Sign Up"/>
        <v-row class="pa-7 pa-md-0 ma-0 h-100" align="center" align-content="center">
            <v-col cols="12" md="5" class="h-100 auth-banner auth-img-background fireaxered d-none d-md-flex">
            </v-col>
            <v-row justify="center" class="pa-md-10 pb-md-15">

                <v-col cols="12" md="7" align-self="center" style="max-width: 500px;">
                    <v-alert
                        v-if="$page.props.ziggy.flash.error"
                        variant="outlined"
                        type="warning"
                        prominent
                        border="top"
                    >
                    </v-alert>

                    <div class="login-right">
                        <div class="login-right-wrap">

                            <h1>Welcome to CutsCal </h1>
                            <p class="account-subtitle">Already have an account? <Link :href="route('login')">Sign In</Link></p>

                            <auth-otp v-if="step == 2" @otp="(data)=>{code = data}" :message="message"
                                      :email="form.email"></auth-otp>
                            <div class="form-group" v-if="step == 3">
                                <label>Username <span class="login-danger">*</span></label>
                                <v-text-field
                                    id="name"
                                    type="text"
                                    variant="text"
                                    class="input-auth"
                                    v-model="form.name"
                                    hide-details="auto"
                                    :rules="config.validationRules.required"
                                    autocomplete="name"
                                />

                                <InputError class="mt-2" :message="form.errors.name"/>
                            </div>
                            <div class="form-group" v-if="step == 1">
                                <google-auth/>
                                <label>Email <span class="login-danger">*</span></label>
                                <v-text-field
                                    id="email"
                                    type="email"
                                    variant="text"
                                    class="input-auth"
                                    v-model="form.email"
                                    hide-details="auto"
                                    :rules="config.validationRules.email"
                                    autocomplete="email"
                                />
                                <InputError class="mt-2" :message="message"/>
                            </div>
                            <div class="form-group" v-if="step == 3">
                                <label>Password <span class="login-danger">*</span></label>
                                <v-text-field
                                    id="password"
                                    type="password"
                                    variant="text"
                                    class="input-auth"
                                    v-model="form.password"
                                    hide-details="auto"
                                    :rules="config.validationRules.required"

                                    autocomplete="new-password"/>
                                <!--                                        <span class="profile-views feather-eye toggle-password"></span>-->
                                <InputError class="mt-2" :message="form.errors.password"/>
                                <!--                                    <span class="profile-views"><i class="fas fa-lock"></i></span>-->
                            </div>
                            <div class="form-group" v-if="step == 3">
                                <label>Conform Password <span class="login-danger">*</span></label>

                                <v-text-field
                                    id="password_confirmation"
                                    type="password"
                                    variant="text"
                                    class="input-auth"
                                    hide-details="auto"
                                    v-model="form.password_confirmation"
                                    :rules="config.validationRules.required"

                                    autocomplete="new-password"
                                />
                                <!--                                    <span class="profile-views"><i class="fas fa-lock"></i></span>-->
                            </div>
                            <div>
                                <h7>By creating an account, you agree with our <a :href="route('PrivacyPolicy')"
                                                                                  target="_blank">Privacy and Policy</a>.
                                </h7>
                            </div>

                            <v-radio-group v-if="step == 1"
                                           v-model="form.lang"
                                           :rules="config.validationRules.required"

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
                            <div class="d-flex justify-space-between w-100 mt-10">
                                <v-btn class="text-white" @click="step = 1" v-if="step == 3" style="background-color: #0a53be"
                                       :class="{ 'opacity-25': form.processing }"
                                       :disabled="form.processing">
                                    Back
                                </v-btn>
                                <v-btn class="text-white" @click="step = 1" v-if="step == 2" style="background-color: #0a53be"
                                       :class="{ 'opacity-25': form.processing }"
                                       :disabled="form.processing">
                                    Back
                                </v-btn>
                                <v-btn class="text-white" @click="verifyOtp" v-if="step == 2" style="background-color: #0a53be"
                                       :class="{ 'opacity-25': form.processing }"
                                       :disabled="code.length != 4?true:false">
                                    Next
                                </v-btn>
                                <v-btn class="text-white" @click="isOtpVerified" v-if="step == 1" style="background-color: #0a53be"
                                       :class="{ 'opacity-25': form.processing }"
                                       :disabled="form.email == null||form.lang == null">
                                    Next
                                </v-btn>
                                <v-btn class="text-white" v-if="step == 3" @click="submit" style="background-color: #0a53be"
                                       :class="{ 'opacity-25': form.processing }"
                                       :disabled="form.processing">
                                    Submit
                                </v-btn>
                                <!--                                        <button class="btn btn-primary btn-block" type="submit">Login</button>&ndash;&gt;-->
                            </div>
                            <!--                        </v-form>-->
                        </div>

                    </div>

                    <!--                </div>-->
                </v-col>
            </v-row>
        </v-row>
        <!--            </div>-->
        <!--        </div>-->
        <!--    </div>-->
    </GuestLayout>
</template>
<script>
import InputError from '@/Components/InputError.vue';
import axios from "axios";
import {Head, Link, router, useForm} from '@inertiajs/vue3';
import GuestLayout from "@/Layouts/GuestLayout.vue";
import config from "@/config";
import AuthOtp from "@/Components/auth/auth-otp.vue";
import GoogleAuth from "@/Components/google-auth.vue";

export default {
    computed: {
        config() {
            return config
        }
    },
    props: {
        errors: Object,
    },
    components: {GoogleAuth, GuestLayout, AuthOtp, InputError,Link,Head},
    layout: GuestLayout,
    data() {
        return {
            valid: false,
            step: 1,
            code: '',
            message: null,
            form: useForm({
                name: '',
                email: null,
                lang: null,
                password: '',
                password_confirmation: '',
                terms: false,
                otp_status: false
            })
        }
    },
    watch: {
        step(val) {
            this.message = null
        }
    },
    methods: {
        isOtpVerified() {
            axios.post(route('otp.check'), {
                email: this.form.email,
            }).then((res) => {
                console.log(res.data)
                if (res.data.verified) {
                    this.step = 3
                } else if (res.data.verified == false) {
                    this.step = 2
                } else if (res.data.status == 201) {
                    this.step = 3
                } else {
                    this.message = res.data.message
                }
            }).catch((err) => {
                if (err.response.data.status == 909) {
                    this.step = 2
                }else if (err.response.data.status == 201) {
                    this.step = 3
                } else {
                    this.message = err.response.data.message
                }
            })
        },
        verifyOtp() {
            axios.post(route('otp.verify'), {
                email: this.form.email,
                otp: this.code,
            }).then((res) => {
                if (res.data.status == 200) {
                    this.step = 3
                }
                this.message = res.data.message
                console.log(res.data)
            })
        },
        submit() {
            this.form.post(route('account.store'), {
                // onFinish: () => alert('success'),
            });
        }
    }
}
</script>
