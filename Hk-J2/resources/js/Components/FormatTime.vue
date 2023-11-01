<script setup>

let props = defineProps({
    time:String
})
function formatTime(created_at) {
const now = new Date();
const createdAtDate = new Date(created_at);

// Calculate the time difference in milliseconds
const timeDiff = now - createdAtDate;

// Convert the time difference to minutes
const minutesDiff = Math.floor(timeDiff / (1000 * 60));

if (minutesDiff < 1) {
return 'Just now';
} else if (minutesDiff < 60) {
return `${minutesDiff} minutes ago`;
} else if (minutesDiff < 1440) {
const hoursDiff = Math.floor(minutesDiff / 60);
return `${hoursDiff} hour${hoursDiff > 1 ? 's' : ''} ago`;
} else {
const daysDiff = Math.floor(minutesDiff / 1440);
return `${daysDiff} day${daysDiff > 1 ? 's' : ''} ago`;
}
}
</script>
<template>
    {{ formatTime(props.time) }}
</template>
