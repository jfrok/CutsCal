<template>

    <v-combobox
        v-model="form.chips"
        :items="items"
        chips
        clearable
        label="Your favorite hobbies"
        multiple
        variant="solo"
    >
        <template v-slot:selection="{ attrs, item, select, selected }">
            <v-chip
                v-bind="attrs"
                :model-value="selected"
                closable
                @click="select"
                @click:close="remove(item)"
            >
                <strong>{{ item }}</strong>&nbsp;
                <span>(interest)</span>
            </v-chip>

        </template>
    </v-combobox>
    <v-btn @click="submit" style="float: right">
        Save
    </v-btn>

</template>
<script>
import {router, useForm} from "@inertiajs/vue3";

export default {
    data () {
        return {
            chips: ['Programming', 'Playing video games', 'Watching movies', 'Sleeping'],
            // items: ['Streaming', 'Eating'],
        }
    },
    setup()
    {
        let form = useForm({
            chips:null
        })
        let submit = async () => {
            await form.post(route('updateProfileSkills'), {
                onSuccess: () => {
                   form.chips = null
                },
            });
        };
        return {
            form,
            submit
        }
    },
    methods: {
        remove (item) {
            this.chips.splice(this.chips.indexOf(item), 1)
        },
    },
};
</script>
