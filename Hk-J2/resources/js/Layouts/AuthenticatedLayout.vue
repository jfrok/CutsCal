<script setup>
import {computed, onMounted, ref} from 'vue';
import {Link, router, usePage} from '@inertiajs/vue3';
import FormatTime from "@/Components/FormatTime.vue";
import {useToast} from "vue-toastification";
import ShopSchedule from "@/Components/ShopSchedule.vue";
import {scheduleDialog} from "@/Pages/Ref/scheduleDialog";
const showingNavigationDropdown = ref(false);
const toast = useToast();
const fullName = ref(usePage().props.auth.user.name);
const initials = ref('');

const openScheduleDialog = () => {
    return  scheduleDialog.value = true

}
function isMobile() {
    if(/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)) {
        return true
    } else {
        return false
    }
}
const t = isMobile()
console.log(t)
function setInitials() {
    const names = fullName.value.split(' ');
    initials.value = names.map(name => name[0]).join('').toUpperCase();
}

const notifications = ref(usePage().props.auth.notifications);

const clearNotifications = (notificationId = null) => {
    const url = notificationId ? route('clearNotifications', {notificationId}) : route('clearNotifications');

    router.post(url, {
        onSuccess: () => {
            if (notificationId) {
                // Remove the single notification by ID
                notifications.value = notifications.value.filter(
                    (notification) => notification.id !== notificationId
                );
            } else {
                // Remove all notifications
                notifications.value = [];
            }
        },
    });
};
const scheduleData = usePage().props.auth.schedule;
// console.log(usePage().props.auth.schedule)
const days = ref([
    {id: 0, label: 'Sunday', openingTime: null, closingTime: null},
    {id: 1, label: 'Monday', openingTime: null, closingTime: null},
    {id: 2, label: 'Tuesday', openingTime: null, closingTime: null},
    {id: 3, label: 'Wednesday', openingTime: null, closingTime: null},
    {id: 4, label: 'Thursday', openingTime: null, closingTime: null},
    {id: 5, label: 'Friday', openingTime: null, closingTime: null},
    {id: 6, label: 'Saturday', openingTime: null, closingTime: null},
]);

const selectedDays = ref([]);

const submitSchedule = () => {
    const selectedDaysData = days.value.filter(day => selectedDays.value.includes(day.id));
    scheduleDialog.value = false
    router.post(route('store.schedule'), {
        days: selectedDaysData,

    });
};
// function showToastSuccess(message){
//     toast.success(message);
// }
// function warning(mesg) {
//     toastr.warning(mesg)
// }
// function error(mesg) {
//     toastr.error(mesg)
// }
</script>
<template>
    <!--    <ExpireAlert />-->
    <!--    <div v-if="$page.props.ziggy.flash.message">-->
    <!--        {{ showToastSuccess($page.props.ziggy.flash.message) }}-->
    <!--    </div>-->
    <!--    <div v-if="$page.props.ziggy.flash.warning">-->
    <!--        {{ warning($page.props.ziggy.flash.warning) }}-->
    <!--    </div>-->
    <!--    <div v-if="$page.props.ziggy.flash.error">-->
    <!--        {{ error($page.props.ziggy.flash.error) }}-->
    <!--    </div>-->
    <div>
        <div class="main-wrapper">
            <div class="header">
                <div class="header-left">
                    <Link v-if="$page.props.auth.user"
                          :href="route('dashboard')" class="logo">
<div class="logo">

    <img src="/images/logo/fulllogo.png" alt="Logo" class="logo"  >
</div>
                        <!--                        <h6><img src="/images/logo/fulllogo.png" alt="Logo" class="logo"  ></h6>-->
                    </Link>
                                        <a v-if="$page.props.auth.user"
                                           :href="route('dashboard')" class="logo logo-small">
                                            <img src="/images/logo/fulllogo.png" alt="Logo" width="30" height="30">
                                        </a>
                </div>
                <div class="menu-toggle">
                    <a href="javascript:void(0);" id="toggle_btn">
                        <i class="fas fa-bars"></i>
                    </a>
                </div>
                <!--                <div class="top-nav-search">-->
                <!--                    <form>-->
                <!--                        <input type="text" class="form-control" placeholder="Search here">-->
                <!--                        <button class="btn" type="submit"><i class="fas fa-search"></i></button>-->
                <!--                    </form>-->
                <!--                </div>-->
                <a class="mobile_btn" id="mobile_btn" onclick="">
                    <i class="fas fa-bars"></i>
                </a>
                <ul class="nav user-menu">
                    <!--                    <select @change="changeLanguage(this.value)">-->
                    <!--                        <option value="en">English</option>-->
                    <!--                        <option value="ar">العربية</option>-->
                    <!--                    </select>-->

                    <li class="nav-item dropdown noti-dropdown me-2">

                        <a href="#" class="dropdown-toggle nav-link header-nav-list" data-bs-toggle="dropdown">
                            <!--                            <img src="assets/img/icons/header-icon-05.svg" alt="">-->
                            <span class="notification-badge" v-if="notifications.length > 0">{{
                                    notifications.length
                                }}</span>

                            <i class="feather-bell"></i>
                        </a>
                        <div class="dropdown-menu notifications">
                            <div class="topnav-dropdown-header">
                                <span class="notification-title">Notifications</span>
                                <!--                                <a href="javascript:void(0)" methods="post" @click="clearNotifications()"-->
                                <!--                                   class="clear-noti"> Clear All </a>-->
                            </div>
                            <div class="noti-content" v-if="notifications.length > 0">
                                <ul class="notification-list">

                                    <li class="notification-message" v-for="notification in notifications"
                                        :key="notification.id">
                                        <a href="#">
                                            <div class="media d-flex">
          <span class="avatar avatar-sm flex-shrink-0">
            <img class="avatar-img rounded-circle" alt="User Image" src="https://i.postimg.cc/c1FQY4PG/icononly-nobuffer.png">
          </span>
                                                <div class="media-body flex-grow-1">
                                                    <p class="noti-details">
                                                        <span class="noti-title">{{ notification.title }}</span> has
                                                        approved
                                                        <span class="noti-title">{{ notification.message }}</span>
                                                    </p>
                                                    <p class="noti-time">
              <span class="notification-time">
                <FormatTime :time="notification.created_at"/>
              </span>
                                                        <!--                                                        <button class="clear-button" @click="clearNotifications(notification.id)">Clear</button>-->
                                                    </p>
                                                </div>
                                            </div>
                                        </a>

                                    </li>
                                </ul>
                            </div>

                            <v-alert v-else
                                     color="#2A3B4D"
                                     theme="dark"
                                     prominent
                            >
                                You have no notification
                            </v-alert>
                        </div>
                    </li>
                    <li class="nav-item"
                        v-if="$page.props.auth.userRole.includes('schedule-edit')">
                        <v-btn @click="openScheduleDialog"
                           class="dropdown-toggle nav-link header-nav-list ">
                            <!--                            <img src="assets/img/icons/header-icon-05.svg" alt="">-->
                            <!--                            <span class="notification-badge">2</span>-->
                            <i class="feather-calendar"/>
                        </v-btn>
                    </li>
                    <!--                    <li class="nav-item zoom-screen me-2">-->
                    <!--                        <a href="#" class="nav-link header-nav-list win-maximize">-->
                    <!--&lt;!&ndash;                            <img src="assets/img/icons/header-icon-04.svg" alt="">&ndash;&gt;-->
                    <!--                        </a>-->
                    <!--                    </li>-->
<!--                    <a href="#" @click="openScheduleDialog"-->
<!--                       class="dropdown-toggle nav-link header-nav-list " data-bs-toggle="dropdown">-->
<!--                        &lt;!&ndash;                            <img src="assets/img/icons/header-icon-05.svg" alt="">&ndash;&gt;-->
<!--                        &lt;!&ndash;                            <span class="notification-badge">2</span>&ndash;&gt;-->
<!--                        <i class="feather-calendar"/>-->
<!--                    </a>-->
                    <li class="nav-item dropdown has-arrow new-user-menus">
                        <a href="#" class="dropdown-toggle nav-link" data-bs-toggle="dropdown">
                        <span class="user-img">

                            <img alt="User Image" class="rounded-circle" v-if="$page.props.auth.user.avatar"
                                 :src="$page.props.auth.user.avatar"/>
                                  <div id="profileImage" v-else>{{ initials }}</div>
                            <!--<span id="fullName">{{ fullName  }}</span>-->
                            <!--                            <img class="rounded-circle" src="assets/img/profiles/avatar-01.jpg" width="31"-->
                            <!--                                 alt="Soeng Souy">-->
                            <div class="user-text">
                                <h6>{{ $page.props.auth.user.name }}</h6>
                                <p class="text-muted mb-0">{{ $page.props.auth.user.job }}</p>
                            </div>
                        </span>
                        </a>
                        <div class="dropdown-menu">
                            <div class="user-header">
                                <!--                                <div class="avatar avatar-sm" v-if="$page.props.auth.user.avatar">-->
                                <!--                                    <img :src="$page.props.auth.user.avatar" alt="User Image"-->
                                <!--                                         class="avatar-img rounded-circle">-->

                                <!--                                </div>-->
                                <!--                                <div  v-else>-->

                                <!--                                    <div id="profileImage avatar avatar-sm" >{{ initials }}</div>-->
                                <!--                                </div>-->
                                <div class="user-text">
                                    <h6>{{ $page.props.auth.user.name }}</h6>
                                    <p class="text-muted mb-0">{{ $page.props.auth.user.job }}</p>
                                </div>
                            </div>
                            <Link class="dropdown-item" :href="route('profile.edit')">My Profile</Link>
                            <Link class="dropdown-item"
                                  v-if="$page.props.auth.userRole.includes('project-api') || $page.props.auth.userRole.includes('employer-set-schedule') || $page.props.auth.userRole.includes('send-reminders')"
                                  :href="route('settings.overview')">Settings
                            </Link>
                            <Link class="dropdown-item" method="post" :href="route('logout')">Logout</Link>
                            <!--                            <a href="{{ route('logout') }}" onclick="event.preventDefault(); document.getElementById('logout-form').submit();">Logout</a>-->
                        </div>
                    </li>

                </ul>

            </div>


            <div class="sidebar" id="sidebar">
                <div class="sidebar-inner slimscroll">
                    <div id="sidebar-menu" class="sidebar-menu">
                        <ul>
                            <li class="menu-title">
                                <span>Main Menu</span>
                            </li>
                            <li class="submenu" :class="{'active':$page.component == 'Dashboard'}">
                                <Link :href="route('dashboard')"><i class="feather-grid"></i>
                                    <span> {{
                                            usePage().props.auth.user.lang == 'arabic' ? 'الرئيسية' : 'Dashboard'
                                        }}</span>
                                    <span
                                        class="menu-arrow"></span>
                                </Link>

                            </li>
                            <li class="submenu" v-if="$page.props.auth.userRole.includes('event-calendar')"
                                :class="{'active':$page.component == 'Calendar/Overview'}">
                                <Link :href="route('calendar.overview')"><i class="fas fa-calendar"></i>
                                    <span> {{
                                            usePage().props.auth.user.lang == 'arabic' ? 'التقويم' : 'Calendar'
                                        }}</span>
                                    <span
                                        class="menu-arrow"></span></Link>
                            </li>
                            <li v-if="$page.props.auth.userRole.includes('role-list')" class="submenu"
                                :class="{'active':$page.component == 'Roles/Overview'}">
                                <Link :href="route('roles.index')"><i class="fas fa-list-alt"></i>
                                    <span> {{ usePage().props.auth.user.lang == 'arabic' ? 'الرتب' : 'Roles' }}</span>
                                    <span
                                        class="menu-arrow"></span></Link>
                            </li>
                            <li v-if="$page.props.auth.userRole.includes('user-list')" class="submenu"
                                :class="{'active':$page.component == 'Accounts/Overview'}">
                                <Link :href="route('users.index')"><i class="fas fa-users"></i>
                                    <span> {{
                                            usePage().props.auth.user.lang == 'arabic' ? 'الحسابات' : 'Accounts'
                                        }}</span>
                                    <span
                                        class="menu-arrow"></span></Link>
                            </li>

                            <li v-if="$page.props.auth.userRole.includes('employer-list')" class="submenu"
                                :class="{'active':$page.component == 'Employers/Overview'}">
                                <Link :href="route('employer.overview')"><i class="fas fa-user-tag"></i>
                                    <span>{{
                                            usePage().props.auth.user.lang == 'arabic' ? 'الموظفون' : 'Employers'
                                        }}</span>
                                    <span
                                        class="menu-arrow"></span></Link>
                            </li>
                            <!--                            v-if="$page.props.auth.userRole.includes('employer-list')"-->
                            <li class="submenu" v-if="$page.props.auth.userRole.includes('client-list')"
                                :class="{'active':$page.component == 'Clients/Overview'}">
                                <Link :href="route('client.overview')"><i class="fas fa-clipboard"></i>
                                    <span>{{
                                            usePage().props.auth.user.lang == 'arabic' ? 'الزبائن' : 'Clients'
                                        }}</span>
                                    <span
                                        class="menu-arrow"></span></Link>
                            </li>
                            <li class="submenu" v-if="$page.props.auth.userRole.includes('schedule-edit')"
                                :class="{'active':$page.component == 'Frame/Overview'}">
                                <Link :href="route('frame.overview')"><i class="fas fa-money-bill"></i>
                                    <span>{{ usePage().props.auth.user.lang == 'arabic' ? 'الايطار' : 'Frame' }}</span>
                                    <span
                                        class="menu-arrow"></span></Link>
                            </li>
                            <li class="submenu" v-if="$page.props.auth.userRole.includes('project-list')"
                                :class="{'active':$page.component == 'Projects/Overview'}">
                                <Link :href="route('project.overview')"><i class="fas fa-server"></i>
                                    <span>{{
                                            usePage().props.auth.user.lang == 'arabic' ? 'المشاريع' : 'Projects'
                                        }}</span>
                                    <span
                                        class="menu-arrow"></span></Link>
                            </li>

                            <li class="submenu" v-if="$page.props.auth.userRole.includes('trash-list')"
                                :class="{'active':$page.component == 'Trash'}">
                                <Link :href="route('trash')"><i class="fas fa-trash-restore"></i>
                                    <span> {{
                                            usePage().props.auth.user.lang == 'arabic' ? 'المهملات' : 'Trash'
                                        }}</span>
                                    <span
                                        class="menu-arrow"></span></Link>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>

            <div v-if="$page.props.auth.userRole.includes('schedule-edit')">
                        <v-dialog  v-model="scheduleDialog"
                                   fullscreen
                                   :scrim="false"

                                   transition="dialog-bottom-transition">
           <ShopSchedule @close-dialog="scheduleDialog = false" :include-btn="true"/>
                        </v-dialog>
            </div>
            <div class="page-wrapper">
                <div class="content container-fluid">

                    <div class="page-header">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="page-sub-header">
                                    <h3 class="page-title">
                                        {{
                                            usePage().props.auth.user.lang == 'arabic' ? $page.props.auth.user.name + ' مرحبا' : 'Welcome ' + $page.props.auth.user.name
                                        }}!</h3>
                                    <ul class="breadcrumb">
                                        <li class="breadcrumb-item"><a
                                            href="javascript:void(0)">{{ $page.component }}</a></li>
                                        <li class="breadcrumb-item active">{{ $page.props.auth.user.name }}</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>

                    <slot/>


                    <!--            <div class="row">-->
                    <!--                <div class="col-xl-3 col-sm-6 col-12">-->
                    <!--                    <div class="card flex-fill fb sm-box">-->
                    <!--                        <div class="social-likes">-->
                    <!--                            <p>Like us on facebook</p>-->
                    <!--                            <h6>50,095</h6>-->
                    <!--                        </div>-->
                    <!--                        <div class="social-boxs">-->
                    <!--                            <img src="assets/img/icons/social-icon-01.svg" alt="Social Icon">-->
                    <!--                        </div>-->
                    <!--                    </div>-->
                    <!--                </div>-->
                    <!--                <div class="col-xl-3 col-sm-6 col-12">-->
                    <!--                    <div class="card flex-fill twitter sm-box">-->
                    <!--                        <div class="social-likes">-->
                    <!--                            <p>Follow us on twitter</p>-->
                    <!--                            <h6>48,596</h6>-->
                    <!--                        </div>-->
                    <!--                        <div class="social-boxs">-->
                    <!--                            <img src="assets/img/icons/social-icon-02.svg" alt="Social Icon">-->
                    <!--                        </div>-->
                    <!--                    </div>-->
                    <!--                </div>-->
                    <!--                <div class="col-xl-3 col-sm-6 col-12">-->
                    <!--                    <div class="card flex-fill insta sm-box">-->
                    <!--                        <div class="social-likes">-->
                    <!--                            <p>Follow us on instagram</p>-->
                    <!--                            <h6>52,085</h6>-->
                    <!--                        </div>-->
                    <!--                        <div class="social-boxs">-->
                    <!--                            <img src="assets/img/icons/social-icon-03.svg" alt="Social Icon">-->
                    <!--                        </div>-->
                    <!--                    </div>-->
                    <!--                </div>-->
                    <!--                <div class="col-xl-3 col-sm-6 col-12">-->
                    <!--                    <div class="card flex-fill linkedin sm-box">-->
                    <!--                        <div class="social-likes">-->
                    <!--                            <p>Follow us on linkedin</p>-->
                    <!--                            <h6>69,050</h6>-->
                    <!--                        </div>-->
                    <!--                        <div class="social-boxs">-->
                    <!--                            <img src="assets/img/icons/social-icon-04.svg" alt="Social Icon">-->
                    <!--                        </div>-->
                    <!--                    </div>-->
                    <!--                </div>-->
                    <!--            </div>-->
                </div>
                <footer>
                    <p>Copyright © {{ new Date().getFullYear() }} Jhdevelopers - <a href="#">support</a></p>
                </footer>
            </div>
        </div>
    </div>
</template>
<style scoped>
.rounded-card {
    border-radius: 20px;
}

.time-inputs {
    margin-top: 50px;
//margin: 1.5rem 1rem; padding: 0.5rem 1rem;
}
</style>
