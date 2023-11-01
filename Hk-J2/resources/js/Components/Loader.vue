<template>
    <div style="position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); z-index: 9999">
        <v-progress-circular
            v-if="show"
            :size="50"
            :color="color"
            indeterminate
        ></v-progress-circular>
    </div>
</template>

<script setup>
import { defineProps } from 'vue';

const props = defineProps({
    show: Boolean,
    color: String,
});
</script>
