<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title inertia>{{ config('app.name', 'CutCal') }}</title>
        <link rel="manifest" href="{{asset('../manifest.json')}}">
        <!-- Chrome for Android theme color -->
        <meta name="theme-color" content="#000000">

        <!-- Add to homescreen for Chrome on Android -->
        <meta name="mobile-web-app-capable" content="yes">
        <meta name="application-name" content="Jhdevelopers">
        <link rel="icon" sizes="512x512" href="{{asset('/images/icons/4.jpg')}}">

        <!-- Add to homescreen for Safari on iOS -->
        <meta name="apple-mobile-web-app-capable" content="yes">
        <meta name="apple-mobile-web-app-status-bar-style" content="black">
        <meta name="apple-mobile-web-app-title" content="Jhdevelopers">
        <link rel="apple-touch-icon" href="{{asset('../images/icons/9.png')}}">

        <link href="{{asset('../images/icons/splash-640x1136.png" media="(device-width: 320px) and (device-height: 568px) and (-webkit-device-pixel-ratio: 2)" rel="apple-touch-startup-image')}}"/>
        <link href="{{asset('../images/icons/splash-750x1334.png" media="(device-width: 375px) and (device-height: 667px) and (-webkit-device-pixel-ratio: 2)" rel="apple-touch-startup-image')}}"/>
        <link href="{{asset('../images/icons/splash-1242x2208.png" media="(device-width: 621px) and (device-height: 1104px) and (-webkit-device-pixel-ratio: 3)" rel="apple-touch-startup-image')}}" />
        <link href="{{asset('../images/icons/splash-1125x2436.png" media="(device-width: 375px) and (device-height: 812px) and (-webkit-device-pixel-ratio: 3)" rel="apple-touch-startup-image')}}" />
        <link href="{{asset('../images/icons/splash-828x1792.png" media="(device-width: 414px) and (device-height: 896px) and (-webkit-device-pixel-ratio: 2)" rel="apple-touch-startup-image')}}"/>
        <link href="{{asset('../images/icons/splash-1242x2688.png" media="(device-width: 414px) and (device-height: 896px) and (-webkit-device-pixel-ratio: 3)" rel="apple-touch-startup-image')}}" />
        <link href="{{asset('../images/icons/splash-1536x2048.png" media="(device-width: 768px) and (device-height: 1024px) and (-webkit-device-pixel-ratio: 2)" rel="apple-touch-startup-image')}}" />
        <link href="{{asset('../images/icons/splash-1668x2224.png" media="(device-width: 834px) and (device-height: 1112px) and (-webkit-device-pixel-ratio: 2)" rel="apple-touch-startup-image')}}" />
        <link href="{{asset('../images/icons/splash-1668x2388.png" media="(device-width: 834px) and (device-height: 1194px) and (-webkit-device-pixel-ratio: 2)" rel="apple-touch-startup-image')}}" />
        <link href="{{asset('../images/icons/splash-2048x2732.png" media="(device-width: 1024px) and (device-height: 1366px) and (-webkit-device-pixel-ratio: 2)" rel="apple-touch-startup-image')}}" />

        <!-- Tile for Win8 -->
        <meta name="msapplication-TileColor" content="#ffffff">
{{--        <meta name="msapplication-TileImage" content="{{asset('/images/icons/5-512x512.png')}}">--}}

{{--        <link rel="shortcut icon" href="assets/img/favicon.png">--}}
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Comfortaa:wght@600;700&display=swap" rel="stylesheet">

        <link rel="stylesheet" href="{{asset('assets/plugins/bootstrap/css/bootstrap.min.css')}}">
        <link rel="stylesheet" href="{{asset('assets/plugins/feather/feather.css')}}">
        <link rel="stylesheet" href="{{asset('assets/plugins/fontawesome/css/fontawesome.min.css')}}">
        <link rel="stylesheet" href="{{asset('assets/plugins/fontawesome/css/all.min.css')}}">

        <link rel="stylesheet" href="{{asset('assets/css/style.css')}}">
        <link href="{{asset('assets/scss/main.scss')}}">
        <link href="https://cdn.jsdelivr.net/npm/@mdi/font@5.x/css/materialdesignicons.min.css" rel="stylesheet">

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bs-stepper/dist/css/bs-stepper.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css" integrity="sha512-3pIirOrwegjM6erE5gPSwkUzO+3cTjpnV9lexlNZqvupR64iZBnOOTiiLPb9M36zpMScbmUNIcHUqKD47M719g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <!-- Scripts -->
{{--        <meta name="viewport" content="initial-scale=1.0,user-scalable=no,maximum-scale=1,width=device-width" />--}}
{{--        <script>--}}
{{--            (function(h,o,t,j,a,r){--}}
{{--                h.hj=h.hj||function(){(h.hj.q=h.hj.q||[]).push(arguments)};--}}
{{--                h._hjSettings={hjid:3525860,hjsv:6};--}}
{{--                a=o.getElementsByTagName('head')[0];--}}
{{--                r=o.createElement('script');r.async=1;--}}
{{--                r.src=t+h._hjSettings.hjid+j+h._hjSettings.hjsv;--}}
{{--                a.appendChild(r);--}}
{{--            })(window,document,'https://static.hotjar.com/c/hotjar-','.js?sv=');--}}
{{--        </script>--}}
        @routes
        @vite(['resources/js/app.js', "resources/js/Pages/{$page['component']}.vue"])
        @inertiaHead
    </head>
    <body>
        @inertia

        <script>
            const items = document.querySelectorAll('.list-item');

            items.forEach(item => {

                item.addEventListener('touchstart', e => {

                    e.target.dataset.x = Number(e.touches[0].pageX) + Number(e.target.dataset.move) || 0;

                });

                item.addEventListener('touchmove', e => {

                    let moveX = Number(e.target.dataset.x) - e.touches[0].pageX;

                    moveX > 130 ? moveX = 130 : null;
                    moveX < -130 ? moveX = -130 : null;

                    e.target.dataset.move = moveX;

                    anime({
                        targets: e.target,
                        translateX: -Number(e.target.dataset.move),
                        duration: 300
                    });

                });

                item.addEventListener('touchend', e => {

                    let elementMove = e.target.dataset.move;

                    if (elementMove > 100)
                        elementMove = 100;
                    else if (elementMove < -100)
                        elementMove = -100;
                    else
                        elementMove = 0;

                    items.forEach(item => {

                        let content = item.querySelector('.list-content');

                        if (content === e.target) {
                            return null;
                        }

                        content.dataset.x = 0;
                        content.dataset.move = 0;

                        anime({
                            targets: content,
                            translateX: 0
                        });

                    });

                    setTimeout(() => {

                        anime({
                            targets: e.target,
                            translateX: -Number(elementMove)
                        });

                    }, 1);

                });

            });

        </script>
        <script>
            const stepButtons = document.querySelectorAll('.step-button');
            const progress = document.querySelector('#progress');

            Array.from(stepButtons).forEach((button,index) => {
                button.addEventListener('click', () => {
                    progress.setAttribute('value', index * 100 /(stepButtons.length - 1) );//there are 3 buttons. 2 spaces.

                    stepButtons.forEach((item, secindex)=>{
                        if(index > secindex){
                            item.classList.add('done');
                        }
                        if(index < secindex){
                            item.classList.remove('done');
                        }
                    })
                })
            })
        </script>
        <script src="{{asset('assets/plugins/bootstrap/js/bootstrap.bundle.min.js')}}"></script>
        <script src="{{asset('assets/js/feather.min.js')}}"></script>
{{--        <script src="http://momentjs.com/downloads/moment-with-locales.min.js"></script>--}}
{{--        <script src="https://raw.githubusercontent.com/xsoh/moment-hijri/master/moment-hijri.js"></script>--}}
        <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
        <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
        <script src="{{asset('assets/js/script.js')}}"></script>
        <script src="https://unpkg.com/dropzone@5/dist/min/dropzone.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js" integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    </body>
</html>
