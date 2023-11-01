<?php

use App\Http\Controllers\ProfileController;
use App\Models\Event;
use Carbon\Carbon;
use Illuminate\Support\Facades\Route;
use \App\Http\Controllers\ProjectController;
use App\Http\Controllers\EventController;
use App\Http\Controllers\ContentController;
use App\Http\Controllers\SettingsController;
use Stichoza\GoogleTranslate\GoogleTranslate;
use App\Http\Controllers\UserController;
use App\Http\Controllers\EmployersController;
use App\Http\Controllers\ClientController;
use App\Http\Controllers\FrameController;
use App\Http\Controllers\Controller;
use App\Http\Controllers\ScheduleController;
use App\Http\Controllers\OrderController;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return redirect(\route('login',
        [
//            'canLogin' => Route::has('login'),
//            'canRegister' => Route::has('register'),
//        'laravelVersion' => Application::VERSION,
//        'phpVersion' => PHP_VERSION,
        ]));

});
Route::get('/welcome', function () {
    return view('welcome');

});
Route::get('translate', function () {
    $lang = new GoogleTranslate();
    return GoogleTranslate::trans('Hello again', 'ka', 'en');
});


Route::post('/account/create', [UserController::class, 'createAccount'])->name('account.store');


Route::middleware(['auth', 'check.subscription'])->group(function () {
    Route::resource('roles', \App\Http\Controllers\RoleController::class);
    Route::post('getRoleUsers/{roleName}',[\App\Http\Controllers\RoleController::class,'getRoleUsers'])->name('getRoleUsers');
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');

    Route::post('/updateProfile', [UserController::class, 'updateProfile'])->name('updateProfile');
    Route::post('removeSkill/{skillId}', [UserController::class, 'removeSkill'])->name('removeSkill');
    Route::post('/clearNotifications', [UserController::class, 'clearNotifications'])->name('clearNotifications');
//    Route::post('/account/create', [UserController::class, 'createAccount'])->name('account.create');
    Route::get('/account/overview', [UserController::class, 'index'])->name('users.index');
    Route::get('/dashboard', [\App\Http\Controllers\Controller::class, 'dashboard'])->name('dashboard');

    Route::post('/change-language', [UserController::class, 'changeLanguage']);

    Route::prefix('accounts')->group(function () {
        Route::get('/create', [UserController::class, 'create'])->name('account.create');
        Route::post('/store', [UserController::class, 'store'])->name('account.make');
        Route::get('/overview', [UserController::class, 'index'])->name('account.overview');
        Route::get('/edit/{uId}', [UserController::class, 'edit'])->name('account.edit');
//        Route::post('/store', [UserController::class, 'createAccount'])->name('account.make');
        Route::post('/destroy/{uId}', [UserController::class, 'destroy'])->name('account.destroy');
        Route::post('/groupDelete', [UserController::class, 'groupDelete'])->name('account.groupDelete');
        Route::post('/updateProfileSkills', [UserController::class, 'updateProfileSkills'])->name('updateProfileSkills');
        // Update profile for the authenticated user
//        Route::post('/update', [UserController::class, 'update'])->name('account.update');
        // Update profile for a specific user by providing the uId in the URL
        Route::post('/update/{uId}', [UserController::class, 'update'])->name('account.update');
        Route::post('removeSkill/{skillId}', [UserController::class, 'removeSkill'])->name('removeSkill');
        Route::post('/clearNotifications', [UserController::class, 'clearNotifications'])->name('clearNotifications');
    });
    Route::prefix('employers')->group(function () {
        Route::get('/overview', [EmployersController::class, 'index'])->name('employer.overview');
        Route::get('/create', [EmployersController::class, 'create'])->name('employer.create');
        Route::post('/create', [EmployersController::class, 'createEmployer'])->name('employer.store');
        Route::get('/edit/{eId}', [EmployersController::class, 'edit'])->name('employer.edit');
        Route::post('/update/{eId}', [EmployersController::class, 'update'])->name('employer.update');
        Route::post('/set-mark/', [EmployersController::class, 'setMark'])->name('employer.setMark');
    });
    Route::prefix('clients')->group(function (){
       Route::get('/overview',[ClientController::class,'index'])->name('client.overview');
       Route::post('/create',[ClientController::class,'store'])->name('client.store');
       Route::post('/update/{cId}',[ClientController::class,'update'])->name('client.update');
//       Route::post('/group-destroy/{cId}',[ClientController::class,'destroy'])->name('client.gro.destroy');
        // testing route
        Route::post('/destroy/{cId}',[ClientController::class,'destroy'])->name('client.destroy');
    });
    /// Projects
    Route::prefix('projects')->group(function () {
        Route::get('overview', [ProjectController::class, 'index'])->name('project.overview');
        Route::get('add/{uId}', [ProjectController::class, 'create'])->name('project.add');
        //add
        Route::post('add', [ProjectController::class, 'add'])->name('project.addOne');
        Route::post('delete/{pId}', [ProjectController::class, 'destroy'])->name('project.delete');
        //content
        Route::prefix('content')->group(function () {
            Route::get('show/{pId}', [ContentController::class, 'index'])->name('content.index');
            Route::get('add/{pId}', [ContentController::class, 'add'])->name('content.add');
            Route::get('add-foto/{pId}', [ContentController::class, 'addFoto'])->name('content.addFoto');
            Route::post('add-foto-store/{pId}', [ContentController::class, 'storeFoto'])->name('content.storeFoto');
//            Route::get('store-foto/', [ContentController::class, 'storeFoto'])->name('content.storeFoto');
            Route::post('add-text/{pId}', [ContentController::class, 'create'])->name('content.create');
            Route::get('/edit-text/{cId}', [ContentController::class, 'edit'])->name('content.edit');
            Route::post('/save-text/{cId}', [ContentController::class, 'save'])->name('content.save');
            Route::post('/delete/{cId}', [ContentController::class, 'destroy'])->name('content.delete');
            Route::post('/groupDelete/', [ContentController::class, 'groupDelete'])->name('content.groupDelete');
            Route::get('sort', [ContentController::class, 'editSort'])->name('content.sort');
        });
    });
    /// Calendar
    Route::prefix('calendar')->group(function () {
        Route::get('overview', [EventController::class, 'index'])->name('calendar.overview');
        Route::post('add', [EventController::class, 'add'])->name('calendar.add');
        Route::post('update/{eId}', [EventController::class, 'update'])->name('calendar.update');
        Route::post('remove/{eId}', [EventController::class, 'remove'])->name('calendar.remove');
        Route::get('events', [EventController::class, 'getEvents'])->name('calendar.get');
    });
    //// Notes
    Route::post('/make-note',[Controller::class,'makeNote'])->name('note.make');
    Route::post('/remove-note/{nId}',[Controller::class,'removeNote'])->name('note.remove');

    Route::get('/trash', [Controller::class, 'trash'])->name('trash');
    Route::post('/groupDelete', [Controller::class, 'groupDelete'])->name('trash.groupDelete');
    Route::post('/restore/{pId}', [Controller::class, 'restore'])->name('restore');
    Route::post('/force-delete/{pId}', [Controller::class, 'forceDelete'])->name('forceDelete');
    Route::post('/set-locale', function (Illuminate\Http\Request $request) {
        $locale = $request->input('locale');
        session(['locale' => $locale]); // Store the selected locale in the session
        return response()->json(['success' => true]);
    })->name('setLocale');
    // Settings
    //Route::prefix('settings')->group(function () {
    Route::get('settings', [SettingsController::class, 'settings'])->name('settings.overview');
    Route::post('settings/update-events', [SettingsController::class, 'updateEvents'])->name('settings.eventSettings');
    Route::post('settings/update-token', [SettingsController::class, 'changeToken'])->name('settings.updateToken');
    //});
    Route::prefix('frame')->group(function () {
        Route::get('overview',[FrameController::class, 'index'])->name('frame.overview');
        Route::post('create-services',[FrameController::class, 'createServices'])->name('services.create');
    });
    /// Schedule
     Route::post('/schedule', [ScheduleController::class, 'store'])->name('store.schedule');
     Route::post('/schedule-employer', [ScheduleController::class, 'storeEmployerSchedule'])->name('store.employer-schedule');
     Route::fallback(function () {
        return to_route('dashboard');
     });
});
Route::get('/make-a-reservation/{token}',[FrameController::class, 'edit'])->name('frame.view');
/// Order
Route::post('/order-store', [OrderController::class, 'store'])->name('store.order');

Route::get('/test', function () {
    $endOfTheMonth = Carbon::now()->format('m');
    $eventsForUser = Event::whereMonth('dateFrom', $endOfTheMonth)->get();
    return view('emails.monthly-reminder', compact('eventsForUser'));
});
Route::get('privacy-policy', [\App\Http\Controllers\Controller::class, 'PrivacyPolicy'])->name('PrivacyPolicy');
Route::get('/testApi', [\App\Http\Controllers\Controller::class, 'steamApiTest'])->name('testSteamApi');
require __DIR__ . '/auth.php';
