<template>
    <div class="text-center">
    <v-container>
        <v-row justify="center">
            <v-col cols="8">
                <v-container class="max-width">

                    <ul class="pagination"  >

                        <li class="page-item" v-for="(link,index) in links" :key="index">
                            <Link
                                :href="link.url"
                                  v-html="link.label"
                                  class="page-link"
                            >
                            </Link>
                        </li>
                    </ul>
                </v-container>
            </v-col>
        </v-row>
    </v-container>
    </div>
<!--        <div class="text-center">-->
<!--            <v-container>-->
<!--                <v-row justify="center">-->
<!--                    <v-col cols="8">-->
<!--                        <v-container class="max-width">-->
<!--                            <v-pagination-->
<!--                                v-model="page"-->
<!--                                class="my-4"-->
<!--                                :length="15"-->
<!--                            ></v-pagination>-->
<!--                        </v-container>-->
<!--                    </v-col>-->
<!--                </v-row>-->
<!--            </v-container>-->
<!--        </div>-->

</template>
<script setup>
import {Link} from "@inertiajs/vue3";
defineProps({links:Array})
</script>
