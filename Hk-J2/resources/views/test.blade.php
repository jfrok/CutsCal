<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
    <title>Preskool - Books</title>

    <link rel="shortcut icon" href="assets/img/favicon.png">

    <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,400;0,500;0,700;0,900;1,400;1,500;1,700&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="{{asset('assets/plugins/bootstrap/css/bootstrap.min.css')}}">

{{--    <link rel="stylesheet" href="{{asset('assets/plugins/feather/feather.css')}}">--}}

{{--    <link rel="stylesheet" href="{{asset('assets/plugins/icons/flags/flags.css')}}">--}}

{{--    <link rel="stylesheet" href="{{asset('assets/css/feather.css')}}">--}}

{{--    <link rel="stylesheet" href="{{asset('assets/css/bootstrap-datetimepicker.min.css')}}">--}}

    <link rel="stylesheet" href="{{asset('assets/plugins/fontawesome/css/fontawesome.min.css')}}">
    <link rel="stylesheet" href="{{asset('assets/plugins/fontawesome/css/all.min.css')}}">

{{--    <link rel="stylesheet" href="{{asset('assets/plugins/select2/css/select2.min.css')}}">--}}

    <link rel="stylesheet" href="{{asset('assets/css/style.css')}}">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/dropzone/5.9.3/dropzone.css" integrity="sha512-7uSoC3grlnRktCWoO4LjHMjotq8gf9XDFQerPuaph+cqR7JC9XKGdvN+UwZMC14aAaBDItdRj3DcSDs4kMWUgg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/dropzone/5.9.3/dropzone.min.js" integrity="sha512-U2WE1ktpMTuRBPoCFDzomoIorbOyUv0sP8B+INA3EzNAhehbzED1rOJg6bCqPf/Tuposxb5ja/MAUnC8THSbLQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
</head>
<body>

<div class="container">
    <div class="row">
        <div class="col-md-12">
            <h3>Drag and Drop with Dropzone JS - CamoTutorial.com</h3>
            <h4>Upload Multiple Images</h4>
            <form action="{{ route('testSteamApi') }}">
                @csrf
                <input type="text" name="steamKey">
                <input type="text" name="steamId">
                <button type="submit">Get data</button>
            </form>
        </div>
    </div>
</div>

<script src="{{asset('assets/js/jquery-3.6.0.min.js')}}"></script>

<script src="{{asset('assets/plugins/bootstrap/js/bootstrap.bundle.min.js')}}"></script>

<script src="{{asset('assets/js/feather.min.js')}}"></script>

<script src="{{asset('assets/plugins/slimscroll/jquery.slimscroll.min.js')}}"></script>

<script src="{{asset('assets/js/moment.mi')}}n.js"></script>
<script src="{{asset('assets/plugins/daterangepicker/daterangepicker.js')}}"></script>

<script src="{{asset('assets/plugins/select2/js/select2.min.js')}}"></script>

<script src="{{asset('assets/plugins/bootstrap-tagsinput/js/bootstrap-tagsinput.js')}}"></script>
<script type="text/javascript">


    arr = [5, 2, 7, 1, 0]

    function bubbleSort(arr){
        for (let i = 0; i < arr.length - 1; i++){
            let swapped = false
            for (let j = 0; j < arr.length - i - 1; j++){
                if (arr[j] > arr[j+1]){
                    let temp = arr[j]
                    arr[j] = arr[j+1]
                    arr[j+1] = temp
                    swapped = true
                }
            }
            if(!swapped) break;
        }
        return arr
    }
    console.log("قب : ", arr)
    console.log("بعد: ", bubbleSort(arr))
</script>
{{--<script src="{{asset('assets/js/script.js')}}"></script>--}}
</body>
</html>
