<script setup>
import InputError from "@/Components/InputError.vue";
import {useForm} from "@inertiajs/vue3";
let props = defineProps(
    {
        slectedContent: Array,
        errors: Object,
    })

let form = useForm({
    title: props.slectedContent.title,
    description: props.slectedContent.description,
    // img: '',
    //project_id:props.pId.id
})
let save = () => {
    form.post(route('content.save',props.slectedContent.id))
}
</script>

<template>
    <div class="row">
        <div class="col-sm-12">
            <div class="card">
                <div class="card-body">
                    <form method="post" @submit.prevent="save">
                        <div class="row">
                            <div class="col-12">
                                <h5 class="form-title"><span>Add Title </span></h5>
                            </div>

                            <div class="col-12 col-sm-4">
                                <div class="form-group local-forms">
                                    <label>Title <span class="login-danger">*</span></label>
                                    <input type="text" name="title" v-model="form.title" class="form-control">
                                    <InputError class="mt-2" :message="errors.title" />
                                </div>
                            </div>
                            <div class="col-12 col-sm-4">
                                <div class="form-group local-forms">
                                    <label>Description <span class="login-danger">*</span></label>
                                    <textarea type="text"  id="description" v-model="form.description" name="description"  class="form-control"></textarea>
                                    <InputError class="mt-2" :message="errors.description" />

                                    <!--                                    <InputError class="mt-2" :message="errors.description" />-->
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
</template>
<script>
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
export default {
    layout:AuthenticatedLayout,
}

</script>
