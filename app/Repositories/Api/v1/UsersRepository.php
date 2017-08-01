<?php

namespace App\Repositories\Api\v1;

use App\Transformers\v1\UsersTransformer;
use App\Models\Access\User\User;

use Illuminate\Support\Facades\DB;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Collection;
use App\Repositories\BaseRepository;
use App\Exceptions\GeneralException; 

/**
 * Class UsersRepository.
 */
class UsersRepository extends BaseRepository
{ 

    /**
     * Associated Repository Model.
     */
    const MODEL = User::class;
    
    /**
     * Return the Eloquent model that will be used
     * to model the JSON API resources.
     *
     * @return \Illuminate\Database\Eloquent\Model
     */
    public function getDataModel()
    {
        return new User();
    }

    /**
     * @return \Illuminate\Http\Response
     */
    public function index(Model $user)
    {
        $success_fetch = $user->jsonPaginate(10);
 
        if ( $success_fetch ) {
            return $this->response->paginator( $success_fetch, new UsersTransformer(), ['key'=>'users'] );
        }
        
        return $this->response->errorBadRequest();
    }

    /**
     * @return \Illuminate\Http\Response
     */
    public function show(Model $user, $id)
    {
        $success_find = $user::find($id);
        
        if ( $success_find )  {
            return $this->response->item( $success_find, new UsersTransformer(), ['key'=>'user_master']);
        }

        return $this->response->errorNotFound();
    }

    /**
     * @return \Illuminate\Http\Response
     */
    public function update(Model $user, $id, $request)
    {
        $this->valueHack($request);
        $success_update = $user::find($id)->update($this->preparedData($request));
        
        if ( $success_update )  {
            return $this->response->item( $user::find($id), new UsersTransformer(), ['key'=>'user_master']);
        }

        return $this->response->errorNotFound();
    }
    /**
     * @param object $request
     */
    public function store(Model $user, $request)
    {
        $this->valueHack($request);
        $success_create = $user::create($this->preparedData($request));
        if ( $success_create ) {
            return $this->response->item( $success_create, new UsersTransformer(), ['key'=>'user_master']);
        }

        return $this->response->errorBadRequest();
    }

    /**
     * @return \Illuminate\Http\Response
     */
    public function destroy(Model $user, $id)
    {
        $success_find = $user::find($id);

        if ( $success_find ) {
            $success_delete = $success_find->delete();
            if ( $success_delete )  return $this->response->noContent();
        }

        return $this->response->errorNotFound();
    }

}
