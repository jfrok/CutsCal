<template>

    <v-card class="pt-10" max-height="500">
<!--        @acceptFiles="submit"-->
            <drop-zone
                :class="preview.length > 0?'d-none':''"
                :accepted-types="acceptedTypes"
                @previews="(data)=>{preview = data}"
                @acceptFiles="(img)=>{file = img}"
               >
                <div class="dropzone pa-10">
                    <div class="align-self-center">
                        <svg class="mx-auto d-block mb-3" xmlns="http://www.w3.org/2000/svg" width="37" height="36" viewBox="0 0 37 36" fill="none">
                            <path
                                d="M4.49951 35.999C3.39951 35.999 2.45785 35.6074 1.67451 34.824C0.891178 34.0407 0.499512 33.099 0.499512 31.999V3.99902C0.499512 2.89902 0.891178 1.95736 1.67451 1.17402C2.45785 0.39069 3.39951 -0.000976562 4.49951 -0.000976562H32.4995C33.5995 -0.000976562 34.5412 0.39069 35.3245 1.17402C36.1078 1.95736 36.4995 2.89902 36.4995 3.99902V31.999C36.4995 33.099 36.1078 34.0407 35.3245 34.824C34.5412 35.6074 33.5995 35.999 32.4995 35.999H4.49951ZM4.49951 31.999H32.4995V3.99902H4.49951V31.999ZM6.49951 27.999H30.4995L22.9995 17.999L16.9995 25.999L12.4995 19.999L6.49951 27.999Z"
                                fill="#DFDFDF"
                            />
                        </svg>
                        <p class="text-center">Choose file, drag and place</p>
                    </div>
                </div>
                <template #dragActive>

                </template>
            </drop-zone>
        <cropper
            v-if="preview.length > 0"
            class="cropper"
            :stencil-component="$options.components.CircleStencil"
            :src="preview[0].preview"
            ref="cropper"
            image-restriction="stencil"
            :stencil-props="{
					aspectRatio: 9 / 9,
					movable: true,
					resizable: true,
					round: true,
				}"
            @change="change"
        />
        <div class="d-flex justify-space-between align-center pa-20">
            <v-btn @click="submit">Save</v-btn>
            <v-btn @click="$emit('close-dialog',false)">Cancel</v-btn>
        </div>
        <v-progress-linear indeterminate v-if="loading" />
        <v-btn elevation="0" v-if="preview.length > 0" class="btn btn-sm" variant="outlined" color="var(--tertiary)" @click="file = null"> Change </v-btn>
        <k-spacing y="5"></k-spacing>

    </v-card>
</template>
<script>
import { Cropper, CircleStencil } from "vue-advanced-cropper";
import 'vue-advanced-cropper/dist/style.css';
import {router, useForm, usePage} from '@inertiajs/vue3';
import DropZone from "@/Components/DropZone.vue";
export default {
    components: {DropZone,Cropper,CircleStencil},
    props: {
        mustVerifyEmail: {
            type: Boolean,
        },
        status: {
            type: String,
        },
    },
    data() {
        return {
            preview: [],
            loading: false,
            user: usePage().props.auth.user,
            file: [],
            acceptedTypes: ['image/png', 'image/jpeg', 'image/jpg'],
        }
    },
    methods: {
        async getBlob(canvas) {
            console .log('canvas',canvas)
            const blob = await new Promise((resolve) => canvas.toBlob(resolve));
            return blob;
        },
        submit() {
            this.loading = true;
            const { canvas } = this.$refs.cropper.getResult();
            if (canvas) {
                this.getBlob(canvas).then((blob) => {
                    this.file = blob;
                    router.post(
                        route('updateAvatar'),
                        {
                            img: blob,
                        },
                        {
                            onSuccess: () => {
                                this.loading = false;
                                this.$emit('close-dialog', false);
                            },
                        }
                    );
                    console.log('blob', blob);
                }).catch((error) => {
                    this.loading = false;
                    console.log('Error getting blob:', error);
                });

            } else {
                this.loading = false;
                console.log('No canvas result available.');
            }
        }
    },
    emits: ['close-dialog'],
    mounted() {
        this.user = usePage().props.auth.user;
        this.file = '';
    }
}
</script>
<style lang="scss" scoped>
.cropper  .vue-advanced-cropper__stretcher{
    max-width: 500px !important;
    max-height: 500px !important;
}
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
