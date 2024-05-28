<template>
    <div class="text-body-2 font-weight-light">
            Enter the code we just sent to your E-mail <span class="font-weight-black text-primary">{{ email }}</span></div>
    <div class="d-flex gap-8 flex-column align-center">
        <v-otp-input
            class="mt-3 ms-n2"
            length="4"
            placeholder="0"
            variant="underlined"
            v-model="code"
        ></v-otp-input>

        <div class="text-danger" v-if="code.length == 4 && message">
            {{message}}
        </div>
    </div>

        <v-divider class="mt-3 mb-6"></v-divider>

        <div class="mb-3 text-body-2">
            Need another <strong>code</strong>?
        </div>

        <v-btn
            @click="resendOtp"
            color="primary"
            size="small"
            text="Re-send Email"
            variant="tonal"

        ></v-btn>

</template>
<script>
import axios from "axios";
export default {
    props:{
        email:String,
        message:String,
    },
    data(){
        return{
            code:'',
            status:false,
        }
    },
    watch:{
      code(val){
          this.$emit('otp',val)
      },
        // status(val){
        //     if (val.verified == true){
        //         this.$emit('status',true)
        //     }
        //   if (val.verified == false){
        //       this.resendOtp()
        //   }
        // }
    },
    methods:{
        isOtpVerified(){
            axios.post(route('otp.check'), {
                email: this.email
            }).then((res) => {
                if (res.data.verified == false){
                    this.resendOtp()
                }
                this.status = res.data
            }).catch((err) => {
                if (err.response.data.status == 909) {
                        this.resendOtp()
                }
            })
        },
        resendOtp() {
            axios.post(route('otp.resend'), {
                email: this.email
            }).then((res) => {
                // this.status = res.data.message
            })
        },
    },
    mounted() {
        // this.isOtpVerified()
        this.resendOtp()
    }
}
</script>
