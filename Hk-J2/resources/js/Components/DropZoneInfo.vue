<template>
    <div class="home">
<!--        <h1>DropZone</h1>-->
        <label>Image <span class="login-danger">*</span></label>
        <DropZone :imgInput="imgInput" @drop.prevent="drop" @change="selectedFile" />
        <span class="file-info">File: {{ dropzoneFile.name }}</span>
    </div>
</template>

<script>
// @ is an alias to /src
import DropZone from "@/Components/DropZone-old.vue";
import { ref } from "vue";

export default {
    name: "Home",
    props:{
        imgInput:File
    },
    components: {
        DropZone,
    },
    setup() {
        let dropzoneFile = ref("");

        const drop = (e) => {
            dropzoneFile.value = e.dataTransfer.files[0];
        };

        const selectedFile = () => {
            dropzoneFile.value = document.querySelector(".dropzoneFile").files[0];
        };

        return { dropzoneFile, drop, selectedFile };
    },
};
</script>

<style lang="scss" scoped>

    .file-info {
        margin-top: 32px;
    }

</style>
