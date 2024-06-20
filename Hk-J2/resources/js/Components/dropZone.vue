<template>
    <div>
        <div class="dropzone" v-bind="drag ?getRootProps():false" v-if="!loading">
            <input type="file" @input="handleUpload()" formenctype="multipart/form-data"
                   v-bind="getInputProps({ multiple: props.multiple })"/>
            <div class="dropzone-content">
                <slot v-if="!isDragActive"></slot>
                <slot v-if="isDragActive" name="dragActive">
                    <div class="pa-15 border-dotted">
                        <h4 class="text-center"> Drop here</h4>
                    </div>
                </slot>
            </div>
            <slot v-if="errorMessage" name="error">
                <div v-if="errorMessage" class="text-primary">{{ errorMessage }}</div>
            </slot>
        </div>
    </div>
</template>
<script setup>
import {watch, reactive, defineProps, defineEmits, onUnmounted, ref} from 'vue';
import {useDropzone} from 'vue3-dropzone';

const props = defineProps({
    drag: {
        type: Boolean,
        default: true,
    },
    multiple: {
        type: Boolean,
        default: false,
    },
    layout: {
        type: String,
        default: undefined,
    },
    acceptedTypes: {
        type: Array,
        default: undefined,
    },
    type: {
        type: String,
        default: undefined,
    },
    loading: {
        type: Boolean,
        default: undefined,
    },
    index: {
        type: Number,
        default: undefined,
    },
    parentData: {
        type: Object,
        default: undefined,
    },
    max: {
        type: Number,
        default: 1,
    },
    maxDuration: {
        type: Number,
        default: 0,
    },
});

const errorMessage = ref('');

let emit = defineEmits(['previews', 'acceptFiles', 'currentType'])
const data = reactive({
    files: new Set(),
});
const allData = ref([])
const multiplyAccord = ref(false)

let filesWithPreview = []
const onDrop = (acceptFiles) => {
    if (acceptFiles.length > 0 && acceptFiles.some(file => props.acceptedTypes.includes(file.type))) {

        if (acceptFiles.length <= props.max) {

            allData.value = acceptFiles

            emit('currentType', acceptFiles[0].type);

            data.value = acceptFiles;
            const uniqueFiles = acceptFiles.filter(file => !data.files.has(file.path));
            filesWithPreview = uniqueFiles.map(file => ({...file, preview: URL.createObjectURL(file), type: file.type}));
            data.files = new Set([...data.files, ...filesWithPreview]);

            emit('previews', filesWithPreview)
            emit('acceptFiles', acceptFiles);
            errorMessage.value = null
        } else {
            errorMessage.value = `You can not add more then (${props.max}) Images.`;
        }
    } else {
        allData.value = null
        errorMessage.value = `Invalid file type. Should be (${props.acceptedTypes}).`;
    }
};

const {getRootProps, getInputProps, isDragActive} = useDropzone({
    onDrop,
    accept: props.acceptedTypes,
    multiple: true
});
watch(() => allData.value, (val) => {
    if (val.length <= props.max - 2) {
        multiplyAccord.value = true
    } else {
        multiplyAccord.value = false
    }
})
const handleUpload = () => {
    // emit('file-upload', e);
    // state.files.push(e);
};


const handleDeleteFiles = () => {
    data.files.forEach(file => URL.revokeObjectURL(file.preview));
    data.files.clear();

    emit('previews', []);
};

watch(() => props.parentData, (newVal) => {
    data.files = new Set(newVal)
    // console.log('Files data changed:', newVal);

});


onUnmounted(() => {
    handleDeleteFiles();

    data.files.forEach(file => URL.revokeObjectURL(file.preview));
});
</script>
