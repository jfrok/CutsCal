import {ref} from "vue";

let status = ref(false)

if (/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)) {
     status.value = true
} else {
     status.value = false
}
export const isMobile = status.value
