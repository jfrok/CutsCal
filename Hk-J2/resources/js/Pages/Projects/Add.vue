<script setup>
import Test from "@/Components/Test.vue";

import InputError from "@/Components/InputError.vue";
import {reactive, watch} from "vue";
import {router, useForm} from "@inertiajs/vue3";
import DropZoneVue from "@/Components/DropZoneVue.vue";
import InputTage from "@/Components/InputTage.vue";
import {useDropzone} from "vue3-dropzone";

const state = reactive({
    files: [],
});

const {getRootProps, getInputProps, isDragActive, ...rest} = useDropzone({
    onDrop,
    accept: 'image/png, image/jpeg',

});

watch(state, () => {
    console.log('state', state);
});

watch(isDragActive, () => {
     console.log('isDragActive', isDragActive.value, rest);
});

function onDrop(acceptFiles, rejectReasons) {
     console.log(acceptFiles);
     console.log(rejectReasons);
    console.log(getInputProps());
    form.img  = acceptFiles[0];
    state.files = acceptFiles;
}

function handleClickDeleteFile(index) {
    state.files.splice(index, 1);
}

defineProps({errors: Object})

let form = useForm({
    title: '',
    description: '',
    img: '',
    demoUrl: '',
    sourceUrl: '',
})
// setTimeout(() => {
//     form.reset();
// },3000)
let submit = () => {
    form.post(route('project.addOne'), {
        forceFormData: true,
    });
    //  let data = router.restore('title')
};
</script>
<template>
    <!--    <Alert></Alert>-->
    <div class="row">
        <div class="col-sm-12">
            <div class="card">
                <div class="card-body">

                    <!--<inputTage/>-->

                    <form method="post" @submit.prevent="submit">

                        <div class="row">
                            <div class="col-12">
                                <h5 class="form-title"><span>Subject Information</span></h5>
                            </div>
                            <div class="col-12 col-sm-4">
                                <div class="form-group local-forms">
                                    <label>Title <span class="login-danger">*</span></label>
                                    <input type="text" id="title" name="title" v-model="form.title"
                                           class="form-control">
                                    <InputError class="mt-2" :message="errors.title"/>
                                </div>
                            </div>
                            <div class="col-12 col-sm-4">
                                <div class="form-group local-forms">
                                    <label>Description <span class="login-danger">*</span></label>
                                    <textarea type="text" id="description" name="description" v-model="form.description"
                                              class="form-control"></textarea>
                                    <InputError class="mt-2" :message="errors.description"/>
                                </div>
                            </div>

                            <div class="col-12 col-sm-4">

                                <!--                                    <input type="file" id="img" @input="form.img = $event.target.files[0]" class="form-control">-->
                                <!--                                    <DropZoneInfo :imgInput="form.img"/>-->
                                <div class="col-lg-12 col-md-12">
                                    <div class="form-group">
                                        <!--                                        <label>Image</label>-->
                                        <!--                                        <div class="change-photo-btn">-->
                                        <!--                                            <div>-->
                                        <!--                                                <p>Add Image</p>-->
                                        <!--                                            </div>-->
                                        <!--                                            <input type="file" id="img" @input="form.img = $event.target.files[0]" class="upload">-->
                                        <!--                                        </div>-->

                                        <div v-if="state.files.length > 0" class="files">
                                            <div class="file-item" v-for="(file, index) in state.files"
                                                 :key="index">
                                                <span>{{ file.name }}</span>
                                                <span class="delete-file" @click="handleClickDeleteFile(index)"
                                                >Delete</span
                                                >
                                            </div>
                                        </div>

                                        <div v-else class="dropzone" v-bind="getRootProps()">
                                            <div
                                                class="border"
                                                :class="{
          isDragActive,
        }"
                                            >
                                                <input type="file" accept="image/png, image/jpeg" @input="form.img = $event.target.files[0]"
                                                       v-bind="getInputProps()"/>
                                                <p v-if="isDragActive">Drop the files here ...</p>
                                                <p v-else>Drag and drop files here, or Click to select files</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <InputError class="mt-2" :message="errors.img"/>
                            </div>

                            <v-expansion-panels variant="inset" class="my-4" >
                                <v-expansion-panel style="border-radius: 20px 30px">
                                    <v-expansion-panel-title>
                                        <i class="feather-eye"></i>
                                    </v-expansion-panel-title>
                                    <v-expansion-panel-text>
                                        <v-text-field
                                            type="url"
                                            clearable
                                            variant="outlined"
                                            hide-details="auto"
                                            label="demo (Url)"
                                            v-model="form.demoUrl"
                                        ></v-text-field>
                                    </v-expansion-panel-text>
                                </v-expansion-panel>
                                <v-expansion-panel style="border-radius: 0px 0px 20px 30px">
                                    <v-expansion-panel-title>
                                        <i class="feather-github"></i>
                                    </v-expansion-panel-title>
                                    <v-expansion-panel-text>
                                        <v-text-field
                                            type="url"
                                            clearable
                                            v-model="form.sourceUrl"
                                            variant="outlined"
                                            hide-details="auto"
                                            label="source (Url)"
                                        ></v-text-field>
                                    </v-expansion-panel-text>
                                </v-expansion-panel>
                            </v-expansion-panels>

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
    layout: AuthenticatedLayout,
    data () {
        return {
            model: 'Leider',
            inputs: [{
                name: '',
                party: ''
            }]
        }
    },
    methods: {
        add () {
            this.inputs.push({
                name: '',
                party: ''
            })
            console.log(this.inputs)
        },

        remove (index) {
            this.inputs.splice(index, 1)
        },

        addCandidate () {
            axios
                .post('/candidates', {
                    my_prop_name: JSON.stringify(this.inputs)
                })
                .then(response => {})
                .catch(error => {})
        }
    }
}

</script>

<style lang="scss" scoped>
.dropzone {
    width: 400px;
    height: 200px;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    row-gap: 16px;
    border: 2px dashed #3d5ee1;
    background-color: #fff;
    transition: 0.3s ease all;

    label {
        padding: 8px 12px;
        color: #fff;
        background-color: #3d5ee1;
        transition: 0.3s ease all;
    }

    input {
        display: none;
    }
}

.active-dropzone {
    color: #fff;
    border-color: #fff;
    background-color: #3d5ee1;

    label {
        background-color: #fff;
        color: #3d5ee1;
    }
}

.dropzone,
.files {
    width: 100%;
    max-width: 300px;
    margin: 0 auto;
    padding: 10px;
    border-radius: 8px;
    box-shadow: rgba(60, 64, 67, 0.3) 0px 1px 2px 0px,
    rgba(60, 64, 67, 0.15) 0px 1px 3px 1px;
    font-size: 12px;
    line-height: 1.5;
}

.border {
    border: 2px dashed #ccc;
    border-radius: 8px;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 20px;
    transition: all 0.3s ease;
    background: #5f99f3;

    &.isDragActive {
        border: 2px dashed #ffb300;
        background: rgb(255 167 18 / 20%);
    }
}

.file-item {
    border-radius: 8px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    background: rgb(255 167 18 / 20%);
    padding: 7px;
    padding-left: 15px;
    margin-top: 10px;

    &:first-child {
        margin-top: 0;
    }

    .delete-file {
        background: red;
        color: #fff;
        padding: 5px 10px;
        border-radius: 8px;
        cursor: pointer;
    }
}
</style>
