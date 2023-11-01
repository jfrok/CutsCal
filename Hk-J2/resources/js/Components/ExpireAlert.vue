<template>
    <div>
        <div v-if="isExpired" >
            <v-alert
                variant="outlined"
                type="warning"
                prominent
                border="top"
            >
                <p>Your account has expired. Please renew your subscription.</p>

            </v-alert>
        </div>
        <div v-else class="expiration-message">
            <v-alert
                variant="outlined"
                type="warning"
                prominent
                border="top"
            >
                <p>Your account will expire on {{ expirationDate }}</p>

            </v-alert>
        </div>
        <!-- Rest of your component's template -->
    </div>
</template>

<script setup>
import { ref, computed } from 'vue';

// Retrieve the user's account expiration date from your data source
const expirationDate = ref('2023-06-30'); // Replace with your actual data retrieval logic

// Calculate the remaining time until the expiration date
const remainingTime = computed(() => {
    const now = new Date();
    const expiration = new Date(expirationDate.value);
    const diff = expiration.getTime() - now.getTime();
    return Math.ceil(diff / (1000 * 60)); // Convert milliseconds to minutes
});

// Determine if the account has expired
const isExpired = computed(() => remainingTime.value <= 0);
</script>
