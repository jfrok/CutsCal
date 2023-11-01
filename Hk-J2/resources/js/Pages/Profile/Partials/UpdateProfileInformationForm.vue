<script setup>
import InputError from '@/Components/InputError.vue';
import InputLabel from '@/Components/InputLabel.vue';
import PrimaryButton from '@/Components/PrimaryButton.vue';
import TextInput from '@/Components/TextInput.vue';
import {Link, useForm, usePage} from '@inertiajs/vue3';
import {reactive, ref, watch} from "vue";
import {useDropzone} from "vue3-dropzone";
import AvatarDialog from "@/Components/AvatarDialog.vue";

defineProps({
    mustVerifyEmail: {
        type: Boolean,
    },
    status: {
        type: String,
    },
});

const user = usePage().props.auth.user;
let avatarDialog = ref(false);

const openAvatarDialog = () => {
    avatarDialog.value = true;
};

const closeAvatarDialog = () => {
    avatarDialog.value = false;
};
const form = useForm({
    name: user.name,
    email: user.email,
    job: user.job,
    city: user.city,
    address: user.address,
    description: user.description,
    img: ''
});


let submit = (e) => {
    console.log(state.files)
    form.img = e ? e.target.files[0] : state.files
    form.post(route('updateProfile'), {
        onSuccess: () => {
            // $('#uploadAvatar').modal('toggle')
            // form.reset('img')
            handleClickDeleteFile(0)
        }
    })
}



</script>

<template>
    <section>
<!--        <v-btn @click="openAvatarDialog">o</v-btn>-->

        <!--        <header>-->
        <!--            <h2 class="text-lg font-medium text-gray-900">Profile Information</h2>-->

        <!--            <p class="mt-1 text-sm text-gray-600">-->
        <!--                Update your account's profile information and email address.-->
        <!--            </p>-->
        <!--        </header>-->

        <form @submit.prevent="form.post(route('updateProfile'),{preserveScroll:true})" class="mt-6 space-y-6">
            <div class="row">

                <p class="col-sm-3 text-muted text-sm-end mb-0 mb-sm-3">Name</p>
                <p class="col-sm-9">
                    <TextInput
                        id="name"
                        type="text"
                        class="form-control"
                        v-model="form.name"
                        required
                        autofocus
                        autocomplete="name"
                    />

                    <InputError class="mt-2" :message="form.errors.name"/>
                </p>
            </div>

            <div class="row">

                <p class="col-sm-3 text-muted text-sm-end mb-0 mb-sm-3">Email</p>
                <p class="col-sm-9">
                    <!--                <InputLabel for="email" value="Email" />-->

                    <TextInput
                        id="email"
                        type="email"
                        class="form-control"
                        v-model="form.email"
                        required
                        autocomplete="username"
                    />
                </p>
                <InputError class="mt-2" :message="form.errors.email"/>
            </div>

            <div class="row">

                <p class="col-sm-3 text-muted text-sm-end mb-0 mb-sm-3">Occupation</p>
                <p class="col-sm-9">
                    <!--                <InputLabel for="email" value="Email" />-->

                    <TextInput
                        id="job"
                        type="text"
                        class="form-control"
                        v-model="form.job"
                        autocomplete="job"
                    />
                </p>
                <InputError class="mt-2" :message="form.errors.job"/>
            </div>

            <div class="row">

                <p class="col-sm-3 text-muted text-sm-end mb-0 mb-sm-3">Land</p>
                <p class="col-sm-9">
                    <!--                <InputLabel for="email" value="Email" />-->

                    <TextInput
                        id="city"
                        type="text"
                        class="form-control"
                        v-model="form.city"
                        autocomplete="city"
                    />
                </p>
                <InputError class="mt-2" :message="form.errors.city"/>
            </div>

            <div class="row">

                <p class="col-sm-3 text-muted text-sm-end mb-0 mb-sm-3">City</p>
                <p class="col-sm-9">
                    <!--                <InputLabel for="email" value="Email" />-->

                    <TextInput
                        id="address"
                        type="text"
                        class="form-control"
                        v-model="form.address"
                        autocomplete="address"
                    />
                </p>
                <InputError class="mt-2" :message="form.errors.address"/>
            </div>

            <div class="row">

                <p class="col-sm-3 text-muted text-sm-end mb-0 mb-sm-3">Description</p>
                <p class="col-sm-9">
                    <!--                <InputLabel for="email" value="Email" />-->

                    <textarea
                        id="description"
                        type="text"
                        class="form-control"
                        v-model="form.description"
                        autocomplete="description"
                    ></textarea>
                </p>
                <InputError class="mt-2" :message="form.errors.description"/>
            </div>

            <div v-if="mustVerifyEmail && user.email_verified_at === null">
                <p class="text-sm mt-2 text-gray-800">
                    Your email address is unverified.
                    <Link
                        :href="route('verification.send')"
                        method="post"
                        as="button"
                        class="underline text-sm text-gray-600 hover:text-gray-900 rounded-md focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
                    >
                        Click here to re-send the verification email.
                    </Link>
                </p>

                <div
                    v-show="status === 'verification-link-sent'"
                    class="mt-2 font-medium text-sm text-green-600"
                >
                    A new verification link has been sent to your email address.
                </div>
            </div>

            <div class="flex items-center gap-4">
                <PrimaryButton :disabled="form.processing" style="float: right;position: relative">Save</PrimaryButton>

                <!--                <Transition enter-from-class="opacity-0" leave-to-class="opacity-0" class="transition ease-in-out">-->
                <!--                    <p v-if="form.recentlySuccessful" class="text-sm text-gray-600">Saved.</p>-->
                <!--                </Transition>-->
            </div>
        </form>
    </section>
</template>

