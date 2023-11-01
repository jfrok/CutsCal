<?php

namespace Tests\Feature;

use App\Mail\ReminderEmail;
use App\Models\Event;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Illuminate\Support\Facades\Auth;

use Illuminate\Support\Facades\Mail;
use Tests\TestCase;

class ReminderEmailTest extends TestCase
{
    /**
     * A basic feature test example.
     */
    public function test_example(): void
    {
        $response = $this->get('/');

        $response->assertStatus(200);
    }
    public function testReminderEmail()
    {
        Mail::fake();

        // Call the code that sends the reminder email
        // ...
        $user = User::find(Auth::Id());
        $events = Event::where('dateFrom','>', Carbon::today())->get();

        // Send reminder email to each user
//        foreach ($users as $user) {
        if ($events){
//            Mail::to($user->email)->send(new ReminderEmail());

        Mail::assertSent(ReminderEmail::class, function ($mail) use ($user) {
            return $mail->user->id === $user->id;
        });
        }

    }
    public function testSendReminders()
    {
        $reminder = ReminderEmail::factory()->create(['dateFrom' => now()->addDays(3)]);
        $this->artisan('send:reminders')
            ->assertExitCode(0);
        $this->assertDatabaseHas('reminders', ['id' => $reminder->id, 'reminder_sent' => true]);
        Mail::assertSent(ReminderEmail::class, function ($mail) use ($reminder) {
            return $mail->hasTo($reminder->email) && $mail->reminder->is($reminder);
        });
    }

}
