<template>
    <AuthenticatedLayout>
        <div class="row">
            <div class="col-sm-12">
                <div class="card card-table border-r-20 border-secondary-color-2 bg-official-secondary">
                    <div class="card-body">
                        <div class="page-header">
                            <div class="row align-items-center">
                                <div class="col">
                                    <h3 class="page-title">
                                        {{
                                            $page.props.auth.user.lang == 'arabic' ? 'إدارة الايطار' : 'Frame Management'
                                        }}</h3>
                                </div>
                                <div class="col-auto text-end float-end ms-auto download-grp">
                                    <a href="javascript:void(0)" v-if="$page.props.auth.schedule != null" @click="openNewWindow" class="btn btn-primary"><i
                                        class="fas fa-eye"></i></a>
                                </div>
                            </div>
                        </div>
                      <Steppers v-if="$page.props.auth.userRole.includes('schedule-edit')" :frame-token="frameToken" :employers="employers.data" :services="services" :markedEmployees="markedEmployers.data"/>
                </div>
                </div>
            </div>

        </div>

    </AuthenticatedLayout>

</template>
<script>
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import {Link} from "@inertiajs/vue3";
import ReservationTemp from "@/Components/ReservationTemp.vue";
import Steppers from "@/Components/Steppers.vue";

export default {
    components: {
        ReservationTemp,
        AuthenticatedLayout,
        Steppers,
        Link
    },
    props:{
        employers:Object,
        markedEmployers:Object,
        services:Array,
        frameToken:String
    },
    data: () => {
        return {
            current: 1
        }
    },
    methods: {

        setCookie() {
            // Set a cookie
            $cookies.set('r-token',this.frameToken)
        },
        openNewWindow() {

            const url = route('frame.view',this.frameToken);
            const windowFeatures = 'width=800,height=600,menubar=yes,toolbar=yes';
            window.open(url, '_blank', windowFeatures);
        }
    },
    mounted() {
        this.setCookie()    }
}
</script>
<style lang="css">
:root {
    --prm-color: #0381ff;
    --prm-gray: #b1b1b1;
}

/* CSS */
.steps {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 2rem;
    position: relative;
}

.step-button {
    width: 50px;
    height: 50px;
    border-radius: 50%;
    border: none;
    background-color: var(--prm-gray);
    transition: .4s;
}

.step-button[aria-expanded="true"] {
    width: 60px;
    height: 60px;
    background-color: var(--prm-color);
    color: #fff;
}

.done {
    background-color: var(--prm-color);
    color: #fff;
}

.step-item {
    z-index: 10;
    text-align: center;
}

#progress {
    -webkit-appearance: none;
    position: absolute;
    width: 95%;
    z-index: 5;
    height: 10px;
    margin-left: 18px;
    margin-bottom: 18px;
}

/* to customize progress bar */
#progress::-webkit-progress-value {
    background-color: var(--prm-color);
    transition: .5s ease;
}

#progress::-webkit-progress-bar {
    background-color: var(--prm-gray);

}
</style>
