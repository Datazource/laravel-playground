<?php

namespace App\Transformers\v1;

use League\Fractal\TransformerAbstract;
use Illuminate\Support\Collection;
use App\Models\Access\User\User;

class UsersTransformer extends TransformerAbstract
{
    public function transform(Users $user)
    {
        return [
                'id'                => (int) $user->id,
                'first_name'        => $user->first_name,
                'last_name'        => $user->last_name,
        ];
    }

}