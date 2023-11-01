<?php

namespace App\Http\Controllers;

use App\Models\Client;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class ClientController extends Controller
{
    public function index()
    {
        $clients = Client::where('userId',Auth::id())->orderBy('created_at', 'DESC')->paginate(10);
        return inertia('Clients/Overview', ['clients' => $clients]);
    }

    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|email|unique:clients,client_email|max:255',
            'phone' => 'required|string|max:255',
            'notes' => 'nullable|string|max:255',
        ]);
//        dd($request->all());
        $new = new Client();

        $new->client_name = $request->name;
        $new->client_email = $request->email;
        $new->client_phone = $request->phone;
        $new->client_notes = $request->notes;
        $new->userId = Auth::id();

        $new->save();

        return redirect()->route('client.overview')->with('message', 'The Clients has been created successfully');
    }

    public function update($cId, Request $request)
    {
        $findClient = Client::where('client_id', $cId)->first();
        $emailChecker = 'required|email|max:255';
        if ($findClient) {
            if (Client::where('client_email', $request->email)->exists() && $request->email != $findClient->client_email) {
                $emailChecker = 'required|email|unique:clients,client_email|max:255';
            }
            $request->validate([
                'name' => 'required|string|max:255',
                'email' => $emailChecker,
                'phone' => 'required|string|max:255',
                'notes' => 'nullable|string|max:255',
            ]);

            Client::where('client_id', $cId)->update(['client_name' => $request->name,
                'userId' => Auth::id(),
                'client_email' => $request->email,
                'client_phone' => $request->phone,
                'client_notes' => $request->notes]);

            return redirect()->route('client.overview')->with('message', 'The Clients has been edited successfully');
        }
        return redirect()->route('client.overview')->with('error', 'Ops something wrong');
    }

    public function destroy($cId, Request $request)
    {

        if ($request->id != null) {
            Client::whereIn('client_id', $request->id)->delete();
            return redirect()->route('client.overview')->with('message', 'The Clients has been deleted successfully');
        }

        $client = Client::where('client_id', (int)$cId);
        if ($client) {
            $client->delete();
            return redirect()->route('client.overview')->with('message', 'The Clients has been deleted successfully');
        }

        return redirect()->route('client.overview')->with('error', 'Ops something wrong');

    }
}
