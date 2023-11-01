<template>

        <v-card>
            <v-card-text>
                <div class="bank-inner-details">
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
                            <input type="file"
                                   accept=".jpeg,.png,.jpg,.gif"
                                   @input="submit"
                                   formenctype="multipart/form-data"
                                   v-bind="getInputProps()"/>
                            <p v-if="isDragActive">Drop the files here ...</p>
                            <p v-else>Drag and drop files here, or Click to select files</p>
                        </div>
                    </div>
                </div>
            </v-card-text>
            <v-card-actions>
                <v-btn color="primary" block @click="$emit('close-dialog',false)">Close Dialog</v-btn>
            </v-card-actions>
        </v-card>
</template>
<script setup>
import { useForm, usePage } from '@inertiajs/vue3';
import {reactive, ref, watch} from "vue";
import {useDropzone} from "vue3-dropzone";

const props = defineProps({
    mustVerifyEmail: {
        type: Boolean,
    },
    status: {
        type: String,
    },
});

const user = usePage().props.auth.user;

const form = useForm({
    name: user.name,
    email: user.email,
    job: user.job,
    city: user.city,
    address: user.address,
    description: user.description,
    img:''
});

const state = reactive({
    files: [],
});

const {getRootProps, getInputProps, isDragActive, ...rest} = useDropzone({
    onDrop,
});

watch(state, () => {
    submit(state.files[0])

    console.log('state', state.files[0]);
});

watch(isDragActive, () => {
    // console.log('isDragActive', isDragActive.value, rest);
});

function onDrop(acceptFiles, rejectReasons) {

    form.img = acceptFiles[0];
    state.files = acceptFiles;
}

function handleClickDeleteFile(index) {
    state.files.splice(index, 1);
}

let submit = (e) => {
    form.img =  state.files ? e :e.target.files[0]
    form.post(route('updateProfile'),{
        onSuccess: () =>{
            emit('close-dialog',false)
            handleClickDeleteFile(0)
        }
    })
}


const emit = defineEmits(['close-dialog']);
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
