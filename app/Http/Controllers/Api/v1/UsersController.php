<?php

namespace App\Http\Controllers\Api\v1;

use App\Http\Controllers\Controller;
use App\Models\Access\User\User;
use App\Repositories\Api\v1\UsersRepository;
use Illuminate\Http\Request; 
use App\Http\Requests\Api\v1\Users\IndexRequest;

class UsersController extends Controller
{

    /**
     * @var UsersRepository
     */
    protected $user;

    /**
     * @param UsersRepository $user
     */
    public function __construct(UsersRepository $user)
    {
        $this->user = $user;
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(User $user, IndexRequest $request)
    {
        return $this->user->index($user, $request);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show(User $user, $id, Request $request)
    {
        return $this->user->show($user,$id);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(User $user, Request $request)
    {
        return $this->user->store($user, $request);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(User $user, $id, Request $request)
    {
        return $this->user->update($user, $id, $request);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy(User $user, $id, Request $request)
    {
        return $this->user->destroy($user, $id);
    }
    
    
}