<template>
    <AuthenticatedLayout>
        <div class="row">
            <div class="col-sm-12">
                <div class="card">
                    <div class="card-body">
                        <form method="post" @submit.prevent="add">
                            <div class="row">
                                <div class="col-12">
                                    <h5 class="form-title"><span>Add Title</span></h5>
                                </div>

                                <div class="col-12 col-sm-4">
                                    <div class="form-group local-forms">
                                        <label>Title <span class="login-danger">*</span></label>
                                        <input type="text" name="title" v-model="form.title" class="form-control">
                                        <InputError class="mt-2" :message="errors.title" />

                                        <input type="hidden" v-model="form.project_id" class="form-control">
                                    </div>
                                </div>
                                <div class="col-12 col-sm-4">
                                    <div class="form-group local-forms">
                                        <label>Description <span class="login-danger">*</span></label>
                                        <textarea type="text" id="description" v-model="form.description" name="description" class="form-control"></textarea>
                                        <InputError class="mt-2" :message="errors.description" />
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="student-submit">
                                        <button type="submit" class="btn btn-primary">Submit</button>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </AuthenticatedLayout>
</template>

<script setup>
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import InputError from "@/Components/InputError.vue";
import { useForm } from "@inertiajs/vue3";
import { defineProps } from "vue";

const props = defineProps({
    pId: Object,
    errors: Object,
});

const form = useForm({
    title: "",
    description: "",
    project_id: props.pId.id,
});

const add = () => {
    form.post(route("content.create", props.pId.id));
};
</script>
