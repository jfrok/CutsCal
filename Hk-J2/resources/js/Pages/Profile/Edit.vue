<template>
    <Head title="Profile"/>

    <div class="row">
        <div class="col-md-12">
            <div class="profile-header">
                <div class="row align-items-center">
                    <div class="col-auto profile-image">
                        <a href="#" @click="avatarDialog = true">
                            <v-avatar v-if="$page.props.auth.user.avatar" alt="User Image"
                                      size="100"
                                      :image="$page.props.auth.user.avatar ?? 'img/non-user-add.png'">

                            </v-avatar>
                            <!--                            <img class="rounded-circle" v-if="$page.props.auth.user.avatar" alt="User Image"-->

                            <!--                                 :src="$page.props.auth.user.avatar ?? 'img/non-user-add.png'"/>-->
                            <div id="imageAvatar" v-else>{{ initials }}</div>
                        </a>
                    </div>
                    <div class="text-center">
                        <v-dialog
                            v-model="avatarDialog"
                            activator="parent"
                            width="600"
                        >
                            <AvatarDialog @close-dialog="avatarDialog = false"/>
                        </v-dialog>
                    </div>
                    <div class="col ms-md-n2 profile-user-info">
                        <h4 class="user-name mb-0">{{ $page.props.auth.user.name }}</h4>
                        <h6 class="text-muted">{{ $page.props.auth.user.job }}</h6>
                        <div class="user-Location"><i class="fas fa-map-marker-alt"></i>
                            {{ $page.props.auth.user.city }}, {{ $page.props.auth.user.address }}
                        </div>
                        <div class="about-text">{{ $page.props.auth.user.description }}</div>
                    </div>
                    <!--                        <div class="col-auto profile-btn">-->
                    <!--                            <a href="" class="btn btn-primary">-->
                    <!--                                Edit-->
                    <!--                            </a>-->
                    <!--                        </div>-->
                </div>
            </div>
            <div class="profile-menu">
                <ul class="nav nav-tabs nav-tabs-solid">
                    <li class="nav-item">
                        <a class="nav-link active" data-bs-toggle="tab" href="#per_details_tab">About</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-bs-toggle="tab" href="#password_tab">Password</a>
                    </li>
                </ul>
            </div>
            <div class="tab-content profile-tab-cont">

                <div class="tab-pane fade show active" id="per_details_tab">

                    <div class="row">
                        <div class="col-lg-9">
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="card-title d-flex justify-content-between">
                                        <span>Personal Details</span>
                                        <!--                                        <a class="edit-link" data-bs-toggle="modal"-->
                                        <!--                                           href="#edit_personal_details"><i-->
                                        <!--                                            class="far fa-edit me-1"></i>Edit</a>-->
                                    </h5>
                                    <div class="row">
                                        <UpdateProfileInformationForm
                                            :must-verify-email="mustVerifyEmail"
                                            :status="status"
                                            class="max-w-xl"
                                        />
                                    </div>
                                    <!--                                        <div class="row">-->
                                    <!--                                            <p class="col-sm-3 text-muted text-sm-end mb-0 mb-sm-3">Mobile</p>-->
                                    <!--                                            <p class="col-sm-9">305-310-5857</p>-->
                                    <!--                                        </div>-->
                                    <!--                                        <div class="row">-->
                                    <!--                                            <p class="col-sm-3 text-muted text-sm-end mb-0">Address</p>-->
                                    <!--                                            <p class="col-sm-9 mb-0">4663 Agriculture Lane,<br>-->
                                    <!--                                                Miami,<br>-->
                                    <!--                                                Florida - 33165,<br>-->
                                    <!--                                                United States.</p>-->
                                    <!--                                        </div>-->
                                </div>
                            </div>
                        </div>

                        <div class="modal custom-modal fade bank-details" id="test" role="dialog">

                        </div>

                        <div class="col-lg-3">

                            <!--                                <div class="card">-->
                            <!--                                    <div class="card-body">-->
                            <!--                                        <h5 class="card-title d-flex justify-content-between">-->
                            <!--                                            <span>Account Status</span>-->
                            <!--                                            <a class="edit-link" href="#"><i class="far fa-edit me-1"></i> Edit</a>-->
                            <!--                                        </h5>-->
                            <!--                                        <button class="btn btn-success" type="button"><i-->
                            <!--                                            class="fe fe-check-verified"></i> Active-->
                            <!--                                        </button>-->
                            <!--                                    </div>-->
                            <!--                                </div>-->


                            <!--                            <div class="card">-->
                            <!--                                <div class="card-body">-->
                            <!--                                    <h5 class="card-title d-flex justify-content-between">-->
                            <!--                                        <span>Skills </span>-->

                            <!--                                        &lt;!&ndash;                                            <a class="edit-link" href="#"><i class="far fa-edit me-1"></i> Edit</a>&ndash;&gt;-->

                            <!--                                    </h5>-->
                            <!--                                    <div style="margin-bottom: 55px">-->
                            <!--                                        <Chip/>-->
                            <!--                                    </div>-->
                            <!--                                    <div class="skill-tags">-->
                            <!--    <span-->
                            <!--        v-for="skill in skills.data"-->
                            <!--        :key="skill.id"-->
                            <!--        class="skill-tag"-->
                            <!--    >-->
                            <!--<v-chip>-->
                            <!--  {{ skill.name }}-->
                            <!--</v-chip>-->
                            <!--        &lt;!&ndash;      <v-icon&ndash;&gt;-->
                            <!--        &lt;!&ndash;          v-if="hoveredSkill === skill.id"&ndash;&gt;-->
                            <!--        &lt;!&ndash;          class="remove-icon"&ndash;&gt;-->
                            <!--        &lt;!&ndash;          @click="removeSkill(skill)"&ndash;&gt;-->
                            <!--        &lt;!&ndash;      >&ndash;&gt;-->
                            <!--          <i @click="removeSkill(skill.id)" class="feather-trash remove-icon"></i>-->
                            <!--        &lt;!&ndash;      </v-icon>&ndash;&gt;-->
                            <!--    </span>-->
                            <!--                                    </div>-->
                            <!--                                </div>-->
                            <!--                            </div>-->

                        </div>
                    </div>

                </div>
                <div id="password_tab" class="tab-pane fade">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Change Password</h5>
                            <div class="row">
                                <div class="col-md-10 col-lg-6">

                                    <UpdatePasswordForm class="form-control"/>
                                    <VerifyEmail v-if="!$page.props.auth.user.email_verified_at"/>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</template>
<script>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import DeleteUserForm from './Partials/DeleteUserForm.vue';
import UpdatePasswordForm from './Partials/UpdatePasswordForm.vue';
import UpdateProfileInformationForm from './Partials/UpdateProfileInformationForm.vue';
import {Head, router, useForm} from '@inertiajs/vue3';
import Chip from "@/Components/Chip.vue";
import {usePage} from '@inertiajs/vue3'
import {useDropzone} from "vue3-dropzone";
import {reactive, watch} from "vue";
import VerifyEmail from "@/Pages/Auth/VerifyEmail.vue";
import AvatarDialog from "@/Components/AvatarDialog.vue";

export default {
    layout: AuthenticatedLayout,
    components: {
        AvatarDialog,
        VerifyEmail,
        Head,
        UpdateProfileInformationForm,
        UpdatePasswordForm,
        DeleteUserForm,
        Chip
    },
    props: {
        authUser: Object,
        skills: Array,
        mustVerifyEmail: {
            type: Boolean,
        },
        status: {
            type: String,
        },
    },
    setup() {
        const {skills} = usePage().props


        const removeSkill = async (skillId) => {
            router.post(route('removeSkill', skillId), {
                preserveScroll: true
            })
        }

        return {
            removeSkill,
            // openDialog
        }
    },
    data: () => ({
        show: false,
        avatarDialog: false,
        numberOfInputs: 0,
        fullName: usePage().props.auth.user.name,
        initials: '',

    }),

    mounted() {
        this.setInitials();
    },
    methods: {
        setInitials() {
            const initials = this.fullName
                .split(' ')
                .map(name => name[0])
                .join('')
                .toUpperCase();

            this.initials = initials;
        }
    },

}
</script>

<style lang="scss" scoped>
.remove-icon {
    margin-left: 4px;
    cursor: pointer;
    display: none;
}

.skill-tag:hover .remove-icon {
    display: inline-block;
}

</style>



