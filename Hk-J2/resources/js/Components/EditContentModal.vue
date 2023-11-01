<script setup>
import {useForm} from "@inertiajs/vue3";
//
let form = useForm({
    title: '',
    dateFrom: '',
    dateTo: '',
})
// // setTimeout(() => {
// //     form.reset();
// // },3000)
// console.log(form.dateFrom)
// let submit = () => {
//     form.post(route('calendar.add'), {
//     });
// }
</script>
<template>
    <div id="EditContentmodal" class="modal fade" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">Edit Content</h4>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form method="post">
                <div class="modal-body p-4">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="mb-3">
                                <label for="field-1" class="form-label">Title</label>
                                <input type="text" v-model="form.title" name="title" id="title" class="form-control" placeholder="John">
                            </div>
                        </div>

                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <div class="mb-3">
                                <label for="field-4" class="form-label">Date from</label>
                                <textarea v-model="form.description" name="description" id="description" class="form-control"></textarea>
                            </div>
                        </div>
                    </div>
<!--                    <div class="row">-->
<!--                        <div class="col-md-12">-->
<!--                            <div class="">-->
<!--                                <label for="field-7" class="form-label">Personal Info</label>-->
<!--                                <textarea class="form-control" id="field-7" placeholder="Write something about yourself"></textarea>-->
<!--                            </div>-->
<!--                        </div>-->
<!--                    </div>-->
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary waves-effect" data-bs-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-info waves-effect waves-light">Save changes</button>
                </div>
                </form>
            </div>

        </div>
    </div>

</template>

