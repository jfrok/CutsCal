<script>
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import {Head, router, useForm} from "@inertiajs/vue3";
import {Link} from "@inertiajs/vue3";
import draggable from "vuedraggable";
import format from "@popperjs/core/lib/utils/format";
import EditContentModal from "@/Components/EditContentModal.vue";
import {ref} from "vue";

const showSpinner = ref(false);

function alert(mesg) {
    toastr.success(mesg)
}

function alertError(mesg) {
    toastr.error(mesg)
}

export default {
    layout: AuthenticatedLayout,
    props: {
        // show: Array,
        // contents: Array,
    },
    components: {EditContentModal, Head, Link, draggable},
    methods: {
        goBack() {
            // Go back one step in the browser history
            window.history.length > 1 ? this.$inertia.visit(window.history.back()) : this.$inertia.visit('/');
        },
    },
}

</script>
<template>
    <Head title="Show"/>
    <div v-if="$page.props.ziggy.flash.message">
        {{ alert($page.props.ziggy.flash.message) }}
    </div>
    <div v-if="$page.props.ziggy.flash.error">
        {{ alertError($page.props.ziggy.flash.error) }}
    </div>
    <div class="content container-fluid">
        <!--        <Loader :show="showSpinner" color="blue"  />-->

        <div class="blog-view">
            <div class="blog-single-post">
                <a href="javascript:void(0)" @click="goBack()" class="back-btn"><i class="feather-chevron-left"></i>
                    Back</a>
                <div class="blog-image">
                    <a href="javascript:void(0);">
                        <img alt=""
                             :src="show.path"
                             class="img-fluid" style="height:430px"></a>
                </div>
            </div>
        </div>

        <div class="student-group-form">
            <div class="row">
                <div class="col-lg-3 col-md-6">
                    <div class="form-group">
                        <input type="text" class="form-control" placeholder="Search by ID ...">
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="form-group">
                        <input type="text" class="form-control" placeholder="Search by Name ...">
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="form-group">
                        <input type="text" class="form-control" placeholder="Search by Class ...">
                    </div>
                </div>
                <div class="col-lg-2">
                    <div class="search-student-btn">
                        <button type="btn" class="btn btn-primary">Search</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-12">
                <div class="card card-table">
                    <div class="card-body">

                        <div class="page-header">
                            <div class="row align-items-center">
                                <div class="col">
                                    <h3 class="page-title">Content</h3>
                                </div>
                                <div class="col-auto text-end float-end ms-auto download-grp">
                                    <Link :href="route('content.addFoto',show.id)" class="btn btn-outline-primary me-2">
                                        <i class="fas fa-image"></i></Link>
                                    <Link :href="route('content.add',show.id)" class="btn btn-primary"><i
                                        class="fas fa-plus"></i></Link>
                                </div>
                            </div>
                        </div>

                        <div class="table-responsive">
                            <!--                            <form @submit.prevent="groupDelete">-->
                            <v-alert v-if="contents.length < 1"
                                     type="info"
                                     title="No data founded"
                                     text="There are is no data"
                                     variant="tonal"
                            ></v-alert>
                            <table v-else
                                   class="table border-0 star-student table-hover table-center mb-0 datatable table-striped">
                                <thead class="student-thread blue-background-class">
                                <tr>
                                    <th>
                                        <div class="form-check check-tables">
                                            <input class="form-check-input" v-model="groupDeleteForm.checkIfAllSelected"
                                                   @change="selectAll" id="checkAll" type="checkbox"></div>
                                    </th>
                                    <th>Type</th>
                                    <th>Title</th>
                                    <th>Description</th>
                                    <th>Path</th>
                                    <th class="text-end">Action</th>
                                </tr>
                                </thead>

                                <tbody id="sortable">

                                <tr v-for="content in contents"
                                    :key="content.id">

                                    <td>
                                        <input type="hidden" id="contentIds" name="contentIds[]" :value="content.id">
                                        <div class="form-check check-tables">
                                            <!--                                            <input class="form-check-input" id="cIds" name="cIds" v-model="groupDeleteForm.cIds"  type="checkbox" :value="content.id" @change="event => updateSelectedContentIds(event.target.checked, content.id)">                                        </div>-->
                                            <input class="form-check-input" id="cIds" name="cIds"
                                                   v-model="groupDeleteForm.selectedContentIds" type="checkbox"
                                                   :value="content.id"
                                                   @change="event => updateSelectedContentIds(event.target.checked, content.id)">
                                            <!--                                            <input type="text" v-model="groupDeleteForm.allContentIds">-->
                                        </div>
                                    </td>
                                    <td>{{ content.type }}</td>
                                    <td>{{ content.title }}</td>
                                    <td>
                                        <h2>
                                            <a>{{ content.description }}</a>
                                        </h2>
                                    </td>
                                    <td>{{ content.path }}</td>
                                    <td class="text-end">
                                        <div class="actions">
                                            <!--                                            <a href="javascript:;" class="btn btn-sm bg-success-light me-2">-->
                                            <!--                                                <i class="feather-eye"></i>-->
                                            <!--                                            </a>-->
                                            <Link :href="route('content.edit',content.id)"
                                                  class="btn btn-sm bg-danger-light">
                                                <i class="feather-edit"></i>
                                            </Link>
                                            <div class="up-come-headerS"><a class="btn btn-sm bg-danger-light"
                                                                            type="button"
                                                                            @click="destroy(content.id)"><span><i
                                                class="feather-trash"></i></span></a></div>

                                        </div>
                                    </td>
                                </tr>

                                </tbody>

                            </table>
                            <button v-if="contents.length > 1" class="btn btn-danger mt-5" @click="groupDelete"><span><i
                                class="feather-trash-2"></i></span></button>

                            <!--                            </form>-->
                        </div>
                    </div>
                </div>
            </div>
        </div>


    </div>

</template>
<script setup>
import {router, useForm} from "@inertiajs/vue3";
import {allCids} from "@/Pages/Content/allCids";
import Loader from "@/Components/Loader.vue";

let props = defineProps({
    show: Array,
    contents: Array,
})
$(function () {
    $("#sortable").sortable({
        placeholder: "ui-state-highlight",
        update: function () {
            let contentIds = [];
            $('input[name="contentIds[]"]').each(function () {
                contentIds.push($(this).val());
            });
            // Get request to save sort
            $.get('/projects/content/sort', {contentIds: contentIds});
        }
    });

});

let selectedContentIds = [];

function updateSelectedContentIds(checked, contentId) {
    if (checked) {
        selectedContentIds.push(contentId);
        console.log(selectedContentIds)
    } else {
        selectedContentIds = selectedContentIds.filter(id => id !== contentId);
    }
}

function selectAll(event) {
    const isChecked = event.target.checked;

    if (isChecked) {
        $('.form-check-input').each(function () {
            $(this).prop('checked', true);
            // const contentId = parseInt($(this).val());
            // if (!selectedContentIds.includes(contentId)) {
            //     selectedContentIds.push(contentId);
            // }
        });
    } else {
        $('.form-check-input').each(function () {
            $(this).prop('checked', false);
        });
        // selectedContentIds = [];
    }
}

let save = () => {

    const cId = document.getElementById('cId').value

    form.post(route('content.save', cId), {
        preserveScroll: true

    })
    // $('#EditContentmodal').modal('show');
}
let groupDeleteForm = useForm({
    checkIfAllSelected: Boolean,
    pId: props.show.id,
    selectedContentIds: selectedContentIds,
});

let groupDelete = () => {
    groupDeleteForm.post(route('content.groupDelete'), {
        preserveScroll: true,
        onStart: () => {
            showSpinner.value = true;
        },
        onFinish: () => {
            showSpinner.value = false;
        },
    })
}

const destroy = (cId) => {
    Swal.fire({
        title: 'Are you sure?',
        text: "You won't be able to revert this!",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Yes, delete it!'
    }).then((result) => {
        if (result.isConfirmed) {
            router.post(route('content.delete', cId))
            Swal.fire(
                'Deleted!',
                'Your file has been deleted.',
                'success'
            )
        }
    })
}
</script>
