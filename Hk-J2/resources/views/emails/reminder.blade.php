<html lang="ar">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Email Template</title>
    <style>
        /* Reset styles for better compatibility */
        body,
        body * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            direction: rtl;
            font-family: Arial, sans-serif;
            line-height: 1.4;
            display: flex;
            justify-content: center;
            background-color: #f5f5f5;
        }

        /* Main container */
        .container {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
        }

        /* Header */
        .header {
            text-align: center;
            padding-bottom: 20px;
        }

        /* Body */
        .body {
            padding: 20px 0;
        }

        /* Footer */
        .footer {
            text-align: center;
            padding-top: 20px;
        }
    </style>
</head>

<body>
@php($user = \App\Models\User::find($event->userId))
<div class="container">
    <div class="header">
        <h1>رساله تذكير</h1>
    </div>
    <div class="body">
        @if($user->id == 39)
            <h1> هاذه مواعيدك ويلا دزها</h1>
        @endif
        <h4> مرحبا , {{$user->name}} </h4>
        <h3> العنوان: {{ $event->title }} </h3>
        <h3> التاريخ: {{ $event->dateFrom }} </h3>

        <h3>هاذه قائمه المواعيد القريبه.</h3>

        <h4>Thank you!</h4>
    </div>
    <div class="footer">
        <p>&copy; 2023 JHdevelopers. All rights reserved.</p>
    </div>
</div>
</body>

</html>
