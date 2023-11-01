<script setup>
// import GuestLayout from '@/Layouts/GuestLayout.vue';
import InputError from '@/Components/InputError.vue';
import InputLabel from '@/Components/InputLabel.vue';
import PrimaryButton from '@/Components/PrimaryButton.vue';
import TextInput from '@/Components/TextInput.vue';
import {Head, useForm,Link} from '@inertiajs/vue3';

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
        <div class="main-wrapper login-body">
            <div class="login-wrapper">
                <div class="container">
                    <div class="loginbox">
                        <div class="login-left">
                            <img class="img-fluid" src="/images/logo/cutcal-login.png" alt="Logo">
                        </div>
                        <div class="login-right">
                            <div class="login-right-wrap">
                                <h6>
                                    Forgot your password? No problem. Just let us know your email address.

                                </h6>

                                    <div v-if="status" class="mb-4 font-medium text-sm text-green-600">
                                        {{ status }}
                                    </div>

                                    <form @submit.prevent="submit">
                                        <div>
                                            <InputLabel for="email" value="Email"/>

                                            <TextInput
                                                id="email"
                                                type="email"
                                                class="form-control"                                                v-model="form.email"
                                                required
                                                autofocus
                                                autocomplete="username"
                                            />

                                            <InputError class="mt-2" :message="form.errors.email"/>
                                        </div>
                                        <Link :href="route('login')" style="margin: 10px; position: relative; float: right">
                                            Return to sign page?
                                        </Link>
                                        <div class="flex items-center justify-end mt-4">

                                        </div>
                                        <div class="flex items-center justify-end mt-4">
                                            <PrimaryButton :class="{ 'opacity-25': form.processing }" :disabled="form.processing" style="background-color: #0a53be">
                                                Email Password Reset Link
                                            </PrimaryButton>
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

export default {
    Layout: GuestLayout
}
</script>
