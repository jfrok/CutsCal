<template>
    <v-card>
        <v-card-title>
            <span class="text-h5">Details: {{ orderData.name }}</span>
        </v-card-title>
        <v-card-text>

            <v-stepper
                v-model="step"
                :items="items"
                hide-actions
                editable
            >
                <template v-slot:item.1>
                    <h3 class="text-h6">Order</h3>

                    <br>
                    <!--                    {{ orderData }}-->
                    <v-sheet border style="box-shadow: unset">
                        <v-table>
                            <thead>
                            <tr>
                                <th>Barber</th>
                                <th class="text-end">Services</th>
                                <!--                                <th>Price</th>-->
                                <!--                                <th>Status</th>-->
                            </tr>
                            </thead>

                            <tbody>
                            <tr>
                                <td v-text="orderData.user_name"></td>
                                <!--                                <td class="text-end">hii</td>-->
                                <td class="text-end">
                                    <div v-for="item in orderData.service" class="p-1">
                                        <v-chip>{{ item.name }}</v-chip>
                                    </div>
                                </td>

                                <!--                                <td  v-text="orderData.price"></td>-->
                                <!--                                <td  v-text="orderData.status"></td>-->
                            </tr>

                            <!--                            <tr>-->
                            <!--                                <th>Total</th>-->
                            <!--                                <th></th>-->
                            <!--                                <th class="text-end">-->
                            <!--&lt;!&ndash;                                    ${{ subtotal }}&ndash;&gt;-->
                            <!--                                </th>-->
                            <!--                            </tr>-->
                            </tbody>
                        </v-table>
                    </v-sheet>
                </template>

                <template v-slot:item.2>
                    <h3 class="text-h6">Confirm</h3>
<!--{{orderData.service}}-->
                    <br>

                    <v-sheet border>
                        <v-table>
                            <thead>
                            <tr>
                                <th>Services</th>
                                <th class="text-end">Note</th>
                                <th class="text-end">Price</th>
                            </tr>
                            </thead>

                            <tbody>
                            <tr v-for="(item, index) in orderData.service" :key="index">
                                <td v-text="item.name"></td>
                                <td class="text-end" v-text="orderData.service.length"></td>
                                <td class="text-end" v-text="item.price"></td>
                            </tr>

                            <tr>
                                <th>Total</th>
                                <th></th>
                                <th class="text-end">
                                    ${{ total }}
                                </th>
                            </tr>
                            </tbody>
                        </v-table>
                    </v-sheet>
                </template>
<!--                <template v-slot:item.3>-->
<!--                    <h3 class="text-h6">Services</h3>-->

<!--                    <br>-->
<!--                    <v-radio-group v-model="shipping" label="Delivery Method">-->
<!--                        <v-radio value="5" v-for="item in orderData.service" :label="item.name"/>-->
<!--                    </v-radio-group>-->
<!--                </template>-->
            </v-stepper>
        </v-card-text>
        <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn
                color="blue-darken-1"
                variant="text"
                @click="closeDialog"
            >
                Close
            </v-btn>
            <v-btn
                color="blue-darken-1"
                variant="text"
            >
                Save
            </v-btn>
        </v-card-actions>
    </v-card>
</template>
<script>
export default {
    props: {
        orderData: Array
    },
    data: () => ({

        shipping: 0,
        step: 1,
        items: [
            'Review Order',
            'invoice',
        ],
        products: [
            {
                name: 'Product 1',
                price: 10,
                quantity: 2,
            },
            {
                name: 'Product 2',
                price: 15,
                quantity: 10,
            },
        ],
    }),
methods: {
    closeDialog() {
        this.$emit('close-dialog', false);
    },
},
    // setup(){
    //     const emit = defineEmits(['close-dialog']);
    //     // emit('close-dialog', false);
    //
    //     return {emit}
    // },
    computed: {
        subtotal() {
            return this.products.reduce((acc, product) => acc + product.quantity * product.price, 0)
        },
        total() {
            return this.orderData.service.reduce((sum, service) => sum + service.price, 0);
        }
    },
}
</script>
<style>
.v-stepper.v-sheet {
    box-shadow: unset;
    border-radius: 4px;
    overflow: hidden;
}
</style>
