<template>
    <ul>
        <li v-for="item in items" :key="item.text">
      <span @click="toggle(item)" :class="{ caret: item.children, 'caret-down': item.expanded }">
        {{ item.text }}
      </span>
            <NestedList :items="item.children" v-if="item.children && item.expanded" />
        </li>
    </ul>
</template>

<script>
export default {
    data() {
        return {
            items: [
                {
                    text: 'Beverages',
                    children: [
                        { text: 'Water' },
                        { text: 'Coffee' },
                        {
                            text: 'Tea',
                            children: [
                                { text: 'Black Tea' },
                                { text: 'White Tea' },
                                {
                                    text: 'Green Tea',
                                    children: [
                                        { text: 'Sencha' },
                                        { text: 'Gyokuro' },
                                        { text: 'Matcha' },
                                        { text: 'Pi Lo Chun' },
                                    ],
                                },
                            ],
                        },
                    ],
                },
            ],
        };
    },
    methods: {
        toggle(item) {
            if (item.children) {
                item.expanded = !item.expanded;
            }
        },
    },
};
</script>

<style>
.caret {
    cursor: pointer;
    user-select: none;
}

.caret-down::before {
    content: '\25BF';
    display: inline-block;
    transform: rotate(90deg);
}
</style>
