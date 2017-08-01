<?php 

namespace App\Serializer;

use InvalidArgumentException;
use League\Fractal\Pagination\PaginatorInterface;
use League\Fractal\Resource\ResourceInterface;

use League\Fractal\Serializer\JsonApiSerializer;

class JsonApiSerializerV1 extends JsonApiSerializer 
{

    /**
     * Serialize the paginator.
     *
     * @param PaginatorInterface $paginator
     *
     * @return array
     */
    public function paginator(PaginatorInterface $paginator)
    {
        $currentPage = (int)$paginator->getCurrentPage();
        $lastPage = (int)$paginator->getLastPage();

        $pagination = [
            'total' => (int)$paginator->getTotal(),
            'last' => $lastPage,
            'number' => $currentPage,
            'size' => (int)$paginator->getPerPage(),
          //  'count' => (int)$paginator->getCount(),
        ];

        
        $pagination['links'] = [];

        $pagination['links']['self']['href'] = $this->reforbasePagination($paginator->getUrl($currentPage));
        $pagination['links']['first']['href'] = $this->reforbasePagination($paginator->getUrl(1));

        if ($currentPage < $lastPage) {
            $pagination['links']['next']['href'] = $this->reforbasePagination($paginator->getUrl($currentPage + 1));
        }

        if ($currentPage > 1) {
            $pagination['links']['previous']['href'] = $this->reforbasePagination($paginator->getUrl($currentPage - 1));
        }


        $pagination['links']['last']['href'] = $this->reforbasePagination($paginator->getUrl($lastPage));
        

        return ['page' => $pagination];
    }

    /**
     * Serialize the meta.
     *
     * @param array $meta
     *
     * @return array
     */
    public function meta(array $meta)
    {
        if (empty($meta)) {
            return [];
        }

        $result['meta'] = $meta;

        if (array_key_exists('page', $result['meta'])) {
            $result['links'] = $result['meta']['page']['links'];
            unset($result['meta']['page']['links']);
            unset($result['meta']);
            $result['meta'] = $meta;
            unset($result['meta']['page']['links']);
        }

        $result['jsonapi'] = (object) ['version'=>'1.0'];

        return $result;
    }

    /**
     * Serialize an item.
     *
     * @param string $resourceKey
     * @param array $data
     *
     * @return array
     */
    public function item($resourceKey, array $data)
    {
        $id = $this->getIdFromData($data);

        $resource = [
            'data' => [
                'type' => $resourceKey,
                'id' => "$id",
                'attributes' => $data,
            ],
        ];

        unset($resource['data']['attributes']['id']);

        if(isset($resource['data']['attributes']['links'])) {
            $custom_links = $data['links'];
            unset($resource['data']['attributes']['links']);
        }

        if (isset($resource['data']['attributes']['meta'])){
            $resource['data']['meta'] = $data['meta'];
            unset($resource['data']['attributes']['meta']);
        }

        if ($this->shouldIncludeLinks()) {
            $resource['data']['links'] = [
                'self' => ['href'=>"{$this->baseUrl}/$resourceKey/$id"] ,
            ];
            if(isset($custom_links)) {
                $resource['data']['links'] = array_merge($custom_links, $resource['data']['links']);
            }
        }

        return $resource;
    }

    /**
     * reforbase page[number]
     * @return string page[number]
     */
    public function reforbasePageNumber($input)
    {
        return str_replace('page%5Bnumber%5D', 'page[number]', $input);
    }

    /**
     * reforbase page[size]
     * @return string page[size]
     */
    public function reforbasePageSize($input)
    {
        return str_replace('page%5Bsize%5D', 'page[size]', $input);
    }

    /**
     * collect page[size] & page[number]
     * @return string page[size] page[number]
     */
    public function reforbasePagination($input)
    {
        $a = $this->reforbasePageNumber($input);
        $b = $this->reforbasePageSize($a);

        return $b; 
    }
}