<script setup lang="ts">
import { reactive, watch } from 'vue';
import { useDropzone } from 'vue3-dropzone';

defineProps({
    img: Object
})
const state = reactive({
    files: [],
});

const { getRootProps, getInputProps, isDragActive, ...rest } = useDropzone({
    onDrop,
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
    state.files = acceptFiles;
}

function handleClickDeleteFile(index) {
    state.files.splice(index, 1);
}
</script>
<template>
    <div>
        <div v-if="state.files.length > 0" class="files">
            <div class="file-item" v-for="(file, index) in state.files" :key="index">
                <span>{{ file.name }}</span>
                <span class="delete-file" @click="handleClickDeleteFile(index)">Delete</span>
            </div>
        </div>
        <div v-else class="dropzone" v-bind="getRootProps()">
            <div class="border" :class="{ isDragActive }">
<!--                <input v-bind="getInputProps({ multiple: true })" />-->
                <input type="file" @input="img = $event.target.files[0]"
                       v-bind="getInputProps({ multiple: true })"/>
                <p v-if="isDragActive">Drop the files here ...</p>
                <p v-else>Drag and drop images</p>
            </div>
        </div>
    </div>
</template>

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
