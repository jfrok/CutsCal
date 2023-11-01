<script setup>
import {Head} from "@inertiajs/vue3";
import GuestLayout from "@/Layouts/GuestLayout.vue";

</script>
<template>
    <Head title="Privacy Policy"/>
    <GuestLayout>

        <h1>Privacy Policy</h1>
        <p>Effective Date: 2023 July 12th</p>
        <div class="terms">
            <h2>Information We Collect</h2>
            <p>When you use the Project, we may collect certain information from you, including:</p>
            <ol>
                <li>Usage Information: We may collect information about how you use the Project, such as the actions you
                    take
                    and the features you access. This information is collected anonymously and is used to improve the
                    functionality and user experience of the Project.
                </li>
            </ol>
        </div>
        <div class="terms">
            <h2>Use of Information</h2>
            <p>We may use the information we collect from you for the following purposes:</p>
            <ol>
                <li>To Improve and Maintain the Project: We may use the information to enhance the Project's
                    functionality,
                    troubleshoot issues, and address user feedback.
                </li>
                <li>To Communicate with You: We may use your contact information to respond to your inquiries, provide
                    technical
                    support, and send you important updates related to the Project.
                </li>
                <li>To Analyze Usage Patterns: We may analyze the information collected to understand how users interact
                    with
                    the Project, identify usage trends, and make informed decisions regarding future improvements.
                </li>
            </ol>
        </div>
        <div class="terms">
            <h2>Sharing of Information</h2>
            <p>We do not sell, trade, or rent your personal information to third parties. However, we may share your
                information
                in the following circumstances:</p>
            <ol>
                <li>Service Providers: We may engage third-party service providers to assist us in operating and
                    maintaining the
                    Project or to perform certain services on our behalf. These service providers have access to your
                    information solely for the purpose of carrying out their services and are obligated to maintain its
                    confidentiality.
                </li>
                <li>Legal Compliance: We may disclose your information if required to do so by law or if we believe that
                    such
                    action is necessary to comply with applicable laws, regulations, or legal processes, or to protect
                    and
                    defend our rights or the rights of others.
                </li>
            </ol>
        </div>
        <div class="terms">
            <h2>Data Retention</h2>
            <p>We will retain your personal information only for as long as necessary to fulfill the purposes outlined
                in this
                Privacy Policy and as required by law. Once the information is no longer needed, we will securely delete
                or
                anonymize it.</p>
        </div>
        <div class="terms">
            <h2>Security</h2>
            <p>We take reasonable precautions to protect the information we collect from loss, misuse, unauthorized
                access,
                disclosure, alteration, and destruction. However, please be aware that no data transmission over the
                internet or
                method of electronic storage is 100% secure. Therefore, we cannot guarantee its absolute security.</p>
        </div>
        <div class="terms">
            <h2>Third-Party Links</h2>
            <p>The Project may contain links to third-party websites or services that are not operated by us. We have no
                control
                over the content or practices of these websites or services, and we are not responsible for their
                privacy
                policies. We encourage you to review the privacy policies of any third-party websites or services you
                visit.</p>
        </div>
<!--        <div class="terms">-->
<!--            <h2>Children's Privacy</h2>-->
<!--            <p>The Project is not intended for individuals under the age of 13. We do not knowingly collect personal-->
<!--                information-->
<!--                from children under 13. If we become aware that we have collected personal information from a child-->
<!--                under the-->
<!--                age of 13, we will take steps to delete it as soon as possible.</p>-->
<!--        </div>-->
        <div class="terms">
            <h2>Changes to This Privacy Policy</h2>
            <p>We may update this Privacy Policy from time to time to reflect changes in our practices or legal
                obligations. We
                encourage you to review this page periodically for any updates. The revised Privacy Policy will be
                effective
                immediately upon posting.</p>
        </div>
        <div class="terms">
            <h2>Contact Us</h2>
            <p>If you have any questions or concerns regarding this Privacy Policy or our privacy practices, please
                contact us
                at <a href="mailto:info@jhdevelopers.eu">contact</a>.</p>
        </div>
        <p>By using the Project, you signify your consent to the terms of this Privacy Policy. If you do not agree with
            the
            terms of this Privacy Policy, please do not use the Project.</p>
        <p>Please note that this Privacy Policy applies only to the Project and not to any other websites, products, or
            services
            you may access through or in connection with the Project.</p>

    </GuestLayout>
</template>
<style>
body {
    font-family: Arial, sans-serif;
    margin: 20px;
    align-content: center;
    padding: 50px 70px;
}

h1 {
    color: #333;
    font-size: 24px;
    margin-bottom: 20px;
}

p {
    color: #666;
    font-size: 16px;
    line-height: 1.5;
}

.terms {
    margin-top: 40px;
}

.terms h2 {
    font-size: 20px;
    color: #333;
    margin-bottom: 10px;
}

.terms p {
    margin-bottom: 10px;
}

.terms ol {
    margin-left: 20px;
}

.terms ol li {
    margin-bottom: 5px;
}
</style>
